// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:infixedu/app/data/constants/app_text.dart';
import 'package:infixedu/app/modules/virtual_class_list/views/virtual_calss_join.dart';
import 'package:infixedu/app/utilities/api_urls.dart';
import 'package:infixedu/app/utilities/message/snack_bars.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:infixedu/domain/base_client/base_client.dart';
import 'package:infixedu/domain/core/model/online_class/zoom/zoom_meeting_list_response_model.dart';
import 'package:get/get.dart';
// import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:url_launcher/url_launcher.dart';

class VirtualClassListController extends GetxController {
  GlobalRxVariableController globalRxVariableController =
      Get.find<GlobalRxVariableController>();
  RxList<MeetingList> meetingList = <MeetingList>[].obs;
  RxBool meetingLoader = false.obs;
  RxString onlineClass = "".obs;
  String url = "";
  String title = "";
  var jitsiServerUrl = '';

  Future<void> fetchJitsiSettings() async {
    final response = await BaseClient().getData(
      url: InfixApi.jitsiSettings,
      header: GlobalVariable.header,
    );
    jitsiServerUrl = response['data']['jitsi_server'];
  }

  Future<void> loadData() async {
    meetingLoader.value = true;

    try {
      if (onlineClass.value == 'jitsi_meeting' ||
          onlineClass.value == 'jitsi') {
        await fetchJitsiSettings();
      }
      await getZoomMeetingList();
    } catch (e) {
      meetingLoader.value = false;
    } finally {
      meetingLoader.value = false;
    }
  }

  /// Get Zoom Meeting List
  Future<MeetingListResponseModel> getZoomMeetingList() async {
    try {
      meetingList.clear();

      meetingLoader.value = true;
      final response = await BaseClient().getData(
        url: url,
        header: GlobalVariable.header,
      );

      MeetingListResponseModel zoomMeetingListResponseModel =
          MeetingListResponseModel.fromJson(response);

      if (zoomMeetingListResponseModel.success == true) {
        meetingLoader.value = false;
        if (zoomMeetingListResponseModel.data!.isNotEmpty) {
          for (int i = 0; i < zoomMeetingListResponseModel.data!.length; i++) {
            meetingList.add(zoomMeetingListResponseModel.data![i]);
          }
        }
      } else {
        meetingLoader.value = false;
        showBasicFailedSnackBar(
          message: zoomMeetingListResponseModel.message ??
              AppText.somethingWentWrong.tr,
        );
      }
    } catch (e, t) {
      Get.back();
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      meetingLoader.value = false;
    }

    return MeetingListResponseModel();
  }

  Future<void> openZoom(
      {required String meetingId, required String status}) async {
    if (status == "JOIN" || status == 'START') {
      final url = InfixApi.getJoinMeetingUrlApp(meetingID: meetingId);

      if (await canLaunch(url)) {
        await launch(url);
      } else {
        final webUrl = InfixApi.getJoinMeetingUrlWeb(meetingID: meetingId);
        // if (await canLaunch(webUrl)) {
        //   await launch(webUrl);
        // } else {
        //   throw Exception('Could not launch $url');
        // }
        Get.to(() => ClassOrMeetingView(
            classUrl: webUrl,
            title: onlineClass.value == "zoom"
                ? "Virtual live class".tr
                : "Virtual live meeting".tr));
      }
    }
  }

  Future<void> openBBB({String? title, String? webUrl}) async {
    Get.to(() => ClassOrMeetingView(
        classUrl: webUrl!,
        title: onlineClass.value == "big_blue_button"
            ? "Virtual live class".tr
            : "Virtual live meeting".tr));
  }

  Future<void> openGoogleMeet(
      {required String status, required String url}) async {
    if (status == "JOIN" || status == 'START') {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        final webUrl = url;
        // if (await canLaunch(webUrl)) {
        //   await launch(webUrl);
        // } else {
        //   throw Exception('Could not launch $url');
        // }
        Get.to(() => ClassOrMeetingView(
            classUrl: webUrl,
            title: onlineClass.value == "google_meet_class"
                ? "Virtual live class".tr
                : "Virtual live meeting".tr));
      }
    }
  }

  Future<void> openJitsiMeet(
      {required String status, required String meetingID}) async {
    if (status == "JOIN" || status == 'START') {
      // if (await canLaunch(url)) {
      //   await launch(url);
      // } else {
      final webUrl =
          "$jitsiServerUrl$meetingID#config.deeplinking.disabled=true";
      //   if (await canLaunch(webUrl)) {
      //     await launch(webUrl);
      //   } else {
      //     throw Exception('Could not launch $url');
      //   }
      // }

      Get.to(() => ClassOrMeetingView(
          classUrl: webUrl,
          title: onlineClass.value == "jitsi"
              ? "Virtual live class".tr
              : "Virtual live meeting".tr));
    }
  }

  void _detectingUrl(String status) {
    switch (status) {
      case 'jitsi':
        url = InfixApi.jitsiClassList;
        title = "Jitsi";
        break;
      case 'jitsi_meeting':
        url = InfixApi.jitsiMeetingList;
        title = "Jitsi";
        break;
      case 'zoom':
        url = InfixApi.zoomClassList;
        title = "Zoom";
        break;
      case 'big_blue_button':
        url = InfixApi.bigBlueButtonClassList;
        title = "Big Blue Button";
        break;
      case 'big_blue_button_meeting':
        url = InfixApi.bigBlueButtonMeetingList;
        title = "Big Blue Button";
        break;
      case 'google_meet_class':
        url = InfixApi.googleMeetClassList;
        title = "Google Meet";
        break;
      case 'google_meet_meeting':
        url = InfixApi.googleMeetMeetingList;
        title = "Google Meet";
        break;
      case 'zoom_meeting':
        url = InfixApi.zoomMeetingList;
        title = "Zoom";
        break;
    }
  }

  @override
  void onInit() {
    onlineClass.value = Get.arguments["online_class"];
    _detectingUrl(onlineClass.value);
    loadData();
    super.onInit();
  }
}
