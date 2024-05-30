import 'order_deatil_model.dart';

class OrderHistoryModel {
  bool? status;
  Result? result;

  OrderHistoryModel({this.status, this.result});

  OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result =
    json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class Result {
  List<Order>? order;

  Result({this.order});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['order'] != null) {
      order = <Order>[];
      json['order'].forEach((v) {
        order!.add(Order.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (order != null) {
      data['order'] = order!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transaction {
  int? id;
  int? userId;
  int? orderId;
  String? mode;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? transactionId;
  String? amount;
  int? type;
  String? currencyCode;

  Transaction(
      {this.id,
        this.userId,
        this.orderId,
        this.mode,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.transactionId,
        this.amount,
        this.type,
        this.currencyCode});

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    orderId = json['order_id'];
    mode = json['mode'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    transactionId = json['transaction_id'];
    amount = json['amount'];
    type = json['type'];
    currencyCode = json['currency_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['order_id'] = orderId;
    data['mode'] = mode;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['transaction_id'] = transactionId;
    data['amount'] = amount;
    data['type'] = type;
    data['currency_code'] = currencyCode;
    return data;
  }
}