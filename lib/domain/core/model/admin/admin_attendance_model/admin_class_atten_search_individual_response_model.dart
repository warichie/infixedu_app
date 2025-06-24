class AdminClassAttenSearchIndividualResponseModel {
  bool? success;
  Data? data;
  String? message;

  AdminClassAttenSearchIndividualResponseModel({this.success, this.data, this.message});

  AdminClassAttenSearchIndividualResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<AdminStudentsIndividualData>? students;

  Data({this.students});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['students'] != null) {
      students = <AdminStudentsIndividualData>[];
      json['students'].forEach((v) { students!.add(AdminStudentsIndividualData.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (students != null) {
      data['students'] = students!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AdminStudentsIndividualData {
  int? id;
  String? fullName;
  String? className;
  String? section;
  String? studentPhoto;

  AdminStudentsIndividualData({this.id, this.fullName, this.className, this.section, this.studentPhoto});

  AdminStudentsIndividualData.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  fullName = json['full_name'];
className = json['class'];
  section = json['section'];
  studentPhoto = json['student_photo'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = id;
  data['full_name'] = fullName;
  data['class'] = className;
  data['section'] = section;
  data['student_photo'] = studentPhoto;
  return data;
  }
}
