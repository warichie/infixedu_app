class DormitoryListResponseModel {
  bool? success;
  List<DormitoryListData>? data;
  String? message;

  DormitoryListResponseModel({this.success, this.data, this.message});

  DormitoryListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <DormitoryListData>[];
      json['data'].forEach((v) {
        data!.add(DormitoryListData.fromJson(v));
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

class DormitoryListData {
  int? id;
  String? name; /// dormitoryName => name

  DormitoryListData({this.id, this.name});

  DormitoryListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['dormitory_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['dormitory_name'] = name;
    return data;
  }
}
