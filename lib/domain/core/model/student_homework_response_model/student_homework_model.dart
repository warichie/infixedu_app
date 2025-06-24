class StudentHomeWorkModel {
  bool? success;
  Data? data;
  String? message;

  StudentHomeWorkModel({this.success, this.data, this.message});

  StudentHomeWorkModel.fromJson(Map<String, dynamic> json) {
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
  List<HomeworkLists>? homeworkLists;

  Data({this.homeworkLists});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['homeworkLists'] != null) {
      homeworkLists = <HomeworkLists>[];
      json['homeworkLists'].forEach((v) {
        homeworkLists!.add(HomeworkLists.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (homeworkLists != null) {
      data['homeworkLists'] = homeworkLists!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HomeworkLists {
  int? id;
  String? createdAt;
  String? submissionDate;
  String? evaluationDate;
  String? status;
  int? marks;
  String? subject;
  String? file;
  String? obtainedMarks;

  HomeworkLists({
    this.id,
    this.createdAt,
    this.submissionDate,
    this.evaluationDate,
    this.status,
    this.marks,
    this.subject,
    this.obtainedMarks,
    this.file,
  });

  HomeworkLists.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    submissionDate = json['submission_date'];
    evaluationDate = json['evaluation_date'];
    status = json['status'];
    marks = json['marks'];
    subject = json['subject'];
    file = json['file'];
    obtainedMarks = json['obtain_marks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['obtain_marks'] = obtainedMarks;
    data['id'] = id;
    data['created_at'] = createdAt;
    data['submission_date'] = submissionDate;
    data['evaluation_date'] = evaluationDate;
    data['status'] = status;
    data['marks'] = marks;
    data['subject'] = subject;
    data['file'] = file;
    return data;
  }
}
