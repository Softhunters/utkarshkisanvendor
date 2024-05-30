class WishlistModel {
  bool? status;
  Result? result;

  WishlistModel({this.status, this.result});

  WishlistModel.fromJson(Map<String, dynamic> json) {
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
  List<Wishlist>? wishlist;

  Result({this.wishlist});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['wishlist'] != null) {
      wishlist = <Wishlist>[];
      json['wishlist'].forEach((v) {
        wishlist!.add(new Wishlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.wishlist != null) {
      data['wishlist'] = this.wishlist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Wishlist {
  int? id;
  String? productId;
  String? userId;
  String? userType;
  String? price;
  String? quantity;
  String? createdAt;
  String? updatedAt;
  String? productName;
  String? productImage;
  String? slug;
  String? regularPrice;
  String? discountValue;
  String? reviewsAvgRating;

  Wishlist(
      {this.id,
        this.productId,
        this.userId,
        this.userType,
        this.price,
        this.quantity,
        this.createdAt,
        this.updatedAt,
        this.productName,
        this.productImage,
        this.slug,
        this.regularPrice,
        this.discountValue,
        this.reviewsAvgRating});

  Wishlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'].toString();
    userId = json['user_id'].toString();
    userType = json['user_type'];
    price = json['price'].toString();
    quantity = json['quantity'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    productName = json['product_name'];
    productImage = json['product_image'];
    slug = json['slug'];
    regularPrice = json['regular_price'].toString();
    discountValue = json['discount_value'].toString();
    reviewsAvgRating = json['reviews_avg_rating'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['user_id'] = this.userId;
    data['user_type'] = this.userType;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['product_name'] = this.productName;
    data['product_image'] = this.productImage;
    data['slug'] = this.slug;
    data['regular_price'] = this.regularPrice;
    data['discount_value'] = this.discountValue;
    data['reviews_avg_rating'] = this.reviewsAvgRating;
    return data;
  }
}