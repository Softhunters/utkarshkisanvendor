class ProductInventoryHistoryResponse {
  bool? status;
  List<ProductInventoryHistoryResult>? result;

  ProductInventoryHistoryResponse({this.status, this.result});

  ProductInventoryHistoryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = <ProductInventoryHistoryResult>[];
      json['result'].forEach((v) {
        result!.add(new ProductInventoryHistoryResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductInventoryHistoryResult {
  int? id;
  String? sellerId;
  String? productId;
  String? orderId;
  String? type;
  String? quantity;
  String? orderNo;
  String? createdAt;
  String? updatedAt;

  ProductInventoryHistoryResult(
      {this.id,
        this.sellerId,
        this.productId,
        this.orderId,
        this.type,
        this.quantity,
        this.orderNo,
        this.createdAt,
        this.updatedAt});

  ProductInventoryHistoryResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sellerId = json['seller_id'].toString();
    productId = json['product_id'].toString();
    orderId = json['order_id'].toString();
    type = json['type'];
    orderNo=json['order_number'];
    quantity = json['quantity'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['seller_id'] = this.sellerId;
    data['product_id'] = this.productId;
    data['order_id'] = this.orderId;
    data['type'] = this.type;
    data['quantity'] = this.quantity;
    data['order_number']=this.orderNo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
