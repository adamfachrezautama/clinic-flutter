
import 'package:flutter/material.dart';
import 'package:flutter_clinicapp/core/components/spaces.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Function(String value)? onChanged;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextCapitalization? capitalization;
  final bool showLabel;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? color;
  final bool? readOnly;
  final int? maxLines;
  final TextInputAction? textInputAction;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.onChanged,
   this.obscureText = false,
    this.keyboardType,
    this.capitalization,
    this.showLabel = false,
    this.suffixIcon,
    this.prefixIcon,
    this.color,
    this.readOnly,
    this.maxLines,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel) ...[
          Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
          const SpaceHeight(12.0),
        ],
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: color,
            border: Border.all(color: const Color(0xff677294))
          ),
          child: TextFormField(
            readOnly: readOnly ?? false,
            controller: controller,
            onChanged: onChanged,
            obscureText: obscureText,
            keyboardType: keyboardType,
            maxLines: maxLines,
            textInputAction: textInputAction,
            decoration: InputDecoration(
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: color!),
              ),
              hintText: label,
              hintStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xff677294),
              ),
            ),
            textCapitalization: capitalization ?? TextCapitalization.words,
          ),
        ),
      ],
    );
  }
}
