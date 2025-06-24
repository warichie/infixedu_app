import 'package:flutter/material.dart';
import 'package:infixedu/app/modules/settings/views/widget/settings_tile.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../data/constants/app_text.dart';
import '../../../routes/app_pages.dart';
import '../../../utilities/widgets/common_widgets/alert_dialog.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => InfixEduScaffold(
          title: "Settings".tr,
          body: CustomBackground(
            customWidget: controller.languageChanging.isTrue
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 20),
                    child: Column(
                      children: [
                        SettingsTile(
                          icon: Iconsax.language_square,
                          // icon: ImagePath.settingLanguage,
                          title: "Change Language".tr,
                          languageName:
                              controller.languageController.langName.value,
                          isLanguage: true,
                          onTileTap: () {
                            controller.showLanguageBottomSheet();
                          },
                        ),
                        10.verticalSpacing,
                        SettingsTile(
                          icon: Iconsax.lock,
                          title: "Change Password".tr,
                          isLanguage: false,
                          onTileTap: () {
                            Get.toNamed(Routes.CHANGE_PASSWORD);
                          },
                        ),
                        10.verticalSpacing,
                        SettingsTile(
                          icon: Iconsax.trash,
                          title: "Delete Account".tr,
                          isLanguage: false,
                          onTileTap: () {
                            Get.dialog(
                              CustomPopupDialogue(
                                onYesTap: () {
                                  controller.deleteAccount();
                                },
                                title: 'Confirmation'.tr,
                                subTitle: AppText.deleteAccountWarningMsg.tr,
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
        ));
  }
}
