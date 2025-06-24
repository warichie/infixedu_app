import 'package:flutter_paystack_max/flutter_paystack_max.dart';

class AppConfig {
  // static String domainName = 'https://infixedu.ischooll.com';
  // static String imageBaseUrl = 'https://infixedu.ischooll.com';

  static String domainName = 'https://spondan.com/spn4/app/infixedu/ios';
  static String imageBaseUrl = 'https://spondan.com/spn4/app/infixedu/ios';

  static String appName = "InfixEdu";

  static bool isDemo = false;

  static String getExtension(String url) {
    var parts = url.split("/");
    return parts[parts.length - 1];
  }

  /// ....................................................
  /// Stripe Payment Gateway
  static const String stripeServerURL =
      'https://api.stripe.com/v1/payment_intents';
  static String stripeCurrency = "USD".toUpperCase();
  static const String stripeMerchantID = "merchant.thegreatestmarkeplace";
  static const String stripePublishableKey =
      "pk_test_51OTydVHHgGZ1rB2oCwA3d4UjhW1ajimcjqR65FczIBSZqyYtaGl58N5zHwXxuC6w39UjAQmSBLXmoUoe9CZuxnoP00VWEgjtvZ";
  static const String stripeToken =
      'sk_test_51OTydVHHgGZ1rB2oIpSFP0VPpk92x5vXBC30rGfbjITnq3IfjSYZRqOQ78sqTqEX7opbWgqxGxQkPOWbIjUbmBtL00kbanmzce';
  // static const String appPackageName = "com.infix.lms";

  ///
  ///PAYPAL
  ///
  static const String paypalDomain =
      "https://api.sandbox.paypal.com"; // "https://api.paypal.com"; // for production mode
  static const String paypalCurrency = 'USD';
  static const String paypalClientId =
      'AQgAWV4PlM9g81xZ51TLtVi68KjB89s4mpcchFschs7OvTM-3p4zsQTDqHOkv5Sw44k9goHlE-VAC7zj';
  static const String paypalClientSecret =
      'ELLoQfnZ4kRbDkul81U_RNRsgHgFPDumlUloCcX6nO6ziXRXKob8gVYaTn6CGCeNVJtBqsfv7VtbsuR2';
  static const bool sandboxMood = true;

  ///
  /// Paystack
  ///
  static const String payStackPublicKey =
      "pk_test_d85ff3d14475233d9da27df301185459f5d148b0";
  static const String payStackSecretKey =
      "sk_test_ee55a9b27d06843d868851a81362018d1aa9ff90";
  static const PaystackCurrency payStackCurrency = PaystackCurrency.zar;
  // static const String payStackCurrency = 'ZAR';
}
