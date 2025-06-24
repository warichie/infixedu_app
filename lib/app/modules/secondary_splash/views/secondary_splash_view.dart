import 'package:flutter/material.dart';
import 'package:infixedu/app/data/constants/image_path.dart';
import 'package:get/get.dart';
import '../controllers/secondary_splash_controller.dart';

class SecondarySplashView extends GetView<SecondarySplashController> {
  const SecondarySplashView({super.key});

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
                  Container(
                    // height: controller.animation?.value,
                    // width: controller.animation?.value,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage(ImagePath.appLogo),
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
