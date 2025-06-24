import 'package:flutter/material.dart';

class WeekTabBarItem extends StatelessWidget {
  final String title;
  final Color? color;
  final TextStyle? textStyle;

  const WeekTabBarItem({
    required this.title,
    this.textStyle,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(
            color: color,
            fontSize: 12,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500),

      ),
    );
  }
}
