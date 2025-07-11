import 'package:flutter/material.dart';
import 'package:flutter_clinicapp/core/assets/assets.gen.dart';
import 'package:flutter_clinicapp/core/components/spaces.dart';
import 'package:flutter_clinicapp/core/constants/colors.dart';
import 'package:flutter_clinicapp/core/extensions/build_context_ext.dart';

class VidCallDoctorPage extends StatelessWidget {
  const VidCallDoctorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              Assets.images.doctorVidcall3.path,
              width: context.deviceWidth,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 24,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 32,
                    width: 76,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                      color: const Color(0xff1C1F1E).withOpacity(
                        0.4,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 8,
                          width: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xffFF6C52),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        const Text(
                          '1:32',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      Image.asset(
                        Assets.images.doctorVidcall4.path,
                        width: 85.0,
                        height: 94.0,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 80,
                          left: 32,
                        ),
                        height: 28,
                        width: 28,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xff1C1F1E).withOpacity(
                            0.4,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.sync,
                            color: AppColors.white,
                            size: 14,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 24,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    width: context.deviceWidth,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                      color: const Color(0xffC2C2C2).withOpacity(
                        0.6,
                      ),
                    ),
                    child: const Column(
                      children: [
                        Text(
                          "Sintia",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "sintia@jagoflutter.com",
                          style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: Color(
                                0xff71717A,
                              )),
                        ),
                      ],
                    ),
                  ),
                  const SpaceHeight(
                    20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buttonCircle(
                          false,
                          Icons.mic,
                        ),
                        _buttonCircle(
                          true,
                          Icons.call,
                        ),
                        _buttonCircle(
                          false,
                          Icons.videocam,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buttonCircle(bool isRed, IconData icon) {
    return Container(
      height: 72,
      width: 72,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isRed
            ? const Color(0xffFF6C52)
            : const Color(0xff1C1F1E).withOpacity(
                0.4,
              ),
      ),
      child: Center(
        child: Icon(
          icon,
          color: AppColors.white,
          size: 28,
        ),
      ),
    );
  }
}
