import 'package:flutter/material.dart';
import 'package:flutter_clinicapp/core/assets/assets.gen.dart';
import 'package:flutter_clinicapp/core/components/spaces.dart';

class EmptyDoctorWidget extends StatelessWidget {
  const EmptyDoctorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          Assets.images.emptyTransaksi.path,
          width: 220.0,
          fit: BoxFit.cover,
        ),
        const SpaceHeight(10),
        const Text(
          "Kelola Data Dokter",
          style: TextStyle(
              fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        const Text(
          "Data Dokter belum tersedia. Silakan tambahkan data dokter baru untuk mengelola informasi.",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              color: Color(
                0xffB2B2B2,
              )),
        ),
      ],
    );
  }
}
