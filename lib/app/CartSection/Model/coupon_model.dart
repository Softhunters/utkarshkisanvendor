class CouponModel {
  bool? status;
  Result? result;

  CouponModel({this.status, this.result});

  CouponModel.fromJson(Map<String, dynamic> json) {
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
  List<Coupons>? coupons;

  Result({this.coupons});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['coupons'] != null) {
      coupons = <Coupons>[];
      json['coupons'].forEach((v) {
        coupons!.add(new Coupons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.coupons != null) {
      data['coupons'] = this.coupons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Coupons {
  int? id;
  String? couponName;
  String? code;
  String? type;
  String? value;
  int? categoryId;
  String? cartValue;
  int? status;
  String? createdAt;
  String? updatedAt;

  Coupons(
      {this.id,
        this.couponName,
        this.code,
        this.type,
        this.value,
        this.categoryId,
        this.cartValue,
        this.status,
        this.createdAt,
        this.updatedAt});

  Coupons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    couponName = json['coupon_name'];
    code = json['code'];
    type = json['type'];
    value = json['value'];
    categoryId = json['category_id'];
    cartValue = json['cart_value'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['coupon_name'] = this.couponName;
    data['code'] = this.code;
    data['type'] = this.type;
    data['value'] = this.value;
    data['category_id'] = this.categoryId;
    data['cart_value'] = this.cartValue;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}



class ApplyCouponModel {
  bool? status;
  String? message;
  AllData? result;

  ApplyCouponModel({this.status, this.message, this.result});

  ApplyCouponModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result =
    json['result'] != null ? new AllData.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class AllData {
  Coupons? coupondata;
  String? discount;
  String? subtotal;
  String? totalamount;

  AllData({this.coupondata, this.discount, this.subtotal, this.totalamount});

  AllData.fromJson(Map<String, dynamic> json) {
    coupondata = json['coupondata'] != null
        ? Coupons.fromJson(json['coupondata'])
        : null;
    discount = json['discount'].toString();
    subtotal = json['subtotal'];
    totalamount = json['totalamount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.coupondata != null) {
      data['coupondata'] = this.coupondata!.toJson();
    }
    data['discount'] = this.discount;
    data['subtotal'] = this.subtotal;
    data['totalamount'] = this.totalamount;
    return data;
  }
}
