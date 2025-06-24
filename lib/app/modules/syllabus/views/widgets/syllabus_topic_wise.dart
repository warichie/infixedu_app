import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/button/primary_button.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_container_widget.dart';
import 'package:get/get.dart';

class SyllabusTopicWise extends StatelessWidget {
  final String? contentTitle;
  final String? topic;
  final String? date;
  final Function()? onTap;

  const SyllabusTopicWise({
    super.key,
    this.contentTitle,
    this.topic,
    this.date,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("syllabus title is: $contentTitle");
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomContainerWidget(
          borderColor: const Color(0xFFEAE7F0),
          color: Colors.white,
          borderWidth: 1,
          requiredWidget: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      contentTitle ?? "",
                      style: AppTextStyle.fontSize16lightBlackW500,
                      overflow: TextOverflow.ellipsis,
                    ),
                    7.horizontalSpacing,
                  ],
                ),
                5.verticalSpacing,
                Text(
                  topic ?? "",
                  // style: AppTextStyle.fontSize14BlackW500,
                ),
                topic!.isNotEmpty ? 10.verticalSpacing : const SizedBox(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: SecondaryButton(
                        height: 28,
                        onTap: onTap,
                        title: "Download".tr,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        "${"Date".tr} : $date",
                        style: AppTextStyle.fontSize14BlackW400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
