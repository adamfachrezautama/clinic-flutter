import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clinicapp/core/components/buttons.dart';
import 'package:flutter_clinicapp/core/components/spaces.dart';
import 'package:flutter_clinicapp/core/constants/colors.dart';
import 'package:flutter_clinicapp/core/extensions/build_context_ext.dart';
import 'package:flutter_clinicapp/presentation/auth/pages/terms_of_service_page.dart';
import 'package:flutter_clinicapp/presentation/auth/widgets/text_list_widget.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xff1469F0),
      statusBarBrightness: Brightness.dark,
    ));
    return Scaffold(
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
                "Kebijakan Privasi",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Kebijakan Privasi Aplikasi Ayo Sehat",
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff677294)),
              ),
              const SpaceHeight(12),
              Text(
                "Kami di Ayo Sehat menghargai privasi Anda dan berkomitmen untuk melindungi data pribadi Anda. Kebijakan Privasi ini menjelaskan bagaimana kami mengumpulkan, menggunakan, dan melindungi informasi Anda saat Anda menggunakan aplikasi Ayo Sehat.",
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff959CB4).withOpacity(0.8)),
                textAlign: TextAlign.justify,
              ),
              const SpaceHeight(16),
              const TextListWidget(
                text:
                    'Nama, alamat email, nomor telepon, dan informasi lain yang Anda berikan saat mendaftar.',
              ),
              const SpaceHeight(16),
              const TextListWidget(
                text:
                    'Catatan medis, keluhan kesehatan, riwayat pengobatan, dan data lainnya yang relevan dengan konsultasi kesehatan.',
              ),
              const SpaceHeight(16),
              const TextListWidget(
                text:
                    'Alamat IP, perangkat yang digunakan, dan data log lainnya yang membantu kami memahami penggunaan aplikasi.',
              ),
              const SpaceHeight(16),
              const TextListWidget(
                text:
                    'Kami dapat bekerja sama dengan pihak ketiga, seperti penyedia layanan teknologi atau mitra bisnis, yang membantu menyediakan layanan kami, namun hanya sejauh yang diperlukan.',
              ),
              const SpaceHeight(
                24,
              ),
              Text(
                "Jika Anda memiliki pertanyaan mengenai Kebijakan Privasi ini atau ingin menggunakan hak-hak Anda terkait data pribadi, silakan hubungi kami di:",
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff959CB4).withOpacity(0.8)),
                textAlign: TextAlign.justify,
              ),
              const SpaceHeight(16),
              // GestureDetector(
              //   onTap: () {
              //     context.push(const TermsOfServicePage());
              //   },
              //   child: Text(
              //     "Email: support@ayosehat.com",
              //     style: TextStyle(
              //         fontSize: 14.0,
              //         fontWeight: FontWeight.w400,
              //         color: const Color(0xff959CB4).withOpacity(0.8)),
              //     textAlign: TextAlign.justify,
              //   ),
              // ),
              const SpaceHeight(16),
              Button.filled(
                  onPressed: () {
                    context.push(const TermsOfServicePage());
                  },
                  label: 'Setuju dan Lanjutkan'),
            ],
          ),
        )
      ],
    )));
  }
}
