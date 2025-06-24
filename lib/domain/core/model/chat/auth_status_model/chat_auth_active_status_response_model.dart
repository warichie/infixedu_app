class ChatAuthActiveStatusResponseModel {
  bool? success;
  List<Data>? data;
  String? message;

  ChatAuthActiveStatusResponseModel({this.success, this.data, this.message});

  ChatAuthActiveStatusResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  String? status;
  String? color;
  List<StatusInfo>? statusInfo;

  Data({this.status, this.color, this.statusInfo});

  Data.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    color = json['color'];
    if (json['status_info'] != null) {
      statusInfo = <StatusInfo>[];
      json['status_info'].forEach((v) {
        statusInfo!.add(StatusInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['color'] = color;
    if (statusInfo != null) {
      data['status_info'] = statusInfo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StatusInfo {
  int? key;
  String? name;
  int? statusColor;

  StatusInfo({this.key, this.name, this.statusColor});

  StatusInfo.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    name = json['name'];
    statusColor = int.tryParse(json['color']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['name'] = name;
    data['color'] = statusColor;
    return data;
  }
}
