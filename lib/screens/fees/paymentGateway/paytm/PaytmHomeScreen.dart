import 'dart:async';
import 'dart:convert';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

// Project imports:
import 'package:infixedu/utils/Utils.dart';
import 'package:infixedu/utils/apis/Apis.dart';
import 'package:infixedu/screens/fees/model/Fee.dart';
import 'PaymentStatusScreen.dart';
import 'settings.dart';

class PaytmPayment extends StatefulWidget {
  final FeeElement fee;
  final String amount;
  final String email;

  const PaytmPayment(this.fee, this.amount, this.email, {Key? key})
      : super(key: key);

  @override
  _PaytmPaymentState createState() => _PaytmPaymentState();
}

class _PaytmPaymentState extends State<PaytmPayment> {
  late final WebViewController _controller;
  String? amount;
  bool isGet = false;
  bool isCompleted = false;

  _PaytmPaymentState();

  static int val = DateTime.now().millisecondsSinceEpoch;
  final orderId = 'INFIX_$val';
  final customerId = '$val';
  String email = '';
  String id = '';

  @override
  void initState() {
    super.initState();

    email = widget.email;

    Utils.getStringValue('id').then((value) {
      id = value ?? '';
    });

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            // Perform actions when page is finished loading, if needed
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains('callback') && isGet) {
              _controller.runJavaScript('document.cookie').then((cookies) {
                // print("cookies $cookies");

                final uri = Uri.parse(request.url);
                final txnid = uri.queryParameters['TXNID'];
                final status = uri.queryParameters['STATUS'];
                final respCode = uri.queryParameters['RESPCODE'];
                final respMsg = uri.queryParameters['RESPMSG'];
                final txnDate = uri.queryParameters['TXNDATE'];

                print('TXNID $txnid');
                print('STATUS $status');
                print('RESPCODE $respCode');
                print('RESPMSG $respMsg');
                print('TXNDATE $txnDate');

                isPaymentSuccessful().then((value) {
                  if (value) {
                    setState(() {
                      isCompleted = true;
                      isGet = false;
                    });
                  }
                });
              });
            } else if (request.url.contains('request1.jsp')) {
              setState(() {
                isGet = true;
              });
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(Settings.apiUrl + getQueryParams()));
  }

  String getQueryParams() {
    return '?order_id=$orderId&customer_id=$customerId&amount=$amount&email=$email';
  }

  Future<bool> isPaymentSuccessful() async {
    final response = await http.get(Uri.parse(InfixApi.studentFeePayment(
        id,
        int.parse(widget.fee.feesTypeId.toString()),
        amount ?? '',
        id,
        'PayTm')));
    var jsonData = json.decode(response.body);
    return jsonData['success'];
  }

  @override
  Widget build(BuildContext context) {
    return isCompleted
        ? PaymentStatusScreen(widget.fee, amount ?? '')
        : Scaffold(
            appBar: AppBar(
              title: const Text("Pay using PayTM"),
            ),
            body: WebViewWidget(
              controller: _controller,
            ),
          );
  }
}
