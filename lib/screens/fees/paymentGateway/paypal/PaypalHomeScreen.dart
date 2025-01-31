import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:infixedu/screens/fees/model/Fee.dart';
import 'package:infixedu/screens/fees/paymentGateway/paytm/PaymentStatusScreen.dart';
import 'package:infixedu/screens/fees/widgets/fees_payment_row_widget.dart';
import 'package:infixedu/utils/CustomAppBarWidget.dart';
import 'package:infixedu/utils/apis/Apis.dart';
import 'package:infixedu/utils/widget/ScaleRoute.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class PayPalPayment extends StatefulWidget {
  final FeeElement fee;
  final String id;
  final String amount;
  final String apiUrl = 'http://192.168.1.113:3000/';

  PayPalPayment(this.fee, this.amount, this.id, {Key? key}) : super(key: key);

  @override
  _PayPalPaymentState createState() => _PayPalPaymentState(amount);
}

class _PayPalPaymentState extends State<PayPalPayment> {
  final String? amount;
  late final WebViewController _controller;
  bool isCompleted = false;

  _PayPalPaymentState(this.amount);

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) async {
            if (url.contains('success')) {
              bool success = await isPaymentSuccessful();
              if (success) {
                setState(() {
                  isCompleted = true;
                });
              }
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.apiUrl +
          '?name=${widget.fee.feesName}&amount=${widget.amount}&currency=INR'));
  }

  @override
  Widget build(BuildContext context) {
    return isCompleted
        ? PaymentStatusScreen(widget.fee, amount ?? '')
        : Scaffold(
            appBar: AppBar(
              title: const Text("Pay using PayPal"),
            ),
            body: WebViewWidget(controller: _controller),
          );
  }

  Future<bool> isPaymentSuccessful() async {
    final response = await http.get(Uri.parse(InfixApi.studentFeePayment(
      widget.id,
      int.parse(widget.fee.feesTypeId.toString()),
      amount ?? '',
      widget.id,
      'Paypal',
    )));
    var jsonData = json.decode(response.body);
    return jsonData['success'];
  }
}

class AddPaypalAmount extends StatelessWidget {
  final FeeElement fee;
  final String id;
  final TextEditingController amountController = TextEditingController();

  AddPaypalAmount(this.fee, this.id, {Key? key}) {
    amountController.text = '${absoluteAmount(fee.balance.toString())}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(title: 'Amount'),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: FeePaymentRow(fee),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              style: Theme.of(context).textTheme.titleLarge,
              controller: amountController,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'Please enter a valid amount';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Amount",
                labelText: "Amount",
                labelStyle: Theme.of(context).textTheme.headlineMedium,
                errorStyle: const TextStyle(
                  color: Colors.pinkAccent,
                  fontSize: 15.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  ScaleRoute(
                    page: PayPalPayment(
                      fee,
                      '${absoluteAmount(amountController.text)}',
                      id,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purpleAccent,
              ),
              child: Text(
                "Enter Amount",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  int absoluteAmount(String am) {
    int amount = int.parse(am);
    return amount < 0 ? -amount : amount;
  }
}
