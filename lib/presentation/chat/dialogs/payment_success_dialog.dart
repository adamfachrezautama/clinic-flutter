import 'package:flutter/material.dart';
import 'package:flutter_clinicapp/core/extensions/build_context_ext.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';
import '../../home/pages/home_page.dart';

class PaymentSuccessDialog extends StatelessWidget {
  const PaymentSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      content: SizedBox(
        height: 382,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              Assets.images.paymentSuccess.path,
              width: context.deviceWidth,
              fit: BoxFit.cover,
            ),
            const Spacer(),
            const Text(
              'Pembayaran Berhasil',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Text(
              "Terima kasih atas pembayaran Anda. Dokter akan segera menghubungi Anda untuk konsultasi lebih lanjut.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffB2B2B2)),
            ),
            const SpaceHeight(16),
            Button.filled(
              height: 48,
              borderRadius: 8,
              fontSize: 15.0,
              onPressed: () {
                context.pop();
                context.pushReplacement(
                  const HomePage(),
                );
              },
              label: 'Konsultasi Sekarang',
            ),
          ],
        ),
      ),
    );
  }
}
