class FileListResponseModel {
  bool? success;
  List<FileList>? data;
  String? message;

  FileListResponseModel({this.success, this.data, this.message});

  FileListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <FileList>[];
      json['data'].forEach((v) {
        data!.add(FileList.fromJson(v));
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

class FileList {
  int? messageId;
  String? file;
  String? originalFileName;

  FileList({this.messageId, this.file, this.originalFileName});

  FileList.fromJson(Map<String, dynamic> json) {
    messageId = json['message_id'];
    file = json['file'];
    originalFileName = json['original_file_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message_id'] = messageId;
    data['file'] = file;
    data['original_file_name'] = originalFileName;
    return data;
  }
}
