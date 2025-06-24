import 'package:flutter/material.dart';
import 'package:infixedu/app/data/constants/app_text.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';

import '../../../data/constants/app_text_style.dart';
import '../../../data/constants/image_path.dart';

class NoDataAvailableWidget extends StatelessWidget {
  final String? message;
  const NoDataAvailableWidget({
    super.key,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        100.verticalSpacing,
        Container(
          height: Get.height * 0.25,
          width: Get.width * 0.5,
          decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage(ImagePath.noNotification))),
        ),
        Text(
          message ?? AppText.noDataAvailable.tr,
          style: AppTextStyle.syllabusFontSize16W500,
        ),
      ],
    );
  }
}
