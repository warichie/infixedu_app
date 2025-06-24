class AdminFeesTypeResponseModel {
  bool? success;
  Data? data;
  String? message;

  AdminFeesTypeResponseModel({this.success, this.data, this.message});

  AdminFeesTypeResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<FeesTypes>? feesTypes;

  Data({this.feesTypes});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['fees_types'] != null) {
      feesTypes = <FeesTypes>[];
      json['fees_types'].forEach((v) {
        feesTypes!.add(FeesTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (feesTypes != null) {
      data['fees_types'] = feesTypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FeesTypes {
  int? id;
  String? name;
  String? description;
  int? feesGroup;

  FeesTypes({this.id, this.name, this.description, this.feesGroup});

  FeesTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    feesGroup = json['fees_group_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['fees_group_id'] = feesGroup;
    return data;
  }
}
