class TeHomeworkEvaluationListResponseModel {
  bool? success;
  List<HomeworkList>? data;
  String? message;

  TeHomeworkEvaluationListResponseModel(
      {this.success, this.data, this.message});

  TeHomeworkEvaluationListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <HomeworkList>[];
      json['data'].forEach((v) {
        data!.add(HomeworkList.fromJson(v));
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

class HomeworkList {
  int? studentId;
  int? admissionNo;
  bool? evaluated;
  String? studentName;
  List<dynamic>? homeworkFiles;

  HomeworkList(
      {this.studentId,
        this.admissionNo,
        this.evaluated,
        this.studentName,
        this.homeworkFiles});

  HomeworkList.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    admissionNo = json['admission_no'];
    evaluated = json['evaluated'];
    studentName = json['student_name'];
    homeworkFiles = json['homework_files'] ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student_id'] = studentId;
    data['admission_no'] = admissionNo;
    data['evaluated'] = evaluated;
    data['student_name'] = studentName;
    data['homework_files'] = homeworkFiles;
    return data;
  }
}
