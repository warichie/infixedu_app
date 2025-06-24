class FeesGroupListResponseModel {
  bool? success;
  List<FeesGroupData>? data;
  String? message;

  FeesGroupListResponseModel({this.success, this.data, this.message});

  FeesGroupListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <FeesGroupData>[];
      json['data'].forEach((v) {
        data!.add(FeesGroupData.fromJson(v));
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

class FeesGroupData {
  int? id;
  String? name;
  String? description;

  FeesGroupData({this.id, this.name, this.description});

  FeesGroupData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    return data;
  }
}
