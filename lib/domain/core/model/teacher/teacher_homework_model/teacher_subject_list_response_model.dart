class TeacherSubjectListResponseModel {
  bool? success;
  List<TeacherSubjectListData>? data;
  String? message;

  TeacherSubjectListResponseModel({this.success, this.data, this.message});

  TeacherSubjectListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <TeacherSubjectListData>[];
      json['data'].forEach((v) {
        data!.add(TeacherSubjectListData.fromJson(v));
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

class TeacherSubjectListData {
  int? id;
  String? name; /// changed subject name to name for dropdown

  TeacherSubjectListData({this.id, this.name});

  TeacherSubjectListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['subject_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['subject_name'] = name;
    return data;
  }
}
