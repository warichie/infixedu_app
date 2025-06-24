import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:infixedu/app/data/constants/image_path.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/launch_webview_controller.dart';

class LaunchWebviewView extends GetView<LaunchWebviewController> {
  const LaunchWebviewView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            centerTitle: false,
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              padding: const EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImagePath.appToolbarBg),
                  fit: BoxFit.fill,
                ),
                color: Colors.deepPurple,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: SizedBox(
                      height: 70,
                      width: 70,
                      child: IconButton(
                          tooltip: 'Back'.tr,
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 22,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ),
                  ),
                  Text(
                    controller.title,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontSize: 20, color: Colors.white),
                  ),
                  Expanded(child: Container()),
                ],
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
        ),
        body: Column(children: <Widget>[
          Expanded(
            child: Stack(
              children: [
                InAppWebView(
                  key: controller.webViewKey,
                  initialUrlRequest: URLRequest(
                      url: WebUri.uri(Uri.parse(controller.url.value))),
                  initialOptions: controller.options,
                  pullToRefreshController: controller.pullToRefreshController,
                  onWebViewCreated: (controllers) {
                    controller.webViewController = controllers;
                  },
                  onLoadStart: (controllers, url) {
                    controller.url.value = url.toString();
                    controller.urlController.text = controller.url.value;
                  },
                  androidOnPermissionRequest:
                      (controller, origin, resources) async {
                    return PermissionRequestResponse(
                        resources: resources,
                        action: PermissionRequestResponseAction.GRANT);
                  },
                  shouldOverrideUrlLoading:
                      (controllers, navigationAction) async {
                    var uri = navigationAction.request.url;

                    if (![
                      "http",
                      "https",
                      "file",
                      "chrome",
                      "data",
                      "javascript",
                      "about"
                    ].contains(uri?.scheme)) {
                      // ignore: deprecated_member_use
                      if (await canLaunch(controller.url.value)) {
                        // Launch the App
                        // ignore: deprecated_member_use
                        await launch(
                          controller.url.value,
                        );
                        // and cancel the request
                        return NavigationActionPolicy.CANCEL;
                      }
                    }

                    return NavigationActionPolicy.ALLOW;
                  },
                  onLoadStop: (controllers, url) async {
                    controller.pullToRefreshController?.endRefreshing();
                    controller.url.value = url.toString();
                    controller.urlController.text = controller.url.value;
                  },
                  onLoadError: (controllers, url, code, message) {
                    controller.pullToRefreshController?.endRefreshing();
                  },
                  onProgressChanged: (controllers, progress) {
                    if (progress == 100) {
                      controller.pullToRefreshController?.endRefreshing();
                    }
                    controller.progress.value = progress / 100;
                    controller.urlController.text = controller.url.value;
                  },
                  onUpdateVisitedHistory: (controllers, url, androidIsReload) {
                    controller.url.value = url.toString();
                    controller.urlController.text = controller.url.value;
                  },
                  onConsoleMessage: (controller, consoleMessage) {},
                  onCloseWindow: (controller) {},
                ),
                controller.progress < 1.0
                    ? LinearProgressIndicator(value: controller.progress.value)
                    : Container(),
              ],
            ),
          ),
        ]));
  }
}
