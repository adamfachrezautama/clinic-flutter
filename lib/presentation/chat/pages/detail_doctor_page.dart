// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_clinicapp/core/assets/assets.gen.dart';
import 'package:flutter_clinicapp/core/components/buttons.dart';
import 'package:flutter_clinicapp/core/components/spaces.dart';
import 'package:flutter_clinicapp/core/constants/colors.dart';
import 'package:flutter_clinicapp/core/extensions/build_context_ext.dart';
import 'package:flutter_clinicapp/core/extensions/string_ext.dart';
import 'package:flutter_clinicapp/data/models/response/doctor_response_model.dart';
import 'package:flutter_clinicapp/presentation/chat/pages/premium_chat_page.dart';

class DetailDoctorPage extends StatelessWidget {
  final DoctorModel doctor;
  final bool isTelemedis;
  const DetailDoctorPage({
    super.key,
    required this.doctor,
    required this.isTelemedis,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 20,
          ),
          height: 77,
          width: context.deviceWidth,
          decoration: const BoxDecoration(
            color: AppColors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Biaya Konsultasi",
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    isTelemedis
                        ? doctor.telemedicineFee!.toString().currencyFormatRpV2
                        : doctor.chatFee!.toString().currencyFormatRpV2,
                    style: const TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w600,
                      color: Color(
                        0xff677294,
                      ),
                    ),
                  ),
                ],
              ),
              Button.filled(
                width: 120,
                height: 40,
                borderRadius: 10,
                onPressed: () {
                  context.push(
                    PremiumChatPage(
                      doctor: doctor,
                      isTelemedis: isTelemedis,
                    ),
                  );
                },
                label: isTelemedis ? 'Call Sekarang' : 'Chat Sekarang',
                fontSize: 12.0,
              )
            ],
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: context.deviceHeight * 0.5,
                  color: AppColors.primary,
                  child: doctor.image != null
                      ? Image.network(
                          doctor.image!.contains('https')
                              ? doctor.image!
                              : "${dotenv.env['BASE_URL']}${doctor.image}",
                          width: context.deviceWidth,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          Assets.images.doctor1.path,
                          width: context.deviceWidth,
                          fit: BoxFit.cover,
                        ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: context.deviceHeight * 0.45,
                  ),
                  padding: const EdgeInsets.all(24.0),
                  width: context.deviceWidth,
                  decoration: const BoxDecoration(
                    color: AppColors.lightBackground,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      topLeft: Radius.circular(
                        8,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doctor.name ?? "-",
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                doctor.specialitation?.name ?? "-",
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                              const SpaceHeight(
                                10,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Color(0xffF2C94C),
                                    size: 24.0,
                                  ),
                                  const SpaceWidth(
                                    8,
                                  ),
                                  const Text(
                                    "4.6 review (100 ulasan)",
                                    style: TextStyle(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SpaceWidth(
                                    16,
                                  ),
                                  Image.asset(
                                    Assets.icons.personHistory.path,
                                    width: 18,
                                    height: 18,
                                  ),
                                  const SpaceWidth(8),
                                  const Text(
                                    "8 tahun",
                                    style: TextStyle(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 24.0,
                            height: 24.0,
                            child: SvgPicture.asset(
                              Assets.icons.chat.path,
                              colorFilter: const ColorFilter.mode(
                                AppColors.primary,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SpaceHeight(24),
                      const Text(
                        "Penghargaan dan Sertifikasi",
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const SpaceHeight(8),
                      item(
                        doctor.certification ?? "-",
                      ),
                      const SpaceHeight(24),
                      const Text(
                        "Tempat Praktik",
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const SpaceHeight(8),
                      Text(
                        doctor.clinic?.name ?? "-",
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                //button back
                Positioned(
                  top: 20,
                  left: 20,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.arrow_back,
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget item(
    String certification,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: CircleAvatar(
            radius: 4.0,
            backgroundColor: AppColors.grey.withOpacity(0.4),
          ),
        ),
        const SpaceWidth(8),
        Expanded(
          child: Text(
            // "$certification \n$place \nTahun: $year",
            certification,
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              color: AppColors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
