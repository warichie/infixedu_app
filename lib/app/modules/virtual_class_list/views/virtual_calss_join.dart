import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/config/app_config.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';

class ClassOrMeetingView extends StatefulWidget {
  final String classUrl;
  final String? title;
  const ClassOrMeetingView({Key? key, required this.classUrl, this.title})
      : super(key: key);

  @override
  _ClassOrMeetingViewState createState() => _ClassOrMeetingViewState();
}

class _ClassOrMeetingViewState extends State<ClassOrMeetingView> {
  InAppWebViewController? webViewController;
  bool isLoginAttempted = false;
  bool isLoading = true; // Track loading state
  final GetStorage _box = GetStorage();
  var email = '';
  var pass = '';

  static String domainName = AppConfig.domainName;
  static String loginUrl = '$domainName/login';
  static String homeUrl = '$domainName/home';

  @override
  void initState() {
    super.initState();
    _requestPermissions();
    email = Get.find<GlobalRxVariableController>().email.value!;
    pass = _box.read('password') ?? "123456";
  }

  Future<void> _requestPermissions() async {
    await [
      Permission.microphone,
      Permission.camera,
    ].request();
  }

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: widget.title,
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () async {
              await webViewController?.reload();
            },
            child: InAppWebView(
              initialUrlRequest:
                  URLRequest(url: WebUri.uri(Uri.parse(widget.classUrl))),
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                  javaScriptEnabled: true,
                  mediaPlaybackRequiresUserGesture: false,
                ),
                android: AndroidInAppWebViewOptions(
                  allowContentAccess: true,
                  allowFileAccess: true,
                  useHybridComposition: true,
                ),
                ios: IOSInAppWebViewOptions(
                  allowsInlineMediaPlayback: true,
                ),
              ),
              androidOnPermissionRequest:
                  (controller, origin, resources) async {
                return PermissionRequestResponse(
                  resources: resources,
                  action: PermissionRequestResponseAction.GRANT,
                );
              },
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              onLoadStart: (controller, url) {
                if (url == null) return;
                print("Loading url : $url");
                setState(() {
                  isLoading = true;
                });
              },
              onLoadStop: (controller, url) async {
                if (url == null) return;

                // Check if we're on the login page and auto-login if not yet attempted
                if (url.toString() == loginUrl && !isLoginAttempted) {
                  await _attemptAutoLogin(controller);
                  isLoginAttempted = true;
                }

                // Check if the home page is loaded, then navigate to the virtual class page
                if (url.toString() == homeUrl) {
                  await controller.loadUrl(
                    urlRequest:
                        URLRequest(url: WebUri.uri(Uri.parse(widget.classUrl))),
                  );
                }
                // Hide loading indicator after the page finishes loading
                setState(() {
                  isLoading = false;
                });
              },
            ),
          ),
          // Show loading indicator if loading
          if (isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  // Method to attempt auto-login
  Future<void> _attemptAutoLogin(InAppWebViewController controller) async {
    print("Attempting to auto-login with email: $email and password: $pass");

    await controller.evaluateJavascript(source: """
    document.querySelector('input[name="email"]').value = '${email.replaceAll("'", "\\'")}';
    document.querySelector('input[name="password"]').value = '${pass.replaceAll("'", "\\'")}';
    document.querySelector('form').submit();
  """);
  }
}
