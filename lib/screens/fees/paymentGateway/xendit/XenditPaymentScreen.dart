import 'dart:core';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:webview_flutter/webview_flutter.dart';

// Project imports:
import 'package:infixedu/config/app_config.dart';
import 'package:infixedu/utils/CustomAppBarWidget.dart';
import 'package:infixedu/screens/fees/model/Fee.dart';
import 'package:infixedu/utils/model/PaymentMethod.dart';

class XenditPaymentScreen extends StatefulWidget {
  final Function? onFinish;
  final PaymentMethod? payment;
  final FeeElement? fee;
  final String? amount;
  final String? redirectUrl;
  final String? authenticationId;

  const XenditPaymentScreen({
    Key? key,
    this.onFinish,
    this.payment,
    this.fee,
    this.amount,
    this.redirectUrl,
    this.authenticationId,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => XenditPaymentScreenState();
}

class XenditPaymentScreenState extends State<XenditPaymentScreen> {
  late final WebViewController _controller;

  Map<dynamic, dynamic> defaultCurrency = {
    "symbol": "$paypalCurrency ",
    "decimalDigits": 2,
    "symbolBeforeTheNumber": true,
    "currency": paypalCurrency
  };

  @override
  void initState() {
    super.initState();

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
            if (request.url ==
                "https://redirect.xendit.co/callbacks/authentications/cybs/bundled/${widget.authenticationId}?api_key=$xenditPublicKey") {
              print('matched');
              Future.delayed(const Duration(seconds: 3), () {
                if (widget.onFinish != null) {
                  widget.onFinish!(widget.authenticationId);
                }
                Navigator.of(context).pop();
              });
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.redirectUrl ?? ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        title: "Xendit Payment",
      ),
      backgroundColor: Colors.white,
      body: widget.redirectUrl != null
          ? WebViewWidget(
              controller: _controller,
            )
          : Center(child: const CircularProgressIndicator()),
    );
  }
}
