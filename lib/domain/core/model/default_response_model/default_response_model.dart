class DefaultResponseModel {
  bool? success;
  dynamic data;
  String? message;

  DefaultResponseModel({this.success, this.data, this.message});

  DefaultResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    data['data'] = data;
    data['message'] = message;
    return data;
  }
}
