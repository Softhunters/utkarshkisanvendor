class VendorProductDetailResponse {
  bool? status;
  VendorProductDetailResult? result;

  VendorProductDetailResponse({this.status, this.result});

  VendorProductDetailResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result =
    json['result'] != null ? new VendorProductDetailResult.fromJson(json['result']) : null;
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

class VendorProductDetailResult {
  int? perPage;
  VendorProducts? products;

  VendorProductDetailResult({this.perPage, this.products});

  VendorProductDetailResult.fromJson(Map<String, dynamic> json) {
    perPage = json['per_page'];
    products = json['products'] != null
        ? new VendorProducts.fromJson(json['products'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['per_page'] = this.perPage;
    if (this.products != null) {
      data['products'] = this.products!.toJson();
    }
    return data;
  }
}

class VendorProducts {
  int? currentPage;
  List<VendorProductData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  VendorProducts(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  VendorProducts.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <VendorProductData>[];
      json['data'].forEach((v) {
        data!.add(new VendorProductData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class VendorProductData {
  int? id;
  String? name;
  String? slug;
  String? shortDescription;
  String? description;
  String? manufacturerDetails;
  String? regularPrice;
  String? salePrice;
  String? sKU;
  String? stockStatus;
  int? featured;
  int? quantity;
  String? image;
  String? images;
  int? categoryId;
  int? subcategoryId;
  int? subsubcategoryId;
  String? parentId;
  String? createdAt;
  String? updatedAt;
  int? brandId;
  String? tags;
  int? status;
  int? addBy;
  int? taxId;
  String? freecancellation;
  String? discountValue;
  String? variantDetail;
  String? sizeLimit;
  String? hsnCode;
  String? metaTag;
  String? metaDescription;
  String? orderQty;
  String? reviewsAvgRating;
  String? wishlistAvgUserId;
  int? reviewsCount;
  String? cartAvgUserId;
  BrandsForVandorProduct? brands;
  SellerForVandorProduct? seller;

  VendorProductData(
      {this.id,
        this.name,
        this.slug,
        this.shortDescription,
        this.description,
        this.manufacturerDetails,
        this.regularPrice,
        this.salePrice,
        this.sKU,
        this.stockStatus,
        this.featured,
        this.quantity,
        this.image,
        this.images,
        this.categoryId,
        this.subcategoryId,
        this.subsubcategoryId,
        this.parentId,
        this.createdAt,
        this.updatedAt,
        this.brandId,
        this.tags,
        this.status,
        this.addBy,
        this.taxId,
        this.freecancellation,
        this.discountValue,
        this.variantDetail,
        this.sizeLimit,
        this.hsnCode,
        this.metaTag,
        this.metaDescription,
        this.orderQty,
        this.reviewsAvgRating,
        this.wishlistAvgUserId,
        this.reviewsCount,
        this.cartAvgUserId,
        this.brands,
        this.seller});

  VendorProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    shortDescription = json['short_description'];
    description = json['description'];
    manufacturerDetails = json['manufacturer_details'];
    regularPrice = json['regular_price'].toString();
    salePrice = json['sale_price'].toString();
    sKU = json['SKU'];
    stockStatus = json['stock_status'];
    featured = json['featured'];
    quantity = json['quantity'];
    image = json['image'];
    images = json['images'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    subsubcategoryId = json['subsubcategory_id'];
    parentId = json['parent_id'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    brandId = json['brand_id'];
    tags = json['tags'];
    status = json['status'];
    addBy = json['add_by'];
    taxId = json['tax_id'];
    freecancellation = json['freecancellation'];
    discountValue = json['discount_value'];
    variantDetail = json['variant_detail'];
    sizeLimit = json['size_limit'];
    hsnCode = json['hsn_code'];
    metaTag = json['meta_tag'];
    metaDescription = json['meta_description'];
    orderQty = json['order_qty'].toString();
    reviewsAvgRating = json['reviews_avg_rating'];
    wishlistAvgUserId = json['wishlist_avg_user_id'];
    reviewsCount = json['reviews_count'];
    cartAvgUserId = json['cart_avg_user_id'];
    brands =
    json['brands'] != null ? new BrandsForVandorProduct.fromJson(json['brands']) : null;
    seller =
    json['seller'] != null ? new SellerForVandorProduct.fromJson(json['seller']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['short_description'] = this.shortDescription;
    data['description'] = this.description;
    data['manufacturer_details'] = this.manufacturerDetails;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;
    data['SKU'] = this.sKU;
    data['stock_status'] = this.stockStatus;
    data['featured'] = this.featured;
    data['quantity'] = this.quantity;
    data['image'] = this.image;
    data['images'] = this.images;
    data['category_id'] = this.categoryId;
    data['subcategory_id'] = this.subcategoryId;
    data['subsubcategory_id'] = this.subsubcategoryId;
    data['parent_id'] = this.parentId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['brand_id'] = this.brandId;
    data['tags'] = this.tags;
    data['status'] = this.status;
    data['add_by'] = this.addBy;
    data['tax_id'] = this.taxId;
    data['freecancellation'] = this.freecancellation;
    data['discount_value'] = this.discountValue;
    data['variant_detail'] = this.variantDetail;
    data['size_limit'] = this.sizeLimit;
    data['hsn_code'] = this.hsnCode;
    data['meta_tag'] = this.metaTag;
    data['meta_description'] = this.metaDescription;
    data['order_qty'] = this.orderQty;
    data['reviews_avg_rating'] = this.reviewsAvgRating;
    data['wishlist_avg_user_id'] = this.wishlistAvgUserId;
    data['reviews_count'] = this.reviewsCount;
    data['cart_avg_user_id'] = this.cartAvgUserId;
    if (this.brands != null) {
      data['brands'] = this.brands!.toJson();
    }
    if (this.seller != null) {
      data['seller'] = this.seller!.toJson();
    }
    return data;
  }
}

class BrandsForVandorProduct {
  int? id;
  String? brandName;
  String? brandSlug;
  String? description;
  String? brandImage;
  int? status;
  int? isHome;
  String? createdAt;
  String? updatedAt;

  BrandsForVandorProduct(
      {this.id,
        this.brandName,
        this.brandSlug,
        this.description,
        this.brandImage,
        this.status,
        this.isHome,
        this.createdAt,
        this.updatedAt});

  BrandsForVandorProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brandName = json['brand_name'];
    brandSlug = json['brand_slug'];
    description = json['description'];
    brandImage = json['brand_image'];
    status = json['status'];
    isHome = json['is_home'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['brand_name'] = this.brandName;
    data['brand_slug'] = this.brandSlug;
    data['description'] = this.description;
    data['brand_image'] = this.brandImage;
    data['status'] = this.status;
    data['is_home'] = this.isHome;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class SellerForVandorProduct {
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
  Null? deletedAt;

  SellerForVandorProduct(
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
        this.deletedAt});

  SellerForVandorProduct.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}
