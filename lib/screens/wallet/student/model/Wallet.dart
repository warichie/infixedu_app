// To parse this JSON data, do
//
//     final wallet = walletFromJson(jsonString);

import 'dart:convert';

Wallet walletFromJson(String str) => Wallet.fromJson(json.decode(str));

String walletToJson(Wallet data) => json.encode(data.toJson());

class Wallet {
  Wallet({
    this.currencySymbol,
    this.myBalance,
    this.paymentMethods,
    this.bankAccounts,
    this.walletTransactions,
    this.stripeInfo,
    this.razorpayInfo,
  });

  String? currencySymbol;
  num? myBalance;
  List<PaymentMethod>? paymentMethods;
  List<BankAccount>? bankAccounts;
  List<WalletTransaction>? walletTransactions;
  StripeInfo? stripeInfo;
  dynamic razorpayInfo;

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        currencySymbol: json["currencySymbol"],
        myBalance: num.tryParse("${json["myBalance"]}"),
        paymentMethods: List<PaymentMethod>.from(
            json["paymentMethods"].map((x) => PaymentMethod.fromJson(x))),
        bankAccounts: List<BankAccount>.from(
            json["bankAccounts"].map((x) => BankAccount.fromJson(x))),
        walletTransactions: List<WalletTransaction>.from(
            json["walletTransactions"]
                .map((x) => WalletTransaction.fromJson(x))),
        stripeInfo: StripeInfo.fromJson(json["stripe_info"]),
        razorpayInfo: json["razorpay_info"],
      );

  Map<String, dynamic> toJson() => {
        "currencySymbol": currencySymbol,
        "myBalance": myBalance,
        "paymentMethods":
            List<dynamic>.from(paymentMethods?.map((x) => x.toJson()) ?? []),
        "bankAccounts":
            List<dynamic>.from(bankAccounts?.map((x) => x.toJson()) ?? []),
        "walletTransactions": List<dynamic>.from(
            walletTransactions?.map((x) => x.toJson()) ?? []),
        "stripe_info": stripeInfo?.toJson(),
        "razorpay_info": razorpayInfo,
      };
}

class BankAccount {
  BankAccount({
    this.id,
    this.bankName,
    this.accountName,
    this.accountNumber,
    this.accountType,
    this.openingBalance,
    this.currentBalance,
    this.note,
    this.activeStatus,
    this.schoolId,
    this.academicId,
  });

  int? id;
  String? bankName;
  String? accountName;
  String? accountNumber;
  String? accountType;
  num? openingBalance;
  num? currentBalance;
  dynamic note;
  int? activeStatus;
  int? schoolId;
  int? academicId;

  factory BankAccount.fromJson(Map<String, dynamic> json) => BankAccount(
        id: json["id"],
        bankName: json["bank_name"],
        accountName: json["account_name"],
        accountNumber: json["account_number"],
        accountType: json["account_type"],
        openingBalance: num.parse("${json["opening_balance"]}"),
        currentBalance: num.parse("${json["current_balance"]}"),
        note: json["note"],
        activeStatus: json["active_status"],
        schoolId: json["school_id"],
        academicId: json["academic_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bank_name": bankName,
        "account_name": accountName,
        "account_number": accountNumber,
        "account_type": accountType,
        "opening_balance": openingBalance,
        "current_balance": currentBalance,
        "note": note,
        "active_status": activeStatus,
        "school_id": schoolId,
        "academic_id": academicId,
      };
}

class PaymentMethod {
  PaymentMethod({
    this.id,
    this.method,
    this.type,
    this.activeStatus,
    this.gatewayId,
    this.schoolId,
  });

  int? id;
  String? method;
  String? type;
  int? activeStatus;
  dynamic gatewayId;
  int? schoolId;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        id: json["id"],
        method: json["method"],
        type: json["type"],
        activeStatus: int.tryParse("${json["active_status"]}"),
        gatewayId: json["gateway_id"],
        schoolId:  int.tryParse("${json["school_id"]}"),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "method": method,
        "type": type,
        "active_status": activeStatus,
        "gateway_id": gatewayId,
        "school_id": schoolId,
      };
}

class StripeInfo {
  StripeInfo({
    this.id,
    this.gatewayName,
    this.gatewayUsername,
    this.gatewayPassword,
    this.gatewaySignature,
    this.gatewayClientId,
    this.gatewayMode,
    this.gatewaySecretKey,
    this.gatewaySecretWord,
    this.gatewayPublisherKey,
    this.gatewayPrivateKey,
    this.activeStatus,
    this.bankDetails,
    this.chequeDetails,
    this.schoolId,
  });

  int? id;
  String? gatewayName;
  String? gatewayUsername;
  String? gatewayPassword;
  dynamic gatewaySignature;
  String? gatewayClientId;
  dynamic gatewayMode;
  String? gatewaySecretKey;
  String? gatewaySecretWord;
  dynamic gatewayPublisherKey;
  dynamic gatewayPrivateKey;
  int? activeStatus;
  dynamic bankDetails;
  dynamic chequeDetails;

  int? schoolId;

  factory StripeInfo.fromJson(Map<String, dynamic> json) => StripeInfo(
        id: json["id"],
        gatewayName: json["gateway_name"],
        gatewayUsername: json["gateway_username"],
        gatewayPassword: json["gateway_password"],
        gatewaySignature: json["gateway_signature"],
        gatewayClientId: json["gateway_client_id"],
        gatewayMode: json["gateway_mode"],
        gatewaySecretKey: json["gateway_secret_key"],
        gatewaySecretWord: json["gateway_secret_word"],
        gatewayPublisherKey: json["gateway_publisher_key"],
        gatewayPrivateKey: json["gateway_private_key"],
        activeStatus: int.tryParse("${json["active_status"]}"),
        bankDetails: json["bank_details"],
        chequeDetails: json["cheque_details"],
        schoolId: int.tryParse("${json["school_id"]}"),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "gateway_name": gatewayName,
        "gateway_username": gatewayUsername,
        "gateway_password": gatewayPassword,
        "gateway_signature": gatewaySignature,
        "gateway_client_id": gatewayClientId,
        "gateway_mode": gatewayMode,
        "gateway_secret_key": gatewaySecretKey,
        "gateway_secret_word": gatewaySecretWord,
        "gateway_publisher_key": gatewayPublisherKey,
        "gateway_private_key": gatewayPrivateKey,
        "active_status": activeStatus,
        "bank_details": bankDetails,
        "cheque_details": chequeDetails,
        "school_id": schoolId,
      };
}

class WalletTransaction {
  WalletTransaction({
    this.id,
    this.amount,
    this.paymentMethod,
    this.userId,
    this.bankId,
    this.note,
    this.type,
    this.file,
    this.rejectNote,
    this.expense,
    this.status,
    this.createdBy,
    this.academicId,
    this.schoolId,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  num? amount;
  String? paymentMethod;
  int? userId;
  int? bankId;
  String? note;
  String? type;
  String? file;
  dynamic rejectNote;
  dynamic expense;
  String? status;
  dynamic createdBy;
  int? academicId;
  int? schoolId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory WalletTransaction.fromJson(Map<String, dynamic> json) {
    print(json);

    return WalletTransaction(
      id: json["id"],
      amount: num.tryParse("${json["amount"]}"),
      paymentMethod: json["payment_method"],
      userId: json["user_id"],
      bankId: json["bank_id"],
      note: json["note"],
      type: json["type"],
      file: json["file"],
      rejectNote: json["reject_note"],
      expense: json["expense"],
      status: json["status"],
      createdBy: json["created_by"],
      academicId: json["academic_id"],
      schoolId: json["school_id"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "payment_method": paymentMethod,
        "user_id": userId,
        "bank_id": bankId,
        "note": note,
        "type": type,
        "file": file,
        "reject_note": rejectNote,
        "expense": expense,
        "status": status,
        "created_by": createdBy,
        "academic_id": academicId,
        "school_id": schoolId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
