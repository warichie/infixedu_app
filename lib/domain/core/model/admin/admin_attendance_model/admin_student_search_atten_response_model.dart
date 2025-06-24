class AdminStudentSearchAttenResponseModel {
  bool? success;
  Data? data;
  String? message;

  AdminStudentSearchAttenResponseModel({this.success, this.data, this.message});

  AdminStudentSearchAttenResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<AdminStudentAttendanceSingleData>? attendances;
  String? currentDay;
  String? status;
  int? p;
  int? l;
  int? a;
  int? h;
  int? f;
  String? className;
  String? section;

  Data({this.attendances, this.currentDay, this.status, this.p, this.l, this.a, this.h, this.f, this.className, this.section});

  Data.fromJson(Map<String, dynamic> json) {
  if (json['attendances'] != null) {
  attendances = <AdminStudentAttendanceSingleData>[];
  json['attendances'].forEach((v) { attendances!.add(AdminStudentAttendanceSingleData.fromJson(v)); });
  }
  currentDay = json['current_day'];
  status = json['status'];
  p = json['P'];
  l = json['L'];
  a = json['A'];
  h = json['H'];
  f = json['F'];
  className = json['class'];
  section = json['section'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = <String, dynamic>{};
  if (attendances != null) {
  data['attendances'] = attendances!.map((v) => v.toJson()).toList();
  }
  data['current_day'] = currentDay;
  data['status'] = status;
  data['P'] = p;
  data['L'] = l;
  data['A'] = a;
  data['H'] = h;
  data['F'] = f;
  data['class'] = className;
  data['section'] = section;
  return data;
  }
}

class AdminStudentAttendanceSingleData {
  String? attendanceType;
  DateTime? attendanceDate;

  AdminStudentAttendanceSingleData({this.attendanceType, this.attendanceDate});

  AdminStudentAttendanceSingleData.fromJson(Map<String, dynamic> json) {
    attendanceType = json['attendance_type'];
    attendanceDate = DateTime.tryParse(json['attendance_date']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attendance_type'] = attendanceType;
    data['attendance_date'] = attendanceDate;
    return data;
  }
}
