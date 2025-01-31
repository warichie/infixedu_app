import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String url;

  const WebViewScreen(this.url, {Key? key}) : super(key: key);

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize WebViewController
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            // Perform actions when page is finished loading, if needed
          },
          onNavigationRequest: (NavigationRequest request) {
            if (Navigator.canPop(context)) {
              Navigator.of(context).pop();
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Close the webview and pop the screen
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Zoom"),
        ),
        body: WebViewWidget(
          controller: _controller,
        ),
      ),
    );
  }
}
