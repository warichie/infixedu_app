class AdminAttenSubSearchIndividualDetailsResponseModel {
  bool? success;
  Data? data;
  String? message;

  AdminAttenSubSearchIndividualDetailsResponseModel(
      {this.success, this.data, this.message});

  AdminAttenSubSearchIndividualDetailsResponseModel.fromJson(
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
  String? className;
  String? sectionName;
  String? subjectName;
  List<AdminAttendances>? attendances;
  int? days;
  int? totalPresent;
  int? totalAbsent;
  int? totalLate;
  int? totalHalfDay;
  int? totalHolyDay;
  String? currentDay;
  String? status;

  Data(
      {this.className,
        this.sectionName,
        this.subjectName,
        this.attendances,
        this.days,
        this.totalPresent,
        this.totalAbsent,
        this.totalLate,
        this.totalHalfDay,
        this.totalHolyDay,
        this.currentDay,
        this.status,});

  Data.fromJson(Map<String, dynamic> json) {
    className = json['class_name'];
    sectionName = json['section_name'];
    subjectName = json['subject_name'];
    if (json['attendances'] != null) {
      attendances = <AdminAttendances>[];
      json['attendances'].forEach((v) {
        attendances!.add(AdminAttendances.fromJson(v));
      });
    }
    days = json['days'];
    totalPresent = json['total_present'];
    totalAbsent = json['total_absent'];
    totalLate = json['total_late'];
    totalHalfDay = json['total_half_day'];
    totalHolyDay = json['total_holiday'];
    currentDay = json['current_day'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['class_name'] = className;
    data['section_name'] = sectionName;
    data['subject_name'] = subjectName;
    if (attendances != null) {
      data['attendances'] = attendances!.map((v) => v.toJson()).toList();
    }
    data['days'] = days;
    data['total_present'] = totalPresent;
    data['total_absent'] = totalAbsent;
    data['total_late'] = totalLate;
    data['total_half_day'] = totalHalfDay;
    data['total_holiday'] = totalHolyDay;
    data['current_day'] = currentDay;
    data['status'] = status;
    return data;
  }
}

class AdminAttendances {
  String? attendanceType;
  DateTime? attendanceDate;

  AdminAttendances({this.attendanceType, this.attendanceDate});

  AdminAttendances.fromJson(Map<String, dynamic> json) {
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
