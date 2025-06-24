import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class LaunchWebviewController extends GetxController {

  String launchUrl = '';
  String title = 'Title';
  RxString url = "".obs;
  InAppWebViewController? webViewController;
  final GlobalKey webViewKey = GlobalKey();


  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  PullToRefreshController? pullToRefreshController;

  RxDouble progress = (0.0).obs;
  final urlController = TextEditingController();

  @override
  void onInit() {
    launchUrl = Get.arguments["url"];
    title = Get.arguments["title"];

    super.onInit();


    url.value = launchUrl;

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );

  }

  @override
  void dispose() {
    webViewController?.stopLoading();
    super.dispose();
  }

}
