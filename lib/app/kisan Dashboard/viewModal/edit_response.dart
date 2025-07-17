class EditVarientResponse {
  bool? status;
  EditVariantResult? result;

  EditVarientResponse({this.status, this.result});

  EditVarientResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result =
    json['result'] != null ? new EditVariantResult.fromJson(json['result']) : null;
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

class EditVariantResult {
  int? id;
  int? productId;
  int? vendorId;
  int? price;
  int? quantity;
  String? additionalInfo;
  int? status;
  String? stockStatus;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  ProductApi? productApi;

  EditVariantResult(
      {this.id,
        this.productId,
        this.vendorId,
        this.price,
        this.quantity,
        this.additionalInfo,
        this.status,
        this.stockStatus,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.productApi});

  EditVariantResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    vendorId = json['vendor_id'];
    price = json['price'];
    quantity = json['quantity'];
    additionalInfo = json['additional_info'];
    status = json['status'];
    stockStatus = json['stock_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    productApi = json['product_api'] != null
        ? new ProductApi.fromJson(json['product_api'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['vendor_id'] = this.vendorId;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['additional_info'] = this.additionalInfo;
    data['status'] = this.status;
    data['stock_status'] = this.stockStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.productApi != null) {
      data['product_api'] = this.productApi!.toJson();
    }
    return data;
  }
}

class ProductApi {
  int? id;
  String? name;
  String? slug;
  String? image;
  String? regularPrice;
  String? salePrice;
  String? variantDetail;

  ProductApi(
      {this.id,
        this.name,
        this.slug,
        this.image,
        this.regularPrice,
        this.salePrice,
        this.variantDetail});

  ProductApi.fromJson(Map<String, dynamic> json) {
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
