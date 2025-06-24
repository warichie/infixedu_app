class DormitoryRoomListResponseModel {
  bool? success;
  List<DormitoryRoomListData>? data;
  String? message;

  DormitoryRoomListResponseModel({this.success, this.data, this.message});

  DormitoryRoomListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <DormitoryRoomListData>[];
      json['data'].forEach((v) {
        data!.add(DormitoryRoomListData.fromJson(v));
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

class DormitoryRoomListData {
  int? id;
  String? name;
  int? numberOfBed;
  int? costPerBed;
  String? dormitory;
  String? roomType;

  DormitoryRoomListData(
      {this.id,
        this.name,
        this.numberOfBed,
        this.costPerBed,
        this.dormitory,
        this.roomType});

  DormitoryRoomListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    numberOfBed = json['number_of_bed'];
    costPerBed = json['cost_per_bed'];
    dormitory = json['dormitory'];
    roomType = json['room_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['number_of_bed'] = numberOfBed;
    data['cost_per_bed'] = costPerBed;
    data['dormitory'] = dormitory;
    data['room_type'] = roomType;
    return data;
  }
}
