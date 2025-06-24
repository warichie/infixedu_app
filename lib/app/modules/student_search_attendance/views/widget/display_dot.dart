import 'package:flutter/material.dart';

class DisplayDot extends StatelessWidget {

  final Color? color;
  const DisplayDot({
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1.0),
      decoration:  BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      height: 5.0,
      width: 5.0,
    );
  }
}
