import 'package:flutter/material.dart';
import 'package:infixedu/app/data/constants/image_path.dart';
import 'package:infixedu/config/global_variable/app_settings_controller.dart';

import 'package:get/get.dart';

import '../controllers/service_error_controller.dart';

class ServiceErrorView extends GetView<ServiceErrorController> {
  const ServiceErrorView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(ImagePath.splashBackground),
                fit: BoxFit.fill,
              )),
              child: Center(
                child: Container(
                  height: 150.0,
                  width: 150.0,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage(ImagePath.appLogo),
                  )),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(() => Center(
                        child: Text(
                          '${Get.find<AppSettingsController>().serverMessage}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.pinkAccent, fontSize: 24.0),
                        ),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
