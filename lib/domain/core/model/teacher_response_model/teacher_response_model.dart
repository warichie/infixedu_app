class TeacherResponseModel {
  bool? success;
  List<TeacherData>? data;
  String? message;

  TeacherResponseModel({this.success, this.data, this.message});

  TeacherResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <TeacherData>[];
      json['data'].forEach((v) {
        data!.add(TeacherData.fromJson(v));
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

class TeacherData {
  int? id;
  String? staffPhoto;
  String? fullName;
  String? subjectName;
  String? email;
  String? mobile;

  TeacherData(
      {this.id,
        this.staffPhoto,
        this.fullName,
        this.subjectName,
        this.email,
        this.mobile});

  TeacherData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    staffPhoto = json['staff_photo'];
    fullName = json['full_name'];
    subjectName = json['subject_name'];
    email = json['email'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['staff_photo'] = staffPhoto;
    data['full_name'] = fullName;
    data['subject_name'] = subjectName;
    data['email'] = email;
    data['mobile'] = mobile;
    return data;
  }
}
