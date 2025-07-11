import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clinicapp/core/assets/assets.gen.dart';
import 'package:flutter_clinicapp/core/components/spaces.dart';
import 'package:flutter_clinicapp/core/constants/colors.dart';
import 'package:flutter_clinicapp/core/extensions/build_context_ext.dart';
import 'package:flutter_clinicapp/presentation/chat/widgets/card_chat_list.dart';
import 'package:flutter_clinicapp/presentation/doctor/chat/models/chat_doctor_model.dart';

class ChatListPage extends StatelessWidget {
  ChatListPage({super.key});
  final List<ChatDoctorModel> chatDoctor = [
    ChatDoctorModel(
        name: 'Sintia',
        message: 'Halo Dok, saya mau konsultasi, nih',
        time: '10:00',
        avatarUrl: Assets.images.doctorVidcall2.path,
        countMessage: '1',
        isActive: true),
    ChatDoctorModel(
        name: 'dr. Listya Kusumastuti',
        message: 'Halo Dok, saya mau konsultasi, nih',
        time: '10:00',
        avatarUrl: Assets.images.doctorVidcall2.path,
        countMessage: '4',
        isActive: true),
  ];
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
                  SpaceWidth(context.deviceWidth * 0.18),
                  const Text(
                    "Chat Premium",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SpaceHeight(14),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: chatDoctor.length,
              separatorBuilder: (BuildContext context, int index) {
                return const SpaceHeight(16);
              },
              itemBuilder: (BuildContext context, int index) {
                return CardChatList(
                  chatDoctor: chatDoctor[index],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
