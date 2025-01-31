import 'dart:core';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infixedu/screens/fees/controller/student_fees_controller.dart';
import 'package:infixedu/utils/CustomSnackBars.dart';

// Package imports:
import 'package:webview_flutter/webview_flutter.dart';

// Project imports:
import 'package:infixedu/config/app_config.dart';
import 'package:infixedu/utils/CustomAppBarWidget.dart';
import 'package:infixedu/utils/model/PaymentMethod.dart';
import 'paypal_service.dart';

class PaypalPayment extends StatefulWidget {
  final Function? onFinish;
  final PaymentMethod? payment;
  final String? fee;
  final String? amount;

  const PaypalPayment(
      {Key? key, this.onFinish, this.payment, this.fee, this.amount})
      : super(key: key);

  @override
  _PaypalPaymentState createState() => _PaypalPaymentState();
}

class _PaypalPaymentState extends State<PaypalPayment> {
  final StudentFeesController _studentFeesController =
      Get.put(StudentFeesController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final WebViewController _webViewController;
  String? checkoutUrl;
  String? executeUrl;
  String? accessToken;
  final PaypalServices services = PaypalServices();

  // You can change default currency according to your need
  Map<dynamic, dynamic> defaultCurrency = {
    "symbol": "$paypalCurrency ",
    "decimalDigits": 2,
    "symbolBeforeTheNumber": true,
    "currency": paypalCurrency
  };

  bool isEnableShipping = false;
  bool isEnableAddress = false;

  final String returnURL = 'return.example.com';
  final String cancelURL = 'cancel.example.com';

  @override
  void initState() {
    super.initState();

    if (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS) {
      // WebViewController needs initialization
      _webViewController = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageFinished: (String url) {
              print('Page finished loading: $url');
            },
            onNavigationRequest: (NavigationRequest request) {
              if (request.url.contains(returnURL)) {
                final uri = Uri.parse(request.url);
                final payerID = uri.queryParameters['PayerID'];
                if (payerID != null) {
                  services
                      .executePayment(executeUrl, payerID, accessToken)
                      .then((value) {
                    final data = {
                      'id': value.transactions?.first.relatedResources?.first
                              .sale?.id ??
                          '',
                      'status': value.payer?.status ?? '',
                    };
                    if (widget.onFinish != null) {
                      widget.onFinish!(data);
                    }
                  });
                } else {
                  Navigator.of(context).pop();
                }
                return NavigationDecision.navigate;
              }
              if (request.url.contains(cancelURL)) {
                _studentFeesController.isPaymentProcessing.value = false;
                Get.back();
                CustomSnackBar().snackBarError("Payment Cancelled".tr);
                return NavigationDecision.navigate;
              }
              return NavigationDecision.navigate;
            },
          ),
        );
    }

    Future.delayed(Duration.zero, () async {
      try {
        accessToken = await services.getAccessToken();
        final transactions = getOrderParams();
        final res =
            await services.createPaypalPayment(transactions, accessToken);
        if (res != null) {
          setState(() {
            checkoutUrl = res["approvalUrl"];
            executeUrl = res["executeUrl"];
          });
          _webViewController.loadRequest(Uri.parse(checkoutUrl!));
        }
      } catch (e) {
        print('Exception: ' + e.toString());
        final snackBar = SnackBar(
          content: Text(e.toString()),
          duration: const Duration(seconds: 10),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {},
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  Map<String, dynamic> getOrderParams() {
    final items = [
      {
        "name": widget.fee,
        "quantity": 1,
        "price": widget.amount,
        "currency": '${defaultCurrency["currency"]}',
      }
    ];

    final temp = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": [
        {
          "amount": {
            "total": widget.amount,
            "currency": defaultCurrency["currency"],
            "details": {
              "subtotal": widget.amount,
              "tax": 0,
              "shipping": 0,
            }
          },
          "description": "${AppConfig.appName} Fee Payment of ${widget.fee}",
          "payment_options": {
            "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
          },
          "item_list": {
            "items": items,
          }
        }
      ],
      "note_to_payer": "Contact us for any questions on your payment.",
      "redirect_urls": {"return_url": returnURL, "cancel_url": cancelURL}
    };
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    if (checkoutUrl != null) {
      return Scaffold(
        appBar: CustomAppBarWidget(
          title: "Paypal Payment",
        ),
        backgroundColor: Colors.white,
        body: WebViewWidget(
          controller: _webViewController,
        ),
      );
    } else {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Colors.black12,
          elevation: 0.0,
        ),
        body: Center(
          child: const CircularProgressIndicator(),
        ),
      );
    }
  }
}
