// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_clinicapp/core/components/spaces.dart';
import 'package:flutter_clinicapp/core/constants/colors.dart';

class TextListWidget extends StatelessWidget {
  final String text;
  const TextListWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
            top: 6.0,
          ),
          height: 8,
          width: 8,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
        ),
        const SpaceWidth(12),
        Expanded(
          child: Text(
            text,
            textAlign: TextAlign.justify,
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                color: const Color(0xff959CB4).withOpacity(0.8)),
          ),
        ),
      ],
    );
  }
}
