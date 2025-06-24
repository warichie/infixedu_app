import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.controller.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:infixedu/domain/core/model/profile_edit_model/student_profile_edit_response_model.dart';
import 'package:get/get.dart';
import '../../../../domain/base_client/base_client.dart';
import '../../../../domain/core/model/profile_edit_model/profile_data_controller.dart';
import '../../../utilities/api_urls.dart';
import '../../../utilities/message/snack_bars.dart';
import 'package:http/http.dart' as http;

class ProfileEditController extends GetxController {
  @override
  void onInit() {
    _initialize();
    super.onInit();
  }

  GlobalRxVariableController globalRxVariableController = Get.find();
  ProfileDataController profileDataController = Get.find();
  LoadingController loadingController = Get.find();

  TextEditingController firstNameTextController = TextEditingController();
  TextEditingController lastNameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController phoneNumberTextController = TextEditingController();
  TextEditingController dateOfBirthTextController = TextEditingController();
  TextEditingController currentAddressTextController = TextEditingController();

  void _initialize() {
    firstNameTextController.text = profileDataController.firstName.toString();
    lastNameTextController.text = profileDataController.lastName.toString();
    emailTextController.text = profileDataController.email.toString();
    phoneNumberTextController.text =
        profileDataController.phoneNumber.toString();
    dateOfBirthTextController.text =
        profileDataController.dateOfBirth.toString();
    currentAddressTextController.text =
        profileDataController.presentAddress.toString();
  }

  void userProfileInfoUpdate() async {
    try {
      final response = await BaseClient().postData(
        url: InfixApi.updateProfile(
          studentId: globalRxVariableController.studentId.value!,
        ),
        header: GlobalVariable.header,
        payload: {
          "first_name": firstNameTextController.text,
          "last_name": lastNameTextController.text,
          "date_of_birth": dateOfBirthTextController.text,
          "current_address": currentAddressTextController.text,
          "email_address": emailTextController.text,
          "phone_number": phoneNumberTextController.text,
        },
      );

      StudentProfileEditResponseModel profileEditResponseModel =
          StudentProfileEditResponseModel.fromJson(response);
      if (profileEditResponseModel.success == true) {
        loadingController.isLoading = false;
        showBasicSuccessSnackBar(
            message: profileEditResponseModel.message ??
                'Profile Updated Successfully'.tr);

        _saveUpdateData(profileEditResponseModel: profileEditResponseModel);
      } else {
        loadingController.isLoading = false;
        showBasicFailedSnackBar(
            message:
                profileEditResponseModel.message ?? 'Something went wrong'.tr);
      }
    } catch (e, t) {
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      loadingController.isLoading = false;
    }
  }

  void profilePhotoUpdate({required String file}) async {
    try {
      var headers = GlobalVariable.header;
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          InfixApi.studentProfilePhotoUpdate(
            studentId: globalRxVariableController.studentId.value!,
          ),
        ),
      );
      request.files.add(await http.MultipartFile.fromPath('photo', file));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      String res = await response.stream.bytesToString();
      Map<String, dynamic> resMap = json.decode(res);
      StudentProfileEditResponseModel profileEditResponseModel =
          StudentProfileEditResponseModel.fromJson(resMap);
      debugPrint('$resMap');

      if (profileEditResponseModel.success == true) {
        profileDataController.profilePhoto.value =
            profileEditResponseModel.data?.profilePersonal?.studentPhoto ?? '';
        profileDataController.profilePickedImage.value = File('');
        showBasicSuccessSnackBar(
            message: profileEditResponseModel.message ??
                'Profile Updated Successfully'.tr);

        _saveUpdateData(profileEditResponseModel: profileEditResponseModel);
      } else {
        showBasicFailedSnackBar(
            message:
                profileEditResponseModel.message ?? 'Something went wrong'.tr);
        profileDataController.profilePickedImage.value = File('');
      }
    } catch (e, t) {
      profileDataController.profilePickedImage.value = File('');
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      profileDataController.profilePickedImage.value = File('');
    }
  }

  void dateOfBirth() async {
    DateTime? dateTime = await showDatePicker(
      //locale: Locale("bn"),
      context: Get.context!,
      initialDate: profileDataController.dateOfBirth.value != ''
          ? DateTime.tryParse(profileDataController.dateOfBirth.value)
          : DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (dateTime != null) {
      dateOfBirthTextController.text = dateTime.yyyy_mm_dd;
      userProfileInfoUpdate();
    }
  }

  void _saveUpdateData(
      {required StudentProfileEditResponseModel profileEditResponseModel}) {
    profileDataController.firstName.value =
        profileEditResponseModel.data?.profilePersonal?.firstName ?? '';
    profileDataController.lastName.value =
        profileEditResponseModel.data?.profilePersonal?.lastName ?? '';
    profileDataController.email.value =
        profileEditResponseModel.data?.profilePersonal?.email ?? '';
    profileDataController.phoneNumber.value =
        profileEditResponseModel.data?.profilePersonal?.mobile ?? '';
    profileDataController.dateOfBirth.value =
        profileEditResponseModel.data?.profilePersonal?.dateOfBirth ?? '';
    profileDataController.presentAddress.value =
        profileEditResponseModel.data?.profilePersonal?.currentAddress ?? '';
    Get.find<GlobalRxVariableController>().fullName.value =
        '${profileEditResponseModel.data?.profilePersonal?.firstName ?? ''} ${profileEditResponseModel.data?.profilePersonal?.lastName ?? ''}';
  }
}
