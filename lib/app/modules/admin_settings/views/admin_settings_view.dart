import 'package:flutter/material.dart';
import 'package:infixedu/app/data/constants/app_text.dart';
import 'package:infixedu/app/modules/settings/views/widget/settings_tile.dart';
import 'package:infixedu/app/routes/app_pages.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/alert_dialog.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../controllers/admin_settings_controller.dart';

class AdminSettingsView extends GetView<AdminSettingsController> {
  const AdminSettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Settings".tr,
      body: CustomBackground(
        customWidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: Column(
            children: [
              SettingsTile(
                icon: Iconsax.language_circle,
                // icon: ImagePath.settingLanguage,
                title: "Change Language".tr,
                isLanguage: true,
                onTileTap: () {
                  controller.showLanguageBottomSheet();
                },
              ),
              10.verticalSpacing,
              SettingsTile(
                icon: Iconsax.lock,
                // icon: ImagePath.changePassword,
                title: "Change Password".tr,
                isLanguage: false,
                onTileTap: () {
                  Get.toNamed(Routes.CHANGE_PASSWORD);
                },
              ),
              10.verticalSpacing,
              SettingsTile(
                icon: Iconsax.trash,
                // icon: ImagePath.delete,
                title: "Delete Account".tr,
                isLanguage: false,
                onTileTap: () {
                  Get.dialog(
                    CustomPopupDialogue(
                      onYesTap: () {},
                      title: 'Confirmation'.tr,
                      subTitle: AppText.deleteAccountWarningMsg,
                      noText: 'Cancel'.tr,
                      yesText: 'Delete'.tr,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
