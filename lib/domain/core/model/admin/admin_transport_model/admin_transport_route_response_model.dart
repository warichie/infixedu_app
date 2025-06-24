class AdminTransportRouteResponseModel {
  bool? success;
  List<AdminTransportRouteData>? data;
  String? message;

  AdminTransportRouteResponseModel({this.success, this.data, this.message});

  AdminTransportRouteResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <AdminTransportRouteData>[];
      json['data'].forEach((v) {
        data!.add(AdminTransportRouteData.fromJson(v));
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

class AdminTransportRouteData {
  int? id;
  String? title;
  int? fare;

  AdminTransportRouteData({this.id, this.title, this.fare});

  AdminTransportRouteData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    fare = json['far'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['far'] = fare;
    return data;
  }
}
