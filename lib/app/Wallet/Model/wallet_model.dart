class WalletModel {
  bool? status;
  Result? result;

  WalletModel({this.status, this.result});

  WalletModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  int? twallet;
  int? treward;
  List<WalletHistory>? wallethistory;
  List<RewardHistory>? rewardhistory;

  Result({this.twallet, this.treward, this.wallethistory, this.rewardhistory});

  Result.fromJson(Map<String, dynamic> json) {
    twallet = json['twallet'];
    treward = json['treward'];
    if (json['wallethistory'] != null) {
      wallethistory = <WalletHistory>[];
      json['wallethistory'].forEach((v) {
        wallethistory!.add(new WalletHistory.fromJson(v));
      });
    }
    if (json['rewardhistory'] != null) {
      rewardhistory = <RewardHistory>[];
      json['rewardhistory'].forEach((v) {
        rewardhistory!.add(new RewardHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['twallet'] = this.twallet;
    data['treward'] = this.treward;
    if (this.wallethistory != null) {
      data['wallethistory'] =
          this.wallethistory!.map((v) => v.toJson()).toList();
    }
    if (this.rewardhistory != null) {
      data['rewardhistory'] =
          this.rewardhistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WalletHistory {
  String? orderNumber;
  int? id;
  int? userId;
  int? orderId;
  String? orderitemId;
  String? amount;
  int? status;
  int? by;
  String? createdAt;
  String? updatedAt;

  WalletHistory(
      {this.orderNumber,
        this.id,
        this.userId,
        this.orderId,
        this.orderitemId,
        this.amount,
        this.status,
        this.by,
        this.createdAt,
        this.updatedAt});

  WalletHistory.fromJson(Map<String, dynamic> json) {
    orderNumber = json['order_number'];
    id = json['id'];
    userId = json['user_id'];
    orderId = json['order_id'];
    orderitemId = json['orderitem_id'].toString();
    amount = json['amount'];
    status = json['status'];
    by = json['by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_number'] = this.orderNumber;
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['order_id'] = this.orderId;
    data['orderitem_id'] = this.orderitemId;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['by'] = this.by;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class RewardHistory {
  String? orderNumber;
  int? id;
  int? userId;
  int? orderId;
  String? orderitemId;
  String? point;
  int? status;
  int? by;
  String? createdAt;
  String? updatedAt;

  RewardHistory(
      {this.orderNumber,
        this.id,
        this.userId,
        this.orderId,
        this.orderitemId,
        this.point,
        this.status,
        this.by,
        this.createdAt,
        this.updatedAt});

  RewardHistory.fromJson(Map<String, dynamic> json) {
    orderNumber = json['order_number'];
    id = json['id'];
    userId = json['user_id'];
    orderId = json['order_id'];
    orderitemId = json['orderitem_id'].toString();
    point = json['point'];
    status = json['status'];
    by = json['by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_number'] = this.orderNumber;
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['order_id'] = this.orderId;
    data['orderitem_id'] = this.orderitemId;
    data['point'] = this.point;
    data['status'] = this.status;
    data['by'] = this.by;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}