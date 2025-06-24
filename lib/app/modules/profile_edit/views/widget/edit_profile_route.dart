import 'package:flutter/material.dart';
import 'package:infixedu/app/data/constants/image_path.dart';
import 'package:infixedu/app/modules/profile/controllers/profile_controller.dart';
import 'package:infixedu/app/routes/app_pages.dart';
import 'package:get/get.dart';

class EditProfileRoute extends StatelessWidget {
  const EditProfileRoute({super.key, this.controller});

  final ProfileController? controller;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.PROFILE_EDIT,
            arguments: {"profile_personal": controller?.profilePersonal});
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Container(
          height: 17,
          width: 17,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImagePath.edit),
                filterQuality: FilterQuality.high),
          ),
        ),
      ),
    );
  }
}
