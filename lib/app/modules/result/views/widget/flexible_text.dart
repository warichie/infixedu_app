import 'package:flutter/material.dart';

import '../../../../data/constants/app_text_style.dart';

class FlexibleText extends StatelessWidget {
  final String? text;
  const FlexibleText({
    super.key,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Text(
          text ?? "",
          style: AppTextStyle.homeworkTitle,
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
