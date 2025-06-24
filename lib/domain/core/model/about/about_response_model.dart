class AboutResponseModel {
  bool? status;
  AboutData? data;
  String? message;

  AboutResponseModel({this.status, this.data, this.message});

  AboutResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['success'];
    data = json['data'] != null ? AboutData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class AboutData {
  String? aboutDetails;
  String? address;
  String? phoneNo;
  String? email;

  AboutData({this.aboutDetails, this.address, this.phoneNo, this.email});

  AboutData.fromJson(Map<String, dynamic> json) {
    aboutDetails = json['about_details'];
    address = json['address'];
    phoneNo = json['phone_no'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['about_details'] = aboutDetails;
    data['address'] = address;
    data['phone_no'] = phoneNo;
    data['email'] = email;
    return data;
  }
}
