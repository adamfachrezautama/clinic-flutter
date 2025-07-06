import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

enum ButtonStyle { filled, outlined }

class Button extends StatelessWidget {
  final Function() onPressed;

  final String label;

  final ButtonStyle style;

  final Color color;

  final Color textColor;

  final double width;

  final double height;

  final double borderRadius;

  final Widget? icon;

  final Widget? iconRight;

  final bool disabled;

  final double fontSize;

  final Color? borderColor;

  const Button.filled({
    super.key,
    required this.onPressed,
    required this.label,
    this.style = ButtonStyle.filled,
    this.color = AppColors.primary,
    this.textColor = Colors.white,
    this.width = double.infinity,
    this.height = 50.0,
    this.borderRadius = 16.0,
    this.icon,
    this.iconRight,
    this.disabled = false,
    this.fontSize = 16.0,
    this.borderColor,
  });

  const Button.outlined({
    super.key,
    required this.onPressed,
    required this.label,
    this.style = ButtonStyle.outlined,
    this.color = AppColors.white,
    this.textColor = AppColors.primary,
    this.width = double.infinity,
    this.height = 50.0,
    this.borderRadius = 16.0,
    this.icon,
    this.iconRight,
    this.disabled = false,
    this.fontSize = 16.0,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child:
          style == ButtonStyle.filled
              ? ElevatedButton(
                onPressed: disabled ? null : onPressed,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                ),
                child: Row(
                  mainAxisAlignment:
                      iconRight != null
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.center,
                  children: [
                    icon ?? const SizedBox.shrink(),
                    if (icon != null) const SizedBox(width: 10.0),
                    Text(
                      label,
                      style: TextStyle(
                        color: textColor,
                        fontSize: fontSize,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    iconRight ?? const SizedBox.shrink(),
                    if (iconRight != null) const SizedBox(width: 10.0),
                  ],
                ),
              )
              : OutlinedButton(
                onPressed: disabled ? null : onPressed,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  backgroundColor: color,
                  side: BorderSide(color: borderColor ?? AppColors.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                ),
                child: Row(
                  mainAxisAlignment:
                      iconRight != null
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.center,
                  children: [
                    icon ?? const SizedBox.shrink(),
                    if (icon != null) const SizedBox(width: 10.0),
                    Text(
                      label,
                      style: TextStyle(
                        color: textColor,
                        fontSize: fontSize,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    iconRight ?? const SizedBox.shrink(),
                    if (iconRight != null) const SizedBox(width: 10.0,),
                  ],
                ),
              ),
    );
  }
}
