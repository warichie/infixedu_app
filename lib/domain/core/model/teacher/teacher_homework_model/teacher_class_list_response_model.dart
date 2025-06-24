class TeacherClassListResponseModel {
  bool? success;
  List<TeacherClassListData>? data;
  String? message;

  TeacherClassListResponseModel({this.success, this.data, this.message});

  TeacherClassListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <TeacherClassListData>[];
      json['data'].forEach((v) {
        data!.add(TeacherClassListData.fromJson(v));
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

class TeacherClassListData {
  int? id;
  String? name;  /// Changed the className to name for using drop down

  TeacherClassListData({this.id, this.name});

  TeacherClassListData.fromJson(Map<String, dynamic> json) {
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
