class FeesResponseModel {
  bool? success;
  FeesDetailsData? data;
  String? message;

  FeesResponseModel({this.success, this.data, this.message});

  FeesResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? FeesDetailsData.fromJson(json['data']) : null;
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

class FeesDetailsData {
  InvoiceInfo? invoiceInfo;
  List<InvoiceDetails>? invoiceDetails;

  FeesDetailsData({this.invoiceInfo, this.invoiceDetails});

  FeesDetailsData.fromJson(Map<String, dynamic> json) {
    invoiceInfo = json['invoiceInfo'] != null
        ? InvoiceInfo.fromJson(json['invoiceInfo'])
        : null;
    if (json['invoiceDetails'] != null) {
      invoiceDetails = <InvoiceDetails>[];
      json['invoiceDetails'].forEach((v) {
        invoiceDetails!.add(InvoiceDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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

class InvoiceInfo {
  String? dueDate;

  InvoiceInfo({this.dueDate});

  InvoiceInfo.fromJson(Map<String, dynamic> json) {
    dueDate = json['due_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['due_date'] = dueDate;
    return data;
  }
}

class InvoiceDetails {
  String? subTotal;
  String? paidAmount;
  String? paymentStatus;
  String? feesType;
  String? note;
  String? amount;
  String? weaver;
  String? fine;
  String? total;
  String? totalAmount;
  String? totalWaiver;
  String? totalFine;
  String? totalServiceCharge;
  String? totalPaid;
  String? grandTotal;
  String? dueBalance;

  InvoiceDetails(
      {this.subTotal,
        this.paidAmount,
        this.paymentStatus,
        this.feesType,
        this.note,
        this.amount,
        this.weaver,
        this.fine,
        this.total,
        this.totalAmount,
        this.totalWaiver,
        this.totalFine,
        this.totalServiceCharge,
        this.totalPaid,
        this.grandTotal,
        this.dueBalance});

  InvoiceDetails.fromJson(Map<String, dynamic> json) {
    subTotal = json['sub_total'];
    paidAmount = json['paid_amount'];
    paymentStatus = json['payment_status'];
    feesType = json['fees_type'];
    note = json['note'];
    amount = json['amount'];
    weaver = json['weaver'];
    fine = json['fine'];
    total = json['total'];
    totalAmount = json['total_amount'];
    totalWaiver = json['total_waiver'];
    totalFine = json['total_fine'];
    totalServiceCharge = json['total_service_charge'];
    totalPaid = json['total_paid'];
    grandTotal = json['grand_total'];
    dueBalance = json['due_balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sub_total'] = subTotal;
    data['paid_amount'] = paidAmount;
    data['payment_status'] = paymentStatus;
    data['fees_type'] = feesType;
    data['note'] = note;
    data['amount'] = amount;
    data['weaver'] = weaver;
    data['fine'] = fine;
    data['total'] = total;
    data['total_amount'] = totalAmount;
    data['total_waiver'] = totalWaiver;
    data['total_fine'] = totalFine;
    data['total_service_charge'] = totalServiceCharge;
    data['total_paid'] = totalPaid;
    data['grand_total'] = grandTotal;
    data['due_balance'] = dueBalance;
    return data;
  }
}
