// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_clinicapp/core/components/buttons.dart';
import 'package:flutter_clinicapp/core/components/custom_text_field.dart';
import 'package:flutter_clinicapp/core/components/custom_text_field_height.dart';
import 'package:flutter_clinicapp/core/components/spaces.dart';
import 'package:flutter_clinicapp/core/constants/colors.dart';
import 'package:flutter_clinicapp/core/extensions/build_context_ext.dart';
import 'package:flutter_clinicapp/data/datasources/firebase_datasource.dart';
import 'package:flutter_clinicapp/data/models/response/channel_model.dart';
import 'package:flutter_clinicapp/data/models/response/message_model.dart';
import 'package:flutter_clinicapp/data/models/response/order_response_model.dart';
import 'package:flutter_clinicapp/data/models/response/user_model.dart';
import 'package:flutter_clinicapp/presentation/chat/pages/room_chat_page.dart';

class ChatWithDoctorPage extends StatefulWidget {
  final OrderModel order;
  const ChatWithDoctorPage({
    super.key,
    required this.order,
  });

  @override
  State<ChatWithDoctorPage> createState() => _ChatWithDoctorPageState();
}

class _ChatWithDoctorPageState extends State<ChatWithDoctorPage> {
  UserModel? partner;

  final currentUser = FirebaseAuth.instance.currentUser;
  TextEditingController? _nameController;
  TextEditingController? _messageController;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: currentUser!.displayName);
    _messageController = TextEditingController();
    loadData();
  }

  loadData() async {
    partner = await FirebaseDatasource.instance.getUserByEmail(
      widget.order.doctor!.email!,
    );
    setState(() {});
  }

  void sendMessage() async {
    if (_messageController!.text.trim().isEmpty) {
      return;
    }

    final channel = Channel(
      id: generateChannelId(
          currentUser!.uid, partner!.id, widget.order.schedule!),
      memberId: [currentUser!.uid, partner!.id],
      members: [UserModel.fromFirebaseUser(currentUser!), partner!],
      lastMessage: _messageController!.text.trim(),
      sendBy: currentUser!.uid,
      lastTime: Timestamp.now(),
      unRead: {
        currentUser!.uid: false,
        partner!.id: true,
      },
    );

    await FirebaseDatasource.instance
        .updateChannel(channel.id, channel.toMap());

    var docRef = FirebaseFirestore.instance.collection('messages').doc();
    var message = Message(
      id: docRef.id,
      textMessage: _messageController!.text.trim(),
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
        partner!.id: true,
      },
    };
    FirebaseDatasource.instance.updateChannel(channel.id, channelUpdateData);

    _messageController!.clear();
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
        child: ListView(
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
                  SpaceWidth(context.deviceWidth * 0.1),
                  const Text(
                    "Chat bersama Dokter",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SpaceHeight(32),
            Container(
              margin: const EdgeInsets.all(20.0),
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 20,
              ),
              width: context.deviceWidth,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x19000000),
                    blurRadius: 24,
                    offset: Offset(0, 11),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Pasien",
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  const SpaceHeight(
                    8,
                  ),
                  CustomTextField(
                    controller: _nameController!,
                    label: '',
                    readOnly: true,
                  ),
                  const SpaceHeight(
                    20,
                  ),
                  const Text(
                    "Pertanyaan",
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  const SpaceHeight(
                    8,
                  ),
                  CustomTextFieldHeight(
                    controller: _messageController!,
                    label: 'Tulis Pertanyaan Anda',
                  ),
                  const SpaceHeight(
                    20,
                  ),
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text:
                              'Dengan menfirimi peprtanyaan, Anda menyetujui ',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: 'kebijakan privasi',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                          ),
                        ),
                        TextSpan(
                          text: ' dan ',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: 'ketentuan layanan',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                          ),
                        ),
                        TextSpan(
                          text: ' aplikasi “Ayo Sehat”.',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SpaceHeight(
                    20,
                  ),
                  Button.filled(
                    onPressed: () {
                      sendMessage();
                      context.push(RoomChatPage(
                        partner: partner!,
                        order: widget.order,
                      ));
                    },
                    label: 'Mulai Chat',
                    color: AppColors.primary,
                    height: 48,
                    borderRadius: 8,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
