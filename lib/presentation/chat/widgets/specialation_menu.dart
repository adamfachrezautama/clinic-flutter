// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_clinicapp/core/constants/colors.dart';

class SpecialitationMenu extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onPressed;
  const SpecialitationMenu({
    super.key,
    required this.label,
    required this.isActive,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 26,
        width: 72,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: isActive
                ? AppColors.primary.withOpacity(
                    0.2,
                  )
                : const Color(0xffEFF2F1)),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: isActive ? AppColors.primary : const Color(0xffA7A6A5),
            ),
          ),
        ),
      ),
    );
  }
}
