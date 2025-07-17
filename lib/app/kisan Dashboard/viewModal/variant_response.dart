class VariantResponse {
  bool? status;
  VariantResult? result;

  VariantResponse({this.status, this.result});

  VariantResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result =
    json['result'] != null ? new VariantResult.fromJson(json['result']) : null;
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

class VariantResult {
  List<VariantList>? variantList;

  VariantResult({this.variantList});

  VariantResult.fromJson(Map<String, dynamic> json) {
    if (json['variant_list'] != null) {
      variantList = <VariantList>[];
      json['variant_list'].forEach((v) {
        variantList!.add(new VariantList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.variantList != null) {
      data['variant_list'] = this.variantList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VariantList {
  int? id;
  int? productId;
  int? vendorId;
  int? price;
  int? quantity;
  String? additionalInfo;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? stockStatus;

  ProductApi? productApi;

  VariantList(
      {this.id,
        this.productId,
        this.vendorId,
        this.price,
        this.quantity,
        this.additionalInfo,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.productApi,
      this.stockStatus});

  VariantList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    vendorId = json['vendor_id'];
    price = json['price'];
    quantity = json['quantity'];
    additionalInfo = json['additional_info'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    stockStatus = json['stock_status'];
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
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['stock_status'] = this.stockStatus;
    if (this.productApi != null) {
      data['product_api'] = this.productApi!.toJson();
    }
    return data;
  }
}

class ProductApi {
  int? id;
  String? slug;
  String? image;
  String? regularPrice;
  String? name;
  String? salePrice;
  String? variantDetails;

  ProductApi({this.id, this.slug, this.image, this.regularPrice,this.name,this.salePrice,this.variantDetails});

  ProductApi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    image = json['image'];
    regularPrice = json['regular_price'];
    name =json['name'];
    salePrice =json['sale_price'];
    variantDetails =json['variant_detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['image'] = this.image;
    data['regular_price'] = this.regularPrice;
    data['name']=this.name;
    data['sale_price']=this.salePrice;
    data['variant_detail']=this.variantDetails;
    return data;
  }
}
