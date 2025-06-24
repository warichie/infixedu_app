class AdminSubAttenSearchIndividualResponseModel {
  bool? success;
  Data? data;
  String? message;

  AdminSubAttenSearchIndividualResponseModel(
      {this.success, this.data, this.message});

  AdminSubAttenSearchIndividualResponseModel.fromJson(
      Map<String, dynamic> json) {
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
  int? subjectNameId;
  List<AdminSubAttenStudents>? students;

  Data({this.subjectNameId, this.students});

  Data.fromJson(Map<String, dynamic> json) {
    subjectNameId = json['subject_name_id'];
    if (json['students'] != null) {
      students = <AdminSubAttenStudents>[];
      json['students'].forEach((v) {
        students!.add(AdminSubAttenStudents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subject_name_id'] = subjectNameId;
    if (students != null) {
      data['students'] = students!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AdminSubAttenStudents {
  int? studentId;
  int? recordId;
  String? fullName;
  String? note;
  String? attendanceType;
  String? studentPhoto;
  String? className;
  String? section;

  AdminSubAttenStudents({
    this.studentId,
    this.recordId,
    this.fullName,
    this.note,
    this.attendanceType,
    this.studentPhoto,
    this.className,
    this.section,
  });

  AdminSubAttenStudents.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    recordId = json['record_id'];
    fullName = json['full_name'];
    note = json['note'];
    attendanceType = json['attendance_type'];
    studentPhoto = json['student_photo'];
    className = json['class'];
    section = json['section'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student_id'] = studentId;
    data['record_id'] = recordId;
    data['full_name'] = fullName;
    data['note'] = note;
    data['attendance_type'] = attendanceType;
    data['student_photo'] = studentPhoto;
    data['class'] = className;
    data['section'] = section;
    return data;
  }
}
