class VendorOrdersResponse {
  bool? status;
  List<VendorOrdersResult>? result;

  VendorOrdersResponse({this.status, this.result});

  VendorOrdersResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = <VendorOrdersResult>[];
      json['result'].forEach((v) {
        result!.add(new VendorOrdersResult.fromJson(v));
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

class VendorOrdersResult {
  String? orderId;
  String? createdAt;
  String? orderNumber;
  String? status;
  String? totalPrice;
  String? totalProducts;

  VendorOrdersResult(
      {this.orderId,
        this.createdAt,
        this.orderNumber,
        this.status,
        this.totalPrice,
        this.totalProducts});

  VendorOrdersResult.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'].toString();
    createdAt = json['created_at'];
    orderNumber = json['order_number'];
    status = json['status'];
    totalPrice = json['total_price'].toString();
    totalProducts = json['total_products'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['created_at'] = this.createdAt;
    data['order_number'] = this.orderNumber;
    data['status'] = this.status;
    data['total_price'] = this.totalPrice;
    data['total_products'] = this.totalProducts;
    return data;
  }
}
