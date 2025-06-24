class DormitoryRoomTypeResponseModel {
  bool? success;
  List<DormitoryRoomTypeData>? data;
  String? message;

  DormitoryRoomTypeResponseModel({this.success, this.data, this.message});

  DormitoryRoomTypeResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <DormitoryRoomTypeData>[];
      json['data'].forEach((v) {
        data!.add(DormitoryRoomTypeData.fromJson(v));
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

class DormitoryRoomTypeData {
  int? id;
  String? name; ///type => name

  DormitoryRoomTypeData({this.id, this.name});

  DormitoryRoomTypeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = name;
    return data;
  }
}
