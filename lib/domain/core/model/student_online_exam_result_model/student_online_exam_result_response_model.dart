class StudentOnlineExamResultResponseModel {
  bool? success;
  List<OnlineExamResultData>? data;
  String? message;

  StudentOnlineExamResultResponseModel({this.success, this.data, this.message});

  StudentOnlineExamResultResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <OnlineExamResultData>[];
      json['data'].forEach((v) {
        data!.add(OnlineExamResultData.fromJson(v));
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

class OnlineExamResultData {
  int? id;
  String? title;
  String? startDate;
  String? endDate;
  String? examTime;
  String? endTime;
  int? totalMarks;
  int? obtainedMarks;
  String? result;

  OnlineExamResultData(
      {this.id,
        this.title,
        this.startDate,
        this.endDate,
        this.examTime,
        this.endTime,
        this.totalMarks,
        this.obtainedMarks,
        this.result});

  OnlineExamResultData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    examTime = json['exam_time'];
    endTime = json['end_time'];
    totalMarks = json['total_marks'];
    obtainedMarks = json['obtained_marks'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['exam_time'] = examTime;
    data['end_time'] = endTime;
    data['total_marks'] = totalMarks;
    data['obtained_marks'] = obtainedMarks;
    data['result'] = result;
    return data;
  }
}

