import 'package:flutter/material.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:get/get.dart';

class AdminSettingsController extends GetxController {
  List<String> languageList = [
    "English",
    "Bangla",
    "Hindi",
    "German",
  ];

  void showLanguageBottomSheet() {
    Get.bottomSheet(Container(
      height: Get.height * 0.4,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          10.verticalSpacing,
          const CustomDivider(
            height: 3,
            width: 30,
          ),
          30.verticalSpacing,
          Expanded(
            child: ListView.builder(
                itemCount: languageList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      debugPrint("Tapped on ${languageList[index]}");
                    },
                    child: Container(
                      height: Get.height * 0.05,
                      width: Get.width,
                      color: index % 2 == 0
                          ? AppColors.profileCardTextColor
                          : Colors.white,
                      child: Center(
                        child: Text(
                          languageList[index],
                          style: AppTextStyle.blackFontSize14W400,
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    ));
  }
}
