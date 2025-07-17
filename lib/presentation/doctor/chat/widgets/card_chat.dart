// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_clinicapp/core/assets/assets.gen.dart';

import 'package:flutter_clinicapp/core/components/spaces.dart';
import 'package:flutter_clinicapp/core/constants/colors.dart';
import 'package:flutter_clinicapp/core/extensions/build_context_ext.dart';
import 'package:flutter_clinicapp/data/datasources/firebase_datasource.dart';
import 'package:flutter_clinicapp/data/models/response/order_response_model.dart';
import 'package:flutter_clinicapp/data/models/response/user_model.dart';
import 'package:flutter_clinicapp/presentation/chat/pages/room_chat_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CardChat extends StatefulWidget {
  final OrderModel model;
  const CardChat({
    super.key,
    required this.model,
  });

  @override
  State<CardChat> createState() => _CardChatState();
}

class _CardChatState extends State<CardChat> {
  UserModel? partner;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    partner = await FirebaseDatasource.instance
        .getUserByEmail(widget.model.patient?.email ?? '-');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (partner != null) {
          log("Partner is not null: ${partner!.id} ${partner!.toJson()}  |${widget.model.patient?.email}");
          context.push(
            RoomChatPage(
              partner: partner!,
              order: widget.model,
            ),
          );
        } else {
          log("Partner is null: ${partner} ${widget.model.patient?.email}");
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        width: context.deviceWidth,
        decoration: BoxDecoration(
          color: const Color(
            0xffF5F5F5,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              "09:12",
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: Color(
                  0xffA7A6A5,
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Stack(
                  children: [
                    widget.model.patient?.image != null
                        ? CircleAvatar(
                            radius: 24.0,
                            backgroundImage: NetworkImage(
                              widget.model.patient?.image
                                          ?.contains('googleusercontent.com') ==
                                      true
                                  ? widget.model.patient!.image!
                                  : '${dotenv.env['BASE_URL']}${widget.model.patient?.image}',
                            ),
                          )
                        : Image.asset(
                            Assets.images.doctorVidcall2.path,
                            width: 36.0,
                            height: 36.0,
                            fit: BoxFit.cover,
                          ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                          color: const Color(0xff66CA98),
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1.0,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SpaceWidth(
                  8,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.model.patient?.name ?? '-',
                        style: const TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const Text(
                        "Last Message",
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          color: Color(
                            0xffB0BEC3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SpaceWidth(8),
                Container(
                  height: 18,
                  width: 18,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(
                      0xffFF6C52,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "2",
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                )
                // model.isActive
                //     ? Container(
                //         height: 18,
                //         width: 18,
                //         decoration: const BoxDecoration(
                //           shape: BoxShape.circle,
                //           color: Color(
                //             0xffFF6C52,
                //           ),
                //         ),
                //         child: Center(
                //           child: Text(
                //             model.countMessage,
                //             style: const TextStyle(
                //               fontSize: 12.0,
                //               fontWeight: FontWeight.w500,
                //               color: AppColors.white,
                //             ),
                //           ),
                //         ),
                //       )
                //     : const SizedBox(),
              ],
            ),
            const SpaceHeight(
              12,
            ),
          ],
        ),
      ),
    );
  }
}
