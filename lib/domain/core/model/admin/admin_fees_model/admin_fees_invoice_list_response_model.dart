class AdminFeesInvoiceListResponseModel {
  bool? success;
  Data? data;
  String? message;

  AdminFeesInvoiceListResponseModel({this.success, this.data, this.message});

  AdminFeesInvoiceListResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<StudentInvoices>? studentInvoices;

  Data({this.studentInvoices});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['studentInvoices'] != null) {
      studentInvoices = <StudentInvoices>[];
      json['studentInvoices'].forEach((v) {
        studentInvoices!.add(StudentInvoices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (studentInvoices != null) {
      data['studentInvoices'] =
          studentInvoices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StudentInvoices {
  int? id;
  String? fullName;
  String? studentClass;
  String? section;
  String? date;
  String? amount;
  String? paid;
  String? balance;
  String? status;

  StudentInvoices(
      {this.id,
        this.fullName,
        this.studentClass,
        this.section,
        this.date,
        this.amount,
        this.paid,
        this.balance,
        this.status});

  StudentInvoices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    studentClass = json['class'];
    section = json['section'];
    date = json['date'];
    amount = json['amount'];
    paid = json['paid'];
    balance = json['balance'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['class'] = studentClass;
    data['section'] = section;
    data['date'] = date;
    data['amount'] = amount;
    data['paid'] = paid;
    data['balance'] = balance;
    data['status'] = status;
    return data;
  }
}
