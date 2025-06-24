import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/data/constants/image_path.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/primary_button.dart';
import 'package:infixedu/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';
import 'package:infixedu/config/app_config.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../data/constants/app_colors.dart';
import '../../../routes/app_pages.dart';
import '../../../utilities/message/snack_bars.dart';
import '../../../utilities/widgets/common_widgets/custom_elevated_button.dart';
import '../../../utilities/widgets/common_widgets/text_field.dart';
import '../../../utilities/widgets/no_internet/no_internet_widget.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.internetController.internet.isTrue
        ? Scaffold(
            backgroundColor: AppColors.secondaryColor,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  height: Get.height,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryColor,
                        AppColors.appBackgroundColor
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // 50.verticalSpacing,
                        SizedBox(
                          height: Get.height * 0.40,
                          child: Padding(
                            padding: EdgeInsets.only(top: Get.height * 0.06),
                            child: Column(
                              children: [
                                Image.asset(
                                  ImagePath.appLogo,
                                  height: Get.height * 0.05,
                                  width: 130.w,
                                ),
                                (Get.height * 0.02).verticalSpacing,
                                Image.asset(ImagePath.loginIllustration,
                                    height: Get.height * 0.18, width: 157.w),
                              ],
                            ),
                          ),
                        ),

                        Container(
                          height: Get.height * 0.60,
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.w),
                                topRight: Radius.circular(8.w)),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  /// Demo Login Bar
                                  (Get.height * 0.03).verticalSpacing,
                                  AppConfig.isDemo
                                      ? Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              width: (Get.width * 0.6),
                                              child: Row(
                                                children: <Widget>[
                                                  CustomElevatedButton(
                                                    onPressed: () {
                                                      controller.demoUserLogin(
                                                          role: 2);
                                                    },
                                                    text: 'Student'.tr,
                                                    topLeft: 8.0.w,
                                                    bottomLeft: 8.0.w,
                                                  ),
                                                  VerticalDivider(
                                                    width: 1.w,
                                                  ),
                                                  CustomElevatedButton(
                                                    onPressed: () {
                                                      controller.demoUserLogin(
                                                          role: 4);
                                                    },
                                                    text: 'Teacher'.tr,
                                                    topRight: 8.0.w,
                                                    bottomRight: 8.0.w,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            (Get.height * 0.01).verticalSpacing,
                                            SizedBox(
                                              width: (Get.width * 0.6),
                                              child: Row(
                                                children: <Widget>[
                                                  CustomElevatedButton(
                                                    onPressed: () {
                                                      controller.demoUserLogin(
                                                          role: 3);
                                                    },
                                                    text: 'Parent'.tr,
                                                    topLeft: 8.0.w,
                                                    bottomLeft: 8.0.w,
                                                    backgroundColor:
                                                        AppColors.primaryColor,
                                                  ),
                                                  VerticalDivider(
                                                    width: 1.w,
                                                  ),
                                                  CustomElevatedButton(
                                                    onPressed: () {
                                                      controller.demoUserLogin(
                                                          role: 1);
                                                    },
                                                    text: 'Admin'.tr,
                                                    topRight: 8.0.w,
                                                    bottomRight: 8.0.w,
                                                    backgroundColor:
                                                        AppColors.primaryColor,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      : const SizedBox.shrink(),

                                  (Get.height * 0.04).verticalSpacing,

                                  /// Email Text field
                                  CustomTextFormField(
                                    controller: controller.emailTextController,
                                    fillColor: Colors.white,
                                    focusBorderActive: true,
                                    enableBorderActive: true,
                                    hintText: "Email".tr,
                                    //  contentPadding: EdgeInsets.only(left: 15.w),
                                    textInputType: TextInputType.text,
                                    hintTextStyle:
                                        AppTextStyle.fontSize12LightViolateW500,
                                    suffixIcon: const Icon(
                                      Iconsax.sms,
                                      color: AppColors.loginIconColor,
                                    ),
                                  ),
                                  (Get.height * 0.02).verticalSpacing,

                                  /// Password Text field
                                  CustomTextFormField(
                                    iconOnTap: () {
                                      controller.isObscureText.value =
                                          !controller.isObscureText.value;
                                    },
                                    controller:
                                        controller.passwordTextController,
                                    obsCureText: controller.isObscureText.value,
                                    fillColor: Colors.white,
                                    hintText: "Password".tr,
                                    hintTextStyle:
                                        AppTextStyle.fontSize12LightViolateW500,
                                    focusBorderActive: true,
                                    enableBorderActive: true,
                                    suffixIcon: Icon(
                                      controller.isObscureText.value
                                          ? Iconsax.lock
                                          : Iconsax.unlock,
                                      color: AppColors.loginIconColor,
                                    ),
                                  ),
                                ],
                              ),
                              (Get.height * 0.02).verticalSpacing,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onTap: () =>
                                        Get.toNamed(Routes.FORGET_PASSWORD),
                                    child: Text(
                                      "${"Forget Password".tr}?",
                                      style: AppTextStyle
                                          .cardTextStyle14PurpleW500,
                                    ),
                                  ),
                                ],
                              ),
                              (Get.height * 0.04).verticalSpacing,
                              controller.isLoading.value
                                  ? const SecondaryLoadingWidget(
                                      isBottomNav: true,
                                    )
                                  : PrimaryButton(
                                      onTap: () {
                                        if (validate()) {
                                          controller.userLogin(
                                            email: controller
                                                .emailTextController.text,
                                            password: controller
                                                .passwordTextController.text,
                                          );
                                        }
                                      },
                                      text: 'Login'.tr,
                                    ),
                              (Get.height * 0.04).verticalSpacing,
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        : const NoInternetConnection());
  }

  bool validate() {
    String email = controller.emailTextController.text;
    String password = controller.passwordTextController.text;
    if (email.isEmpty) {
      showBasicFailedSnackBar(message: 'Enter email'.tr);
      return false;
    } else if (password.isEmpty) {
      showBasicFailedSnackBar(message: 'Enter password'.tr);
      return false;
    }
    return true;
  }
}
