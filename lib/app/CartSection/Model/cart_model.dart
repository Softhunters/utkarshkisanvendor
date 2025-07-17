import 'check_out_model.dart';

class CartModel {
  bool? status;
  Result? result;

  CartModel({this.status, this.result});

  CartModel.fromJson(Map<String, dynamic> json) {
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
  List<CartData>? cart;

  Result({this.cart});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['cart'] != null) {
      cart = <CartData>[];
      json['cart'].forEach((v) {
        cart!.add(new CartData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cart != null) {
      data['cart'] = this.cart!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartData {
  int? id;
  String? productId;
  String? userId;
  String? productName;
  String? productImage;
  String? price;
  String? quantity;
  String? createdAt;
  String? updatedAt;
  String? slug;
  String? regularPrice;
  String? discountValue;
  String? reviewsAvgRating;
  SellerForCart? seller;
  String? sellerId;

  String? sellerName;

  CartData(
      {this.id,
      this.productId,
      this.userId,
      this.productName,
      this.productImage,
      this.price,
      this.quantity,
      this.createdAt,
      this.updatedAt,
      this.slug,
      this.regularPrice,
      this.discountValue,
      this.reviewsAvgRating,
      this.sellerId,
      this.sellerName,
      this.seller});

  CartData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'].toString();
    userId = json['user_id'].toString();
    productName = json['product_name'];
    productImage = json['product_image'];
    price = json['price'].toString();
    quantity = json['quantity'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    slug = json['slug'];
    regularPrice = json['regular_price'];
    discountValue = json['discount_value'];
    reviewsAvgRating = json['reviews_avg_rating'].toString();
    sellerId = json['seller_id'].toString();
    sellerName = json['seller_name'].toString();
    seller = json['seller'] != null
        ? new SellerForCart.fromJson(json['seller'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['user_id'] = this.userId;
    data['product_name'] = this.productName;
    data['product_image'] = this.productImage;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['slug'] = this.slug;
    data['regular_price'] = this.regularPrice;
    data['discount_value'] = this.discountValue;
    data['reviews_avg_rating'] = this.reviewsAvgRating;
    data['seller_id'] = this.sellerId;
    data['seller_name'] = this.sellerName;
    if (this.seller != null) {
      data['seller'] = this.seller!.toJson();
    }
    return data;
  }
}

class SellerForCart {
  int? id;
  int? productId;
  int? venderId;
  num? price;
  num? quantiity;
  String? additionInfo;
  int? status;
  String? createdAt;
  String? updatedAt;

  SellerForCart(
      {this.id,
      this.productId,
      this.venderId,
      this.price,
      this.quantiity,
      this.additionInfo,
      this.status,
      this.createdAt,
      this.updatedAt});

  SellerForCart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    venderId = json['vendor_id'];
    price = json['price'];
    quantiity = json['quantity'];
    additionInfo = json['additional_info'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.id;
    data['vendor_id'] = this.id;
    data['price'] = this.id;
    data['quantity'] = this.id;
    data['additional_info'] = this.id;
    data['status'] = this.id;
    data['created_at'] = this.id;
    data['updated_at'] = this.id;
    return data;
  }
}
