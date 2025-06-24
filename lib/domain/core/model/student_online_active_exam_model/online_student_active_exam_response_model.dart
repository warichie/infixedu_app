
class StudentOnlineActiveExamResponseModel {
  bool? success;
  List<ActiveExamData>? data;
  String? message;

  StudentOnlineActiveExamResponseModel({this.success, this.data, this.message});

  StudentOnlineActiveExamResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <ActiveExamData>[];
      json['data'].forEach((v) {
        data!.add(ActiveExamData.fromJson(v));
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

class ActiveExamData {
  int? id;
  String? title;
  String? classSection;
  String? subject;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  String? duration;
  String? status;

  ActiveExamData(
      {this.id,
        this.title,
        this.classSection,
        this.subject,
        this.startDate,
        this.endDate,
        this.startTime,
        this.endTime,
        this.duration,
        this.status});

  ActiveExamData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    classSection = json['class_section'];
    subject = json['subject'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    duration = json['duration'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['class_section'] = classSection;
    data['subject'] = subject;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['duration'] = duration;
    data['status'] = status;
    return data;
  }
}
