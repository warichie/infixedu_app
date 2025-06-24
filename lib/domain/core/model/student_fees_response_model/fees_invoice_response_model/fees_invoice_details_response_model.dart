class FeesInvoiceDetailsResponseModel {
  bool? success;
  Data? data;
  String? message;

  FeesInvoiceDetailsResponseModel({this.success, this.data, this.message});

  FeesInvoiceDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  List<PaymentMethods>? paymentMethods;
  List<BankAccounts>? bankAccounts;
  FeesInvoiceInfo? invoiceInfo;
  List<FeesInvoiceDetails>? invoiceDetails;

  Data(
      {this.paymentMethods,
        this.bankAccounts,
        this.invoiceInfo,
        this.invoiceDetails});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['paymentMethods'] != null) {
      paymentMethods = <PaymentMethods>[];
      json['paymentMethods'].forEach((v) {
        paymentMethods!.add(PaymentMethods.fromJson(v));
      });
    }
    if (json['bankAccounts'] != null) {
      bankAccounts = <BankAccounts>[];
      json['bankAccounts'].forEach((v) {
        bankAccounts!.add(BankAccounts.fromJson(v));
      });
    }
    invoiceInfo = json['invoiceInfo'] != null
        ? FeesInvoiceInfo.fromJson(json['invoiceInfo'])
        : null;
    if (json['invoiceDetails'] != null) {
      invoiceDetails = <FeesInvoiceDetails>[];
      json['invoiceDetails'].forEach((v) {
        invoiceDetails!.add(FeesInvoiceDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (paymentMethods != null) {
      data['paymentMethods'] =
          paymentMethods!.map((v) => v.toJson()).toList();
    }
    if (bankAccounts != null) {
      data['bankAccounts'] = bankAccounts!.map((v) => v.toJson()).toList();
    }
    if (invoiceInfo != null) {
      data['invoiceInfo'] = invoiceInfo!.toJson();
    }
    if (invoiceDetails != null) {
      data['invoiceDetails'] =
          invoiceDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentMethods {
  int? id;
  String? name;

  PaymentMethods({this.name, this.id});

  PaymentMethods.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['method'] = name;
    return data;
  }
}

class BankAccounts {
  int? id;
  String? name;
  String? accountNumber;

  BankAccounts({this.id, this.name, this.accountNumber});

  BankAccounts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['bank_name'];
    accountNumber = json['account_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['bank_name'] = name;
    data['account_number'] = accountNumber;
    return data;
  }
}

class FeesInvoiceInfo {
  int? recordId;
  int? studentId;
  String? studentPhoto;
  String? fullName;
  int? admissionNo;
  int? rollNo;
  String? classed;
  String? section;
  num? walletBalance;

  FeesInvoiceInfo(
      {this.recordId,
        this.studentId,
        this.studentPhoto,
        this.fullName,
        this.admissionNo,
        this.rollNo,
        this.classed,
        this.section,
        this.walletBalance});

  FeesInvoiceInfo.fromJson(Map<String, dynamic> json) {
    recordId = json['record_id'];
    studentId = json['student_id'];
    studentPhoto = json['student_photo'];
    fullName = json['full_name'];
    admissionNo = json['admission_no'];
    rollNo = json['roll_no'];
    classed = json['classed'];
    section = json['section'];
    walletBalance = json['wallet_balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['record_id'] = recordId;
    data['student_id'] = studentId;
    data['student_photo'] = studentPhoto;
    data['full_name'] = fullName;
    data['admission_no'] = admissionNo;
    data['roll_no'] = rollNo;
    data['classed'] = classed;
    data['section'] = section;
    data['wallet_balance'] = walletBalance;
    return data;
  }
}

class FeesInvoiceDetails {
  FeesType? feesType;
  num? amount;
  num? dueAmount;
  num? weaver;
  num? fine;

  FeesInvoiceDetails(
      {this.feesType, this.amount, this.dueAmount, this.weaver, this.fine});

  FeesInvoiceDetails.fromJson(Map<String, dynamic> json) {
    feesType = json['fees_type'] != null
        ? FeesType.fromJson(json['fees_type'])
        : null;
    amount = json['amount'];
    dueAmount = json['due_amount'];
    weaver = json['weaver'];
    fine = json['fine'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (feesType != null) {
      data['fees_type'] = feesType!.toJson();
    }
    data['amount'] = amount;
    data['due_amount'] = dueAmount;
    data['weaver'] = weaver;
    data['fine'] = fine;
    return data;
  }
}

class FeesType {
  int? id;
  String? name;

  FeesType({this.id, this.name});

  FeesType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
