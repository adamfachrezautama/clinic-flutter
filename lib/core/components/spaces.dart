import 'package:flutter/cupertino.dart';

class SpaceHeight extends StatelessWidget {
  final double height;
  const SpaceHeight(this.height,{super.key});

  @override
  Widget build(BuildContext context) => SizedBox(height: height);
}

class SpaceWidth extends StatelessWidget {
  final double widht;
  const SpaceWidth(this.widht,{super.key});

  @override
  Widget build(BuildContext context) => SizedBox(width: widht,);
}

