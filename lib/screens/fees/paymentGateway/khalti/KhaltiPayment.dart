import 'package:flutter/material.dart';
import 'package:infixedu/config/app_config.dart';
import 'package:webview_flutter/webview_flutter.dart';

class KhaltiPayment extends StatefulWidget {
  final String? checkoutUrl;
  final Function? onFinish;

  const KhaltiPayment({Key? key, this.checkoutUrl, this.onFinish})
      : super(key: key);

  @override
  _KhaltiPaymentState createState() => _KhaltiPaymentState();
}

class _KhaltiPaymentState extends State<KhaltiPayment> {
  late final WebViewController _controller;
  final String returnURL = AppConfig.domainName;

  @override
  void initState() {
    super.initState();
    if (widget.checkoutUrl != null) {
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
              print(request.url);
              if (request.url.contains(returnURL)) {
                final uri = Uri.parse(request.url);
                final status = uri.queryParameters['status'];
                final idx = uri.queryParameters['idx'];
                print("Status => $status");
                print("txn => $idx");
                if (status == "200") {
                  final data = {
                    'id': idx ?? '',
                    'status': status ?? '',
                  };
                  if (widget.onFinish != null) {
                    widget.onFinish!(data);
                  }
                }
              }
              return NavigationDecision.navigate;
            },
          ),
        )
        ..loadRequest(Uri.parse(widget.checkoutUrl!));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.checkoutUrl != null) {
      return WillPopScope(
        onWillPop: () async {
          // Optionally handle back press
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Khalti Payment"),
            backgroundColor: Colors.black12,
            elevation: 0.0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: WebViewWidget(
            controller: _controller,
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: const CircularProgressIndicator(),
        ),
      );
    }
  }
}
