class StudentFeesInvoiceResponseModel {
  bool? success;
  Data? data;
  String? message;

  StudentFeesInvoiceResponseModel({this.success, this.data, this.message});

  StudentFeesInvoiceResponseModel.fromJson(Map<String, dynamic> json) {
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
  bool? newFees;
  List<FeesInvoice>? feesInvoice;

  Data({this.newFees, this.feesInvoice});

  Data.fromJson(Map<String, dynamic> json) {
    newFees = json['new_fees'];
    if (json['fees_invoice'] != null) {
      feesInvoice = <FeesInvoice>[];
      json['fees_invoice'].forEach((v) {
        feesInvoice!.add(FeesInvoice.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['new_fees'] = newFees;
    if (feesInvoice != null) {
      data['fees_invoice'] = feesInvoice!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FeesInvoice {
  int? id;
  String? fullName;
  String? feesClass;
  String? section;
  num? amount;
  num? waiver;
  num? fine;
  num? paidAmount;
  num? balance;
  String? status;
  String? createDate;

  FeesInvoice(
      {this.id,
        this.fullName,
        this.feesClass,
        this.section,
        this.amount,
        this.waiver,
        this.fine,
        this.paidAmount,
        this.balance,
        this.status,
        this.createDate});

  FeesInvoice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    feesClass = json['class'];
    section = json['section'];
    amount = json['amount'];
    waiver = json['waiver'];
    fine = json['fine'];
    paidAmount = json['paid_amount'];
    balance = json['balance'];
    status = json['status'];
    createDate = json['create_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['class'] = feesClass;
    data['section'] = section;
    data['amount'] = amount;
    data['waiver'] = waiver;
    data['fine'] = fine;
    data['paid_amount'] = paidAmount;
    data['balance'] = balance;
    data['status'] = status;
    data['create_date'] = createDate;
    return data;
  }
}
