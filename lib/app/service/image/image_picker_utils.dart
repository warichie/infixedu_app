import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/constants/app_text_style.dart';
import '../../style/bottom_sheet/bottom_sheet_shpe.dart';

class FlutterImagePickerUtils {
  static Future<XFile?> retrieveLostData() async {
    // ignore: invalid_use_of_visible_for_testing_member
    final LostDataResponse response = await ImagePicker.platform.getLostData();
    if (response.file != null) {
      if (response.type == RetrieveType.image) {
        return response.file;
      }
    } else {
      debugPrint((response.exception.toString()));
    }
    return null;
  }

  static Future<File> getImageGallery(context) async {
    ImagePicker picker = ImagePicker();
    XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 60);
    File returnImage = File(pickedImage?.path ?? '');
    // if (returnImage.path.isNotEmpty) {
    //   showBasicProgressDialog(message: 'Compressing image . . .');
    //   returnImage =
    //       await FlutterImagePicker.compressImage(returnImage, quality: 60);
    //   Get.back();
    // }
    return returnImage;
  }

  static Future<File> getImageCamera(context) async {
    ImagePicker picker = ImagePicker();
    XFile? pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 60);
    File returnImage = File(pickedFile?.path ?? '');
    // if (returnImage.path.isNotEmpty) {
    //   showBasicProgressDialog(message: 'Compressing image . . .');
    //   // returnImage = await compressImage(imageFile: returnImage, quality: 60);
    //   returnImage =
    //       await FlutterImagePicker.compressImage(returnImage, quality: 60);
    //   Get.back();
    // }
    return returnImage;
  }

  static void imagePickerModalSheet({
    required BuildContext context,
    required Function() fromGallery,
    required Function() fromCamera,
  }) {
    Get.bottomSheet(
      SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min, // To make the card compact
          children: [
            ListTile(
              onTap: () {
                fromGallery();
                Get.back();
              },
              title: Text(
                'From gallery'.tr,
                  style:
                  AppTextStyle.fontSize14lightBlackW400

              ),
              leading: Icon(
                Icons.image_rounded,
                size: 16.w,
              ),
              trailing: Icon(
                Icons.navigate_next_rounded,
                size: 16.w,
              ),
            ),
            // const MyDivider(),
            const Divider(),
            ListTile(
              onTap: () {
                fromCamera();
                Get.back();
              },
              title:  Text(
                'From camera'.tr,
                  style:
                  AppTextStyle.fontSize14lightBlackW400
              ),
              leading:  Icon(
                  Icons.camera_alt_rounded,
                size: 16.w,
              ),
              trailing:  Icon(
                Icons.navigate_next_rounded,
                size: 16.w,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      shape: defaultBottomSheetShape(),
    );
  }
}
