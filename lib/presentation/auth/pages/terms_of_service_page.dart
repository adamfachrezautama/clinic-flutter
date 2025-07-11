import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clinicapp/core/components/buttons.dart';
import 'package:flutter_clinicapp/core/components/spaces.dart';
import 'package:flutter_clinicapp/core/constants/colors.dart';
import 'package:flutter_clinicapp/core/extensions/build_context_ext.dart';
import 'package:flutter_clinicapp/presentation/auth/pages/data_pengguna_page.dart';
import 'package:flutter_clinicapp/presentation/auth/widgets/text_list_widget.dart';

class TermsOfServicePage extends StatelessWidget {
  const TermsOfServicePage({super.key});

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
                "Ketentuan Layanan",
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
                "Ketentuan Layanan Aplikasi Ayo Sehat",
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff677294)),
              ),
              const SpaceHeight(12),
              Text(
                "Selamat datang di aplikasi Ayo Sehat. Dengan menggunakan aplikasi ini, Anda menyetujui ketentuan layanan berikut ini. Harap baca ketentuan ini dengan cermat untuk memahami hak dan kewajiban Anda saat menggunakan layanan kami.",
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff959CB4).withOpacity(0.8)),
                textAlign: TextAlign.justify,
              ),
              const SpaceHeight(16),
              const TextListWidget(
                text:
                    'Dengan mengunduh, mendaftar, dan/atau menggunakan aplikasi Ayo Sehat, Anda menyatakan bahwa Anda setuju untuk mematuhi dan terikat oleh Ketentuan Layanan ini, serta kebijakan privasi kami.',
              ),
              const SpaceHeight(16),
              const TextListWidget(
                text:
                    'Ayo Sehat menyediakan platform untuk konsultasi kesehatan online antara pengguna (Anda) dan profesional medis. Layanan ini tidak dimaksudkan sebagai pengganti saran medis profesional langsung. Anda sebaiknya selalu menghubungi profesional kesehatan untuk setiap kebutuhan medis mendesak.',
              ),
              const SpaceHeight(16),
              const TextListWidget(
                text:
                    'Ayo Sehat bertujuan untuk menyediakan layanan terbaik namun tidak memberikan jaminan bahwa layanan ini bebas dari gangguan atau kesalahan',
              ),
              const SpaceHeight(
                24,
              ),
              Text(
                "Jika Anda memiliki pertanyaan mengenai Ketentuan Layanan ini, silakan hubungi kami di",
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff959CB4).withOpacity(0.8)),
                textAlign: TextAlign.justify,
              ),
              const SpaceHeight(16),
              // GestureDetector(
              //   onTap: () {
              //     context.push(const DataPenggunaPage());
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
                    context.push(const DataPenggunaPage());
                  },
                  label: 'Setuju dan Lanjutkan'),
            ],
          ),
        )
      ],
    )));
  }
}
