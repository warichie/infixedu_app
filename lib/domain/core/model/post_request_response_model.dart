class PostRequestResponseModel {
  bool? success;
  dynamic? data;
  String? message;

  PostRequestResponseModel({this.success, this.data, this.message});

  PostRequestResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['data'] = this.data;
    data['message'] = message;
    return data;
  }
}
