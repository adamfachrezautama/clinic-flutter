import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_clinicapp/core/constants/colors.dart';

class CountDown extends StatefulWidget {
  //function callback
  final Function? onCountDownFinish;
  const CountDown({
    super.key,
    this.onCountDownFinish,
  });

  @override
  State<CountDown> createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> {
  late Timer _timer;
  int _start = 1800;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          widget.onCountDownFinish!();
          timer.cancel();
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final int minutes = seconds ~/ 60;
    final int secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _formatTime(_start), // Format menit:detik
      style: TextStyle(
        color: AppColors.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
