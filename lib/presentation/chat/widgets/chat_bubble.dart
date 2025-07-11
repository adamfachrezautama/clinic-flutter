// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:flutter_clinicapp/core/constants/colors.dart';
import 'package:flutter_clinicapp/core/utils/convert.dart';
import 'package:flutter_clinicapp/data/models/response/user_model.dart';

enum BubbleType {
  top,
  middle,
  bottom,
  alone,
}

enum Direction {
  left,
  right,
}

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.direction,
    required this.message,
    this.photoUrl,
    required this.type,
    required this.partner,
    required this.clock,
  });
  final Direction direction;
  final String message;
  final String? photoUrl;
  final BubbleType type;
  final UserModel partner;
  final String clock;
  @override
  Widget build(BuildContext context) {
    final time = Convert.extractTime(clock);
    final isOnLeft = direction == Direction.left;
    return Column(
      crossAxisAlignment:
          isOnLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment:
              isOnLeft ? MainAxisAlignment.start : MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment:
                  isOnLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.8),
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: _borderRadius(direction, type),
                    color:
                        isOnLeft ? const Color(0xffEDEDED) : AppColors.primary,
                  ),
                  child: Text(
                    message,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: isOnLeft ? Colors.black : Colors.white,
                    ),
                  ),
                ),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 8.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  BorderRadius _borderRadius(Direction dir, BubbleType type) {
    const radius1 = Radius.circular(15);
    const radius2 = Radius.circular(5);
    switch (type) {
      case BubbleType.top:
        return dir == Direction.left
            ? const BorderRadius.only(
                topLeft: radius1,
                topRight: radius1,
                bottomLeft: radius2,
                bottomRight: radius1,
              )
            : const BorderRadius.only(
                topLeft: radius1,
                topRight: radius1,
                bottomLeft: radius1,
                bottomRight: radius2,
              );

      case BubbleType.middle:
        return dir == Direction.left
            ? const BorderRadius.only(
                topLeft: radius2,
                topRight: radius1,
                bottomLeft: radius2,
                bottomRight: radius1,
              )
            : const BorderRadius.only(
                topLeft: radius1,
                topRight: radius2,
                bottomLeft: radius1,
                bottomRight: radius2,
              );
      case BubbleType.bottom:
        return dir == Direction.left
            ? const BorderRadius.only(
                topLeft: radius2,
                topRight: radius1,
                bottomLeft: radius1,
                bottomRight: radius1,
              )
            : const BorderRadius.only(
                topLeft: radius1,
                topRight: radius2,
                bottomLeft: radius1,
                bottomRight: radius1,
              );
      case BubbleType.alone:
        return BorderRadius.circular(15);
    }
  }
}
