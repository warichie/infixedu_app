import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_text.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:get/get.dart';
import 'package:infixedu/app/utilities/widgets/button/primary_button.dart';
import '../../../routes/app_pages.dart';
import '../../../utilities/widgets/common_widgets/text_field.dart';
import '../controllers/forget_password_controller.dart';

class ForgetPasswordView extends GetView<ForgetPasswordController> {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Forget Password".tr,
      actions: const [
        SizedBox(),
      ],
      body: CustomBackground(
        customWidget: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 500.h,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.w),
                        topRight: Radius.circular(8.w)),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    50.h.verticalSpacing,
                    Text(
                      "Password Recovery".tr,
                      style: TextStyle(
                          color: const Color(0xFF48484A),
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700),
                    ),
                    30.h.verticalSpacing,
                    CustomTextFormField(
                      controller: controller.forgetTextController,
                      fillColor: Colors.white,
                      hintText: "Type email address".tr,
                      focusBorderActive: true,
                      enableBorderActive: true,
                    ),
                    10.h.verticalSpacing,
                    Text(
                      AppText.enterYourMailText,
                      style: TextStyle(
                          color: Color(0xFF636366),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    30.h.verticalSpacing,
                    SecondaryButton(
                      title: "Recover My Password".tr,
                      height: 35,
                      radius: 6.w,
                      onTap: () {
                        if (controller.validation()) {
                          controller.forgetPassword();
                        }
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
