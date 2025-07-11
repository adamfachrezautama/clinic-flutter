import 'dart:developer';

import 'package:flutter_clinicapp/presentation/chat/blocs/bloc/chat_expired_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_clinicapp/core/components/spaces.dart';
import 'package:flutter_clinicapp/core/constants/colors.dart';
import 'package:flutter_clinicapp/core/extensions/build_context_ext.dart';
import 'package:flutter_clinicapp/data/datasources/firebase_datasource.dart';
import 'package:flutter_clinicapp/data/models/response/channel_model.dart';
import 'package:flutter_clinicapp/data/models/response/message_model.dart';
import 'package:flutter_clinicapp/data/models/response/order_response_model.dart';
import 'package:flutter_clinicapp/data/models/response/user_model.dart';
import 'package:flutter_clinicapp/presentation/chat/widgets/chat_bubble.dart';

class RoomChatPage extends StatefulWidget {
  final OrderModel order;
  final UserModel partner;
  const RoomChatPage({
    super.key,
    required this.order,
    required this.partner,
  });

  @override
  State<RoomChatPage> createState() => _RoomChatPageState();
}

class _RoomChatPageState extends State<RoomChatPage> {
  final currentUser = FirebaseAuth.instance.currentUser;
  final TextEditingController _messageController = TextEditingController();
  void sendMessage() async {
    if (_messageController.text.trim().isEmpty) {
      return;
    }

    final channel = Channel(
      id: generateChannelId(
          currentUser!.uid, widget.partner.id, widget.order.schedule!),
      memberIds: [currentUser!.uid, widget.partner.id],
      members: [UserModel.fromFirebaseUser(currentUser!), widget.partner],
      lastMessage: _messageController.text.trim(),
      sendBy: currentUser!.uid,
      lastTime: Timestamp.now(),
      unRead: {
        currentUser!.uid: false,
        widget.partner.id: true,
      },
    );

    await FirebaseDatasource.instance
        .updateChannel(channel.id, channel.toMap());

    var docRef = FirebaseFirestore.instance.collection('messages').doc();
    var message = Message(
      id: docRef.id,
      textMessage: _messageController.text.trim(),
      senderId: currentUser!.uid,
      sendAt: Timestamp.now(),
      channelId: channel.id,
      type: 'text',
    );
    FirebaseDatasource.instance.addMessage(message);

    var channelUpdateData = {
      'lastMessage': message.textMessage,
      'sendBy': currentUser!.uid,
      'lastTime': message.sendAt,
      'unRead': {
        currentUser!.uid: false,
        widget.partner.id: true,
      },
    };
    FirebaseDatasource.instance.updateChannel(channel.id, channelUpdateData);

    _messageController.clear();
  }

  @override
  void initState() {
    super.initState();
    checkExpired();
  }

  checkExpired() {
    final channelId = generateChannelId(
        currentUser!.uid, widget.partner.id, widget.order.schedule!);
    log("CHANNEL ID: $channelId");

    context.read<ChatExpiredBloc>().add(ChatExpiredEvent.expired(channelId));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xff1469F0),
      statusBarBrightness: Brightness.dark,
    ));
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: context.deviceWidth,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.secondary,
                    Color(0xff1469F0),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.white,
                    ),
                  ),
                  // SpaceWidth(context.deviceWidth * 0.1),
                  // CircleAvatar(
                  //   backgroundColor: AppColors.gray,
                  //   child: Image.asset(
                  //     Assets.images.doctor1.path,
                  //     width: 200.0,
                  //     height: 200.0,
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  const SpaceWidth(8),
                  Expanded(
                    child: Text(
                      widget.partner.userName,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SpaceHeight(12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: StreamBuilder<List<Message>>(
                        stream: FirebaseDatasource.instance.messageStream(
                            generateChannelId(widget.partner.id,
                                currentUser!.uid, widget.order.schedule!)),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          final List<Message> messages = snapshot.data ?? [];
                          if (messages.isEmpty) {
                            return const Center(
                              child: Text('No message found'),
                            );
                          }
                          return ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(
                                parent: BouncingScrollPhysics()),
                            reverse: true,
                            padding: const EdgeInsets.all(10),
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              final message = messages[index];
                              return ChatBubble(
                                partner: widget.partner,
                                direction: message.senderId == currentUser!.uid
                                    ? Direction.right
                                    : Direction.left,
                                message: message.textMessage,
                                type: BubbleType.alone,
                                clock: message.sendAt.toDate().toString(),
                              );
                            },
                          );
                        }),
                  ),
                  BlocBuilder<ChatExpiredBloc, ChatExpiredState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () {
                          return SizedBox.shrink();
                        },
                        loading: () {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        success: (isExpired) {
                          log("isExpired: $isExpired");
                          if (isExpired) {
                            return Container(
                              padding: const EdgeInsets.all(16),
                              color: AppColors.disable,
                              child: Center(
                                child: Text(
                                  'Sesi chat telah berakhir',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Container(
                              width: context.deviceWidth,
                              height: 80.0,
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 234, 242, 242),
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                      child: Row(
                                        children: [
                                          const SpaceWidth(16),
                                          Expanded(
                                            child: TextField(
                                              decoration: InputDecoration(
                                                hintText: "Type a message",
                                                border: InputBorder.none,
                                              ),
                                              controller: _messageController,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              if (_messageController
                                                  .text.isNotEmpty) {
                                                sendMessage();
                                              }
                                            },
                                            child: const Icon(
                                              Icons.send,
                                              color: AppColors.primary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SpaceWidth(16),
                                ],
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
