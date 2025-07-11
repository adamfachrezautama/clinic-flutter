import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clinicapp/core/components/spaces.dart';
import 'package:flutter_clinicapp/core/constants/colors.dart';
import 'package:flutter_clinicapp/core/extensions/build_context_ext.dart';

class RoomChatDoctorPage extends StatelessWidget {
  const RoomChatDoctorPage({super.key});

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
                  SpaceWidth(context.deviceWidth * 0.275),
                  const Text(
                    "Sinta",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SpaceHeight(12),
            const Center(
              child: Text(
                "16, November 2024",
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            const SpaceHeight(12),
            // const Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 16),
            //   child: ChatBubble(
            //     direction: Direction.left,
            //     message: 'Halo Dok, saya mau konsultasi, nih',
            //     type: BubbleType.top,
            //   ),
            // ),
            // const SpaceHeight(20),
            // const Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 16),
            //   child: ChatBubble(
            //     direction: Direction.right,
            //     message: 'Halo kak, senang hati membantu',
            //     type: BubbleType.top,
            //   ),
            // ),
            // const SpaceHeight(20),
            // const Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 16),
            //   child: ChatBubble(
            //     direction: Direction.left,
            //     message: 'mual-mual dan pusing kenapa, ya?',
            //     type: BubbleType.top,
            //   ),
            // ),
            // const SpaceHeight(20),
            // const Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 16),
            //   child: ChatBubble(
            //     direction: Direction.left,
            //     message: 'sudah bebrapa hari ini dirasa',
            //     type: BubbleType.top,
            //     clock: "21.45 WIB",
            //   ),
            // ),

            const Spacer(),
            // Container(
            //   width: context.deviceWidth,
            //   height: 80.0,
            //   padding: const EdgeInsets.all(16.0),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: Container(
            //           padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //           decoration: BoxDecoration(
            //             color: const Color.fromARGB(255, 234, 242, 242),
            //             borderRadius: BorderRadius.circular(16.0),
            //           ),
            //           child: Row(
            //             children: [
            //               const SpaceWidth(16),
            //               const Expanded(
            //                 child: TextField(
            //                   decoration: InputDecoration(
            //                     hintText: "Type a message",
            //                     border: InputBorder.none,
            //                   ),
            //                 ),
            //               ),
            //               GestureDetector(
            //                 onTap: () {},
            //                 child: const Icon(
            //                   Icons.send,
            //                   color: AppColors.primary,
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //       const SpaceWidth(16),
            //       GestureDetector(
            //           onTap: () {}, child: const Icon(Icons.camera_alt)),
            //       const SpaceWidth(16),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
