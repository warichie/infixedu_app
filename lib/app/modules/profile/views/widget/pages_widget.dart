import 'package:flutter/material.dart';
import 'package:infixedu/app/modules/profile/controllers/profile_controller.dart';
import 'package:get/get.dart';
import 'custom_tab_bar_item.dart';

class PageWidget extends StatelessWidget {
  final ProfileController controller;

  const PageWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomTabBarItem(
              title: 'Personal'.tr,
              isActive: controller.pageIndex.value == 0 ? true : false,
              onTap: () {
                controller.pageIndex.value = 0;
                controller.profilePageController.jumpToPage(0);
              },
            ),
            CustomTabBarItem(
              title: 'Parents'.tr,
              isActive: controller.pageIndex.value == 1 ? true : false,
              onTap: () {
                controller.pageIndex.value = 1;
                controller.profilePageController.jumpToPage(1);
              },
            ),
            CustomTabBarItem(
              title: 'Transport'.tr,
              isActive: controller.pageIndex.value == 2 ? true : false,
              onTap: () {
                controller.pageIndex.value = 2;
                controller.profilePageController.jumpToPage(2);
              },
            ),
            CustomTabBarItem(
              title: 'Others'.tr,
              isActive: controller.pageIndex.value == 3 ? true : false,
              onTap: () {
                controller.pageIndex.value = 3;
                controller.profilePageController.jumpToPage(3);
              },
            ),
            CustomTabBarItem(
              title: 'Documents'.tr,
              isActive: controller.pageIndex.value == 4 ? true : false,
              onTap: () {
                controller.pageIndex.value = 4;
                controller.profilePageController.jumpToPage(4);
              },
            ),
          ],
        ));
  }
}
