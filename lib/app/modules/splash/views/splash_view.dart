import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_text.dart';
import 'package:infixedu/app/data/constants/image_path.dart';
import 'package:get/get.dart';
import '../../../../config/app_config.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              height: Get.height,
              width: Get.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImagePath.splashBackground),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: Get.height / 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0.h),
                    child: Text(
                      AppText.welcomeTo.tr,
                      style: Get.textTheme.titleMedium?.copyWith(
                        fontSize: 20.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  AnimatedBuilder(
                    animation: controller.animation!,
                    builder: (context, child) {
                      return Container(
                        height: controller.animation?.value,
                        width: controller.animation?.value,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: ExactAssetImage(ImagePath.appLogo),
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 60.0.h),
                    child: Text(
                      AppConfig.appName,
                      style: Get.textTheme.titleMedium?.copyWith(
                        fontSize: 18.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80.0, left: 40, right: 40),
              child: Container(
                alignment: Alignment.bottomCenter,
                child: const LinearProgressIndicator(
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
