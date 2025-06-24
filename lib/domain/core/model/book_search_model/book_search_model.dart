class BookSearchModel {
  bool? success;
  List<BookSearchListData>? data;
  String? message;

  BookSearchModel({this.success, this.data, this.message});

  BookSearchModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <BookSearchListData>[];
      json['data'].forEach((v) {
        data!.add(BookSearchListData.fromJson(v));
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

class BookSearchListData {
  int? id;
  String? bookTitle;
  String? bookNumber;
  String? isbnNo;
  String? category;
  String? subject;
  String? publisherName;
  String? authorName;
  int? quantity;
  int? price;
  String? rackNumber;

  BookSearchListData(
      {this.id,
        this.bookTitle,
        this.bookNumber,
        this.isbnNo,
        this.category,
        this.subject,
        this.publisherName,
        this.authorName,
        this.quantity,
        this.price,
        this.rackNumber});

  BookSearchListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookTitle = json['book_title'];
    bookNumber = json['book_number'];
    isbnNo = json['isbn_no'];
    category = json['category'];
    subject = json['subject'];
    publisherName = json['publisher_name'];
    authorName = json['author_name'];
    quantity = json['quantity'];
    price = json['price'];
    rackNumber = json['rack_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['book_title'] = bookTitle;
    data['book_number'] = bookNumber;
    data['isbn_no'] = isbnNo;
    data['category'] = category;
    data['subject'] = subject;
    data['publisher_name'] = publisherName;
    data['author_name'] = authorName;
    data['quantity'] = quantity;
    data['price'] = price;
    data['rack_number'] = rackNumber;
    return data;
  }
}
