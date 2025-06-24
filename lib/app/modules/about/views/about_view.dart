import 'package:flutter/material.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/data/constants/image_path.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.widget.dart';
import 'package:infixedu/config/app_config.dart';

import 'package:get/get.dart';

import '../controllers/about_controller.dart';

class AboutView extends GetView<AboutController> {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "About".tr,
      body: CustomBackground(
        customWidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Obx(
            () => controller.loadingController.isLoading
                ? const LoadingWidget()
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),
                              child: Image.asset(
                                ImagePath.appLogo,
                                color: AppColors.primaryColor,
                                scale: 5,
                              ),
                            ),
                            Text(
                              AppConfig.appName,
                              style: AppTextStyle.fontSize14BlackW500,
                            ),
                          ],
                        ),
                        30.verticalSpacing,
                        Text(
                          controller.aboutInformation?.aboutDetails ?? '',
                          style: AppTextStyle.fontSize13BlackW400,
                        ),
                        20.verticalSpacing,
                        Text(
                          '${"Address".tr}: ${controller.aboutInformation?.address ?? ""}',
                          style: AppTextStyle.cardTextStyle14PurpleW500,
                        ),
                        10.verticalSpacing,
                        Text(
                          '${"Phone number".tr}: ${controller.aboutInformation?.phoneNo ?? ""}',
                          style: AppTextStyle.cardTextStyle14PurpleW500,
                        ),
                        10.verticalSpacing,
                        Text(
                          '${"Email".tr}: ${controller.aboutInformation?.email ?? ""} ',
                          style: AppTextStyle.cardTextStyle14PurpleW500,
                        ),
                        10.verticalSpacing,
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
