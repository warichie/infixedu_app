class StudentClassListResponseModel {
  bool? success;
  List<ClassListData>? data;
  String? message;

  StudentClassListResponseModel({this.success, this.data, this.message});

  StudentClassListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <ClassListData>[];
      json['data'].forEach((v) {
        data!.add(ClassListData.fromJson(v));
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

class ClassListData {
  int? id;
  String? name; /// className => name (dropdown value)

  ClassListData({this.id, this.name});

  ClassListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['class_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['class_name'] = name;
    return data;
  }
}
