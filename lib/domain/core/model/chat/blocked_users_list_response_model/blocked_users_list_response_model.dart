class BlockedUsersListResponseModel {
  bool? success;
  List<BlockedUsersData>? data;
  String? message;

  BlockedUsersListResponseModel({this.success, this.data, this.message});

  BlockedUsersListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <BlockedUsersData>[];
      json['data'].forEach((v) {
        data!.add(BlockedUsersData.fromJson(v));
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

class BlockedUsersData {
  int? userId;
  String? fullName;
  String? image;
  int? activeStatus;

  BlockedUsersData({this.userId, this.fullName, this.image, this.activeStatus});

  BlockedUsersData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    fullName = json['full_name'];
    image = json['image'];
    activeStatus = json['active_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['full_name'] = fullName;
    data['image'] = image;
    data['active_status'] = activeStatus;
    return data;
  }
}
