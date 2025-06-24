class BankListResponseModel {
  bool? success;
  List<BankList>? data;
  String? message;

  BankListResponseModel({this.success, this.data, this.message});

  BankListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <BankList>[];
      json['data'].forEach((v) {
        data!.add(BankList.fromJson(v));
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

class BankList {
  int? id;
  String? name; /// Changed bank name to name for dropdown

  BankList({this.id, this.name});

  BankList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['bank_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['bank_name'] = name;
    return data;
  }
}
