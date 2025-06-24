class MyWalletModel {
  bool? success;
  List<Data>? data;
  String? message;

  MyWalletModel({this.success, this.data, this.message});

  MyWalletModel.fromJson(Map<String, dynamic> json) {
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
  int? myBalance;
  String? currencySymbol;
  List<WalletTransactions>? walletTransactions;

  Data({this.myBalance, this.currencySymbol, this.walletTransactions});

  Data.fromJson(Map<String, dynamic> json) {
    myBalance = json['myBalance'];
    currencySymbol = json['currencySymbol'];
    if (json['walletTransactions'] != null) {
      walletTransactions = <WalletTransactions>[];
      json['walletTransactions'].forEach((v) {
        walletTransactions!.add(WalletTransactions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['myBalance'] = myBalance;
    data['currencySymbol'] = currencySymbol;
    if (walletTransactions != null) {
      data['walletTransactions'] =
          walletTransactions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WalletTransactions {
  int? id;
  String? createdAt;
  String? paymentMethod;
  num? amount;
  String? status;

  WalletTransactions(
      {this.id, this.createdAt, this.paymentMethod, this.amount, this.status});

  WalletTransactions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    paymentMethod = json['payment_method'];
    amount = json['amount'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['payment_method'] = paymentMethod;
    data['amount'] = amount;
    data['status'] = status;
    return data;
  }
}
