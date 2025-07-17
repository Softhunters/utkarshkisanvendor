class OrderListVarientResponse {
  bool? status;
  List<OrderListResult>? result;

  OrderListVarientResponse({this.status, this.result});

  OrderListVarientResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = <OrderListResult>[];
      json['result'].forEach((v) {
        result!.add(new OrderListResult.fromJson(v));
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

class OrderListResult {
  int? id;
  int? productId;
  int? orderId;
  int? sellerId;
  String? mrpPrice;
  String? price;
  int? quantity;
  String? gst;
  int? rstatus;
  String? options;
  Null? deliveredDate;
  String? canceledDate;
  String? createdAt;
  String? updatedAt;
  String? status;
  OrderApi? orderApi;
  ProductApiForOrder? productApi;

  OrderListResult(
      {this.id,
      this.productId,
      this.orderId,
      this.sellerId,
      this.mrpPrice,
      this.price,
      this.quantity,
      this.gst,
      this.rstatus,
      this.options,
      this.deliveredDate,
      this.canceledDate,
      this.createdAt,
      this.updatedAt,
      this.status,
      this.orderApi,
      this.productApi});

  OrderListResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    orderId = json['order_id'];
    sellerId = json['seller_id'];
    mrpPrice = json['mrp_price'];
    price = json['price'];
    quantity = json['quantity'];
    gst = json['gst'];
    rstatus = json['rstatus'];
    options = json['options'];
    deliveredDate = json['delivered_date'];
    canceledDate = json['canceled_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    orderApi = json['order_api'] != null
        ? new OrderApi.fromJson(json['order_api'])
        : null;
    productApi = json['product_api'] != null
        ? new ProductApiForOrder.fromJson(json['product_api'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['order_id'] = this.orderId;
    data['seller_id'] = this.sellerId;
    data['mrp_price'] = this.mrpPrice;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['gst'] = this.gst;
    data['rstatus'] = this.rstatus;
    data['options'] = this.options;
    data['delivered_date'] = this.deliveredDate;
    data['canceled_date'] = this.canceledDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    if (this.orderApi != null) {
      data['order_api'] = this.orderApi!.toJson();
    }
    if (this.productApi != null) {
      data['product_api'] = this.productApi!.toJson();
    }
    return data;
  }
}

class OrderApi {
  int? id;
  String? name;
  String? mobile;
  String? line1;
  String? line2;
  String? landmark;
  int? countryId;
  int? stateId;
  int? cityId;
  String? zipcode;
  String? status;
  String? orderNumber;
  Null? deliveredDate;
  String? canceledDate;
  String? createdAt;

  OrderApi(
      {this.id,
      this.name,
      this.mobile,
      this.line1,
      this.line2,
      this.landmark,
      this.countryId,
      this.stateId,
      this.cityId,
      this.zipcode,
      this.status,
      this.orderNumber,
      this.deliveredDate,
      this.canceledDate,
      this.createdAt});

  OrderApi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    line1 = json['line1'];
    line2 = json['line2'];
    landmark = json['landmark'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    zipcode = json['zipcode'];
    status = json['status'];
    orderNumber = json['order_number'];
    deliveredDate = json['delivered_date'];
    canceledDate = json['canceled_date'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['line1'] = this.line1;
    data['line2'] = this.line2;
    data['landmark'] = this.landmark;
    data['country_id'] = this.countryId;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['zipcode'] = this.zipcode;
    data['status'] = this.status;
    data['order_number'] = this.orderNumber;
    data['delivered_date'] = this.deliveredDate;
    data['canceled_date'] = this.canceledDate;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class ProductApiForOrder {
  int? id;
  String? name;
  String? slug;
  String? image;
  String? regularPrice;
  String? salePrice;
  String? variantDetail;

  ProductApiForOrder(
      {this.id,
      this.name,
      this.slug,
      this.image,
      this.regularPrice,
      this.salePrice,
      this.variantDetail});

  ProductApiForOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    variantDetail = json['variant_detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['image'] = this.image;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;
    data['variant_detail'] = this.variantDetail;
    return data;
  }
}
