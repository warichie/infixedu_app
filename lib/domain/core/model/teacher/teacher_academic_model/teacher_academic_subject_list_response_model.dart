class TeacherAcademicSubjectResponseModel {
  bool? success;
  List<TeacherAcademicSubjectData>? data;
  String? message;

  TeacherAcademicSubjectResponseModel({this.success, this.data, this.message});

  TeacherAcademicSubjectResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <TeacherAcademicSubjectData>[];
      json['data'].forEach((v) {
        data!.add(TeacherAcademicSubjectData.fromJson(v));
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

class TeacherAcademicSubjectData {
  int? id;
  String? subjectName;
  String? subjectCode;
  String? subjectType;

  TeacherAcademicSubjectData({this.id, this.subjectName, this.subjectCode, this.subjectType});

  TeacherAcademicSubjectData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subjectName = json['subject_name'];
    subjectCode = json['subject_code'];
    subjectType = json['subject_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['subject_name'] = subjectName;
    data['subject_code'] = subjectCode;
    data['subject_type'] = subjectType;
    return data;
  }
}
