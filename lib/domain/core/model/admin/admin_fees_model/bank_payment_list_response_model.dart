class BankPaymentListResponseModel {
  bool? success;
  BankPaymentList? data;
  String? message;

  BankPaymentListResponseModel({this.success, this.data, this.message});

  BankPaymentListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? BankPaymentList.fromJson(json['data']) : null;
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

class BankPaymentList {
  List<ApproveList>? approve;
  List<PendingList>? pending;
  List<RejectedList>? reject;
  String? status;

  BankPaymentList({this.approve, this.pending, this.reject, this.status});

  BankPaymentList.fromJson(Map<String, dynamic> json) {
    if (json['approve'] != null) {
      approve = <ApproveList>[];
      json['approve'].forEach((v) {
        approve!.add(ApproveList.fromJson(v));
      });
    }
    if (json['pending'] != null) {
      pending = <PendingList>[];
      json['pending'].forEach((v) {
        pending!.add(PendingList.fromJson(v));
      });
    }
    if (json['reject'] != null) {
      reject = <RejectedList>[];
      json['reject'].forEach((v) {
        reject!.add(RejectedList.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (approve != null) {
      data['approve'] = approve!.map((v) => v.toJson()).toList();
    }
    if (pending != null) {
      data['pending'] = pending!.map((v) => v.toJson()).toList();
    }
    if (reject != null) {
      data['reject'] = reject!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}

class ApproveList {
  int? transactionId;
  String? studentName;
  ViewTransaction? viewTransaction;
  int? amount;
  String? date;
  String? feesType;
  String? note;
  String? file;
  String? status;

  ApproveList(
      {this.transactionId,
        this.studentName,
        this.viewTransaction,
        this.amount,
        this.date,
        this.feesType,
        this.note,
        this.file,
        this.status});

  ApproveList.fromJson(Map<String, dynamic> json) {
    transactionId = json['transaction_id'];
    studentName = json['student_name'];
    viewTransaction = json['view_transaction'] != null
        ? ViewTransaction.fromJson(json['view_transaction'])
        : null;
    amount = json['amount'];
    date = json['date'];
    feesType = json['fees_type'];
    note = json['note'];
    file = json['file'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['transaction_id'] = transactionId;
    data['student_name'] = studentName;
    if (viewTransaction != null) {
      data['view_transaction'] = viewTransaction!.toJson();
    }
    data['amount'] = amount;
    data['date'] = date;
    data['fees_type'] = feesType;
    data['note'] = note;
    data['file'] = file;
    data['status'] = status;
    return data;
  }
}
class RejectedList {
  int? transactionId;
  String? studentName;
  ViewTransaction? viewTransaction;
  int? amount;
  String? date;
  String? feesType;
  String? note;
  String? file;
  String? status;

  RejectedList(
      {this.transactionId,
        this.studentName,
        this.viewTransaction,
        this.amount,
        this.date,
        this.feesType,
        this.note,
        this.file,
        this.status});

  RejectedList.fromJson(Map<String, dynamic> json) {
    transactionId = json['transaction_id'];
    studentName = json['student_name'];
    viewTransaction = json['view_transaction'] != null
        ? ViewTransaction.fromJson(json['view_transaction'])
        : null;
    amount = json['amount'];
    date = json['date'];
    feesType = json['fees_type'];
    note = json['note'];
    file = json['file'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['transaction_id'] = transactionId;
    data['student_name'] = studentName;
    if (viewTransaction != null) {
      data['view_transaction'] = viewTransaction!.toJson();
    }
    data['amount'] = amount;
    data['date'] = date;
    data['fees_type'] = feesType;
    data['note'] = note;
    data['file'] = file;
    data['status'] = status;
    return data;
  }
}
class PendingList {
  int? transactionId;
  String? studentName;
  ViewTransaction? viewTransaction;
  int? amount;
  String? date;
  String? feesType;
  String? note;
  String? file;
  String? status;

  PendingList(
      {this.transactionId,
        this.studentName,
        this.viewTransaction,
        this.amount,
        this.date,
        this.note,
        this.file,
        this.status, this.feesType});

  PendingList.fromJson(Map<String, dynamic> json) {
    transactionId = json['transaction_id'];
    studentName = json['student_name'];
    viewTransaction = json['view_transaction'] != null
        ? ViewTransaction.fromJson(json['view_transaction'])
        : null;
    amount = json['amount'];
    date = json['date'];
    feesType = json['fees_type'];
    note = json['note'];
    file = json['file'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['transaction_id'] = transactionId;
    data['student_name'] = studentName;
    if (viewTransaction != null) {
      data['view_transaction'] = viewTransaction!.toJson();
    }
    data['amount'] = amount;
    data['date'] = date;
    data['fees_type'] = feesType;
    data['note'] = note;
    data['file'] = file;
    data['status'] = status;
    return data;
  }
}

class ViewTransaction {
  String? feesType;
  int? paidAmount;

  ViewTransaction({this.feesType, this.paidAmount});

  ViewTransaction.fromJson(Map<String, dynamic> json) {
    feesType = json['fees_type'];
    paidAmount = json['paid_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fees_type'] = feesType;
    data['paid_amount'] = paidAmount;
    return data;
  }
}




