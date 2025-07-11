// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_clinicapp/core/components/spaces.dart';
import 'package:flutter_clinicapp/core/constants/colors.dart';
import 'package:flutter_clinicapp/core/extensions/build_context_ext.dart';
import 'package:flutter_clinicapp/presentation/doctor/chat/models/chat_doctor_model.dart';

class CardChatList extends StatelessWidget {
  final ChatDoctorModel chatDoctor;
  const CardChatList({
    super.key,
    required this.chatDoctor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // context.push(const RoomChatPage());
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        padding: const EdgeInsets.all(16.0),
        width: context.deviceWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.0),
          color: const Color(
            0xffF5F5F5,
          ),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.asset(
                      chatDoctor.avatarUrl,
                      width: 40.0,
                      height: 48.0,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 8,
                        width: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xff66CA98),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
                const SpaceWidth(8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chatDoctor.name,
                      style: const TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      chatDoctor.spesialis ?? "",
                      style: const TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffB0BEC3),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  chatDoctor.time,
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    color: Color(0xffB0BEC3),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SpaceWidth(
                  48,
                ),
                Expanded(
                  child: Text(
                    chatDoctor.message,
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffB0BEC3),
                    ),
                  ),
                ),
                const SpaceWidth(8),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                    color: Color(0xffFF6C52),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    chatDoctor.countMessage,
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
