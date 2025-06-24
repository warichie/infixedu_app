import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/constants/app_text_style.dart';

class SubjectCardTitle extends StatelessWidget {
  final String title;

  const SubjectCardTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.25,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Text(
          title,
          style: AppTextStyle.fontSize14BlackW500,
        ),
      ),
    );
  }
}
