class PaymentResponseModel {
  bool? success;
  PaymentData? data;
  String? message;

  PaymentResponseModel({this.success, this.data, this.message});

  PaymentResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? PaymentData.fromJson(json['data']) : null;
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

class PaymentData {
  String? addAmount;
  String? addMethod;
  String? addStatus;
  String? addType;

  PaymentData({this.addAmount, this.addMethod, this.addStatus, this.addType});

  PaymentData.fromJson(Map<String, dynamic> json) {
    addAmount = json['add_amount'].toString();
    addMethod = json['add_method'];
    addStatus = json['add_status'];
    addType = json['add_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['add_amount'] = addAmount;
    data['add_method'] = addMethod;
    data['add_status'] = addStatus;
    data['add_type'] = addType;
    return data;
  }
}
