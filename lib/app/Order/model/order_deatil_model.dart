import '../../CategoryProduct/model/product_detail_model.dart';
import 'order_history_model.dart';

class OrderDetailModel {
  bool? status;
  Result? result;

  OrderDetailModel({this.status, this.result});

  OrderDetailModel.fromJson(Map<String, dynamic> json) {
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
  Order? order;
  List<Orderitem>? orderitem;

  Result({this.order, this.orderitem});

  Result.fromJson(Map<String, dynamic> json) {
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
    if (json['orderitem'] != null) {
      orderitem = <Orderitem>[];
      json['orderitem'].forEach((v) {
        orderitem!.add(new Orderitem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.order != null) {
      data['order'] = this.order!.toJson();
    }
    if (this.orderitem != null) {
      data['orderitem'] = this.orderitem!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Order {
  int? id;
  int? userId;
  String? subtotal;
  String? discount;
  String? tax;
  String? shippingCharge;
  String? total;
  String? name;
  String? mobile;
  String? mobileOptional;
  String? line1;
  String? line2;
  String? landmark;
  int? countryId;
  int? stateId;
  int? cityId;
  String? zipcode;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? orderNumber;
  String? deliveredDate;
  String? canceledDate;
  String? rewardpoint;
  Transaction? transaction;

  Order(
      {this.id,
        this.userId,
        this.subtotal,
        this.discount,
        this.tax,
        this.shippingCharge,
        this.total,
        this.name,
        this.mobile,
        this.mobileOptional,
        this.line1,
        this.line2,
        this.landmark,
        this.countryId,
        this.stateId,
        this.cityId,
        this.zipcode,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.orderNumber,
        this.deliveredDate,
        this.canceledDate,
        this.rewardpoint,
        this.transaction});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    subtotal = json['subtotal'];
    discount = json['discount'];
    tax = json['tax'];
    shippingCharge = json['shipping_charge'];
    total = json['total'];
    name = json['name'];
    mobile = json['mobile'];
    mobileOptional = json['mobile_optional'];
    line1 = json['line1'];
    line2 = json['line2'];
    landmark = json['landmark'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    zipcode = json['zipcode'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    orderNumber = json['order_number'];
    deliveredDate = json['delivered_date'];
    canceledDate = json['canceled_date'];
    rewardpoint = json['rewardpoint'];
    transaction = json['transaction'] != null
        ? new Transaction.fromJson(json['transaction'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['subtotal'] = this.subtotal;
    data['discount'] = this.discount;
    data['tax'] = this.tax;
    data['shipping_charge'] = this.shippingCharge;
    data['total'] = this.total;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['mobile_optional'] = this.mobileOptional;
    data['line1'] = this.line1;
    data['line2'] = this.line2;
    data['landmark'] = this.landmark;
    data['country_id'] = this.countryId;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['zipcode'] = this.zipcode;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['order_number'] = this.orderNumber;
    data['delivered_date'] = this.deliveredDate;
    data['canceled_date'] = this.canceledDate;
    data['rewardpoint'] = this.rewardpoint;
    if (this.transaction != null) {
      data['transaction'] = this.transaction!.toJson();
    }
    return data;
  }
}


class Orderitem {
  int? id;
  int? productId;
  int? orderId;
  String? price;
  int? quantity;
  int? rstatus;
  String? options;
  String? createdAt;
  String? updatedAt;
  String? canceledDate;

  Products? product;

  Orderitem(
      {this.id,
        this.productId,
        this.orderId,
        this.price,
        this.quantity,
        this.rstatus,
        this.options,
        this.createdAt,
        this.updatedAt,
        this.canceledDate,
        this.product});

  Orderitem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    orderId = json['order_id'];
    price = json['price'];
    quantity = json['quantity'];
    rstatus = json['rstatus'];
    options = json['options'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    canceledDate = json['canceled_date'];
    product =
    json['product'] != null ? new Products.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['order_id'] = this.orderId;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['rstatus'] = this.rstatus;
    data['options'] = this.options;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['canceled_date'] = this.canceledDate;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

