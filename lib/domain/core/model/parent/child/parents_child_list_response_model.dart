class ParentsChildListResponseModel {
  bool? success;
  List<ParentChildData>? data;
  String? message;

  ParentsChildListResponseModel({this.success, this.data, this.message});

  ParentsChildListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <ParentChildData>[];
      json['data'].forEach((v) {
        data!.add(ParentChildData.fromJson(v));
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

class ParentChildData {
  int? studentId;
  String? fullName;
  String? className;
  String? section;
  String? imageUrl;

  ParentChildData(
      {this.studentId,
      this.fullName,
      this.className,
      this.section,
      this.imageUrl});

  ParentChildData.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    fullName = json['full_name'];
    className = json['class'];
    section = json['section'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student_id'] = studentId;
    data['full_name'] = fullName;
    data['class'] = className;
    data['section'] = section;
    data['image_url'] = imageUrl;
    return data;
  }
}
