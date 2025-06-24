import 'package:flutter/material.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';

import '../../../../data/constants/app_text_style.dart';

class LeaveCard extends StatelessWidget {
  final String? startingTime;
  final String? endingTime;
  const LeaveCard({
    super.key,
    this.startingTime,
    this.endingTime,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Lunch Break".tr,
                      style: AppTextStyle.fontSize14VioletW600,
                    ),
                    5.verticalSpacing,
                    Text(
                      "$startingTime - $endingTime",
                      style: AppTextStyle.fontSize12GreyW400,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
