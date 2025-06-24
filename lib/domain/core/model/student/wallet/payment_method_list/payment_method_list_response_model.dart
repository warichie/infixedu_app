class PaymentMethodListResponseModel {
  bool? success;
  List<PaymentMethodList>? data;
  String? message;

  PaymentMethodListResponseModel({this.success, this.data, this.message});

  PaymentMethodListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <PaymentMethodList>[];
      json['data'].forEach((v) {
        data!.add(PaymentMethodList.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class PaymentMethodList {
  int? id;
  String? name;  //// Changed method to name for drop down purpose

  PaymentMethodList({this.id, this.name});

  PaymentMethodList.fromJson(Map<String, dynamic> json) {
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
