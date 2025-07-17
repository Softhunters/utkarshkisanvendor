import 'package:utkrashvendor/app/Home/model/home_model.dart';

class ProductDetailModel {
  bool? status;
  ProductData? result;

  ProductDetailModel({this.status, this.result});

  ProductDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result =
    json['result'] != null ? new ProductData.fromJson(json['result']) : null;
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

class ProductData {
  Products? product;
  List<Varaiants>? varaiants;
  List<Reviews>? reviews;
  List<SellerList>? sellerList;
  List<SellerCartList>? sellerCartList;
  String? edit;

  ProductData({this.product, this.varaiants,this.reviews,this.sellerList,this.edit});

  ProductData.fromJson(Map<String, dynamic> json) {
    product =
    json['product'] != null ? new Products.fromJson(json['product']) : null;
    if (json['varaiants'] != null) {
      varaiants = <Varaiants>[];
      json['varaiants'].forEach((v) {
        varaiants!.add(new Varaiants.fromJson(v));
      });
      edit = json['edit'];

    }
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }

    if (json['seller_list'] != null) {
      sellerList = <SellerList>[];
      json['seller_list'].forEach((v) {
        sellerList!.add(new SellerList.fromJson(v));
      });
    }

    if (json['seller_cart_list'] != null) {
      sellerCartList = <SellerCartList>[];
      json['seller_cart_list'].forEach((v) {
        sellerCartList!.add(new SellerCartList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.varaiants != null) {
      data['varaiants'] = this.varaiants!.map((v) => v.toJson()).toList();
    }
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }

    if (this.sellerList != null) {
      data['seller_list'] = this.sellerList!.map((v) => v.toJson()).toList();
    }

    if (this.sellerCartList != null) {
      data['seller_cart_list'] = this.sellerCartList!.map((v) => v.toJson()).toList();
    }
    data['edit']=this.edit;
    return data;
  }
}


class SellerCartList{
  int? sellerId;


  SellerCartList({
    this.sellerId,

  });

  SellerCartList.fromJson(Map<String, dynamic> json) {
    sellerId = json['seller_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['seller_id'] = this.sellerId;

    return data;
  }

}

class Products {
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
  String? featured;
  String? quantity;
  String? image;
  String? images;
  String? categoryId;
  String? subcategoryId;
  String? subsubcategoryId;
  String? medtypeId;
  String? parentId;
  String? createdAt;
  String? updatedAt;
  String? brandId;
  String? breedId;
  String? isBaby;
  String? isChild;
  String? isYoung;
  String? status;
  String? addBy;
  String? taxId;
  String? freecancellation;
  String? discountValue;
  String? varaintDetail;
  String? flavourId;
  String? veg;
  String? wishlistAvgUserId;
  String? cartAvgUserId;
  String? reviewsAvgRating;
  int? reviewsCount;
  List<Questions>? questions;
  Category? category;
  SubCategories? subCategories;
  Brands? brands;
  Seller? seller;

  // List<Reviews>? reviews;

  Products(
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
        this.medtypeId,
        this.parentId,
        this.createdAt,
        this.updatedAt,
        this.brandId,
        this.breedId,
        this.isBaby,
        this.isChild,
        this.isYoung,
        this.status,
        this.addBy,
        this.taxId,
        this.freecancellation,
        this.discountValue,
        this.varaintDetail,
        this.flavourId,
        this.veg,
        this.wishlistAvgUserId,
        this.cartAvgUserId,
        this.reviewsAvgRating,
        this.questions,
        this.category,
        this.subCategories,
        this.brands,
      // this.reviews,
      this.reviewsCount,
      this.seller,
      });

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    shortDescription = json['short_description'];
    description = json['description'];
    manufacturerDetails = json['manufacturer_details'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    sKU = json['SKU'];
    stockStatus = json['stock_status'];
    featured = json['featured'].toString();
    quantity = json['quantity'].toString();
    image = json['image'];
    images = json['images'];
    categoryId = json['category_id'].toString();
    subcategoryId = json['subcategory_id'].toString();
    subsubcategoryId = json['subsubcategory_id'].toString();
    medtypeId = json['medtype_id'].toString();
    parentId = json['parent_id'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    brandId = json['brand_id'].toString();
    breedId = json['breed_id'].toString();
    isBaby = json['is_baby'].toString();
    isChild = json['is_child'].toString();
    isYoung = json['is_young'].toString();
    status = json['status'].toString();
    addBy = json['add_by'].toString();
    taxId = json['tax_id'].toString();
    freecancellation = json['freecancellation'].toString();
    discountValue = json['discount_value'];
    varaintDetail = json['varaint_detail'];
    flavourId = json['flavour_id'].toString();
    veg = json['veg'].toString();
    wishlistAvgUserId = json['wishlist_avg_user_id'].toString();
    cartAvgUserId = json['cart_avg_user_id'];
    reviewsAvgRating = json['reviews_avg_rating'].toString();
    reviewsCount = json['reviews_count'];


    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(new Questions.fromJson(v));
      });
    }
    // if (json['reviews'] != null) {
    //   reviews = <Reviews>[];
    //   json['reviews'].forEach((v) {
    //     reviews!.add(new Reviews.fromJson(v));
    //   });
    // }

    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    subCategories = json['sub_categories'] != null
        ? new SubCategories.fromJson(json['sub_categories'])
        : null;
    brands = json['brands'] != null ? new Brands.fromJson(json['brands']) : null;
    seller = json['seller'] != null ? new Seller.fromJson(json['seller']) : null;
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
    data['medtype_id'] = this.medtypeId;
    data['parent_id'] = this.parentId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['brand_id'] = this.brandId;
    data['breed_id'] = this.breedId;
    data['is_baby'] = this.isBaby;
    data['is_child'] = this.isChild;
    data['is_young'] = this.isYoung;
    data['status'] = this.status;
    data['add_by'] = this.addBy;
    data['tax_id'] = this.taxId;
    data['freecancellation'] = this.freecancellation;
    data['discount_value'] = this.discountValue;
    data['varaint_detail'] = this.varaintDetail;
    data['flavour_id'] = this.flavourId;
    data['veg'] = this.veg;
    data['wishlist_avg_user_id'] = this.wishlistAvgUserId;
    data['cart_avg_user_id'] = this.cartAvgUserId;
    data['reviews_avg_rating'] = this.reviewsAvgRating;
    data['reviews_count'] = this.reviewsCount;

    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    // if (this.reviews != null) {
    //   data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    // }
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.subCategories != null) {
      data['sub_categories'] = this.subCategories!.toJson();
    }
    if (this.brands != null) {
      data['brands'] = this.brands!.toJson();
    }
    if (this.seller != null) {
      data['seller'] = this.seller!.toJson();
    }

    return data;
  }
}

class Seller{
  int? id;
  int? productId;
  int? venderId;
  num? price;
  num? quantiity;
  String? additionInfo;
  int? status;
  String? createdAt;
  String? updatedAt;

  Seller({
    this.id,
    this.productId,
    this.venderId,
    this.price,
    this.quantiity,
    this.additionInfo,
    this.status,
    this.createdAt,
    this.updatedAt
  });

  Seller.fromJson(Map<String, dynamic> json) {
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






class Questions {
  int? id;

  Questions({this.id});

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}
class Category {
  int? id;
  String? name;
  String? slug;
  String? icon;
  String? categorythum;
  String? status;
  String? isHome;
  String? createdAt;
  String? updatedAt;

  Category(
      {this.id,
        this.name,
        this.slug,
        this.icon,
        this.categorythum,
        this.status,
        this.isHome,
        this.createdAt,
        this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    icon = json['icon'];
    categorythum = json['categorythum'];
    status = json['status'].toString();
    isHome = json['is_home'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['icon'] = this.icon;
    data['categorythum'] = this.categorythum;
    data['status'] = this.status;
    data['is_home'] = this.isHome;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class SubCategories {
  int? id;
  String? name;
  String? slug;
  String? icon;
  String? categorythum;
  String? categoryId;
  String? status;
  String? isHome;
  String? createdAt;
  String? updatedAt;

  SubCategories(
      {this.id,
        this.name,
        this.slug,
        this.icon,
        this.categorythum,
        this.categoryId,
        this.status,
        this.isHome,
        this.createdAt,
        this.updatedAt});

  SubCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    icon = json['icon'];
    categorythum = json['categorythum'];
    categoryId = json['category_id'].toString();
    status = json['status'].toString();
    isHome = json['is_home'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['icon'] = this.icon;
    data['categorythum'] = this.categorythum;
    data['category_id'] = this.categoryId;
    data['status'] = this.status;
    data['is_home'] = this.isHome;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}


class Varaiants {
  int? id;
  String? varaintDetail;
  String? regularPrice;
  String? salePrice;
  String? slug;

  Varaiants({this.id, this.varaintDetail, this.regularPrice, this.salePrice,this.slug});

  Varaiants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    varaintDetail = json['variant_detail'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['varaint_detail'] = this.varaintDetail;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;
    data['slug'] = this.slug;
    return data;
  }
}


class SellerList {
  int? id;
  int? productId;
  int? vendorId;
  num? price;
  int? quantity;
  String? additionalInfo;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? sellerName;
  String? stockStatus;

  SellerList({this.id,
    this.productId,
    this.vendorId,
    this.price,
    this.quantity,
    this.additionalInfo,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.sellerName,
  this.stockStatus});

  SellerList.fromJson(Map<String, dynamic> json) {
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
    sellerName = json['seller_name'];
    stockStatus = json['stock_status'];

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
    data['seller_name'] = this.sellerName;
    data['stock_status'] = this.stockStatus;
    return data;
  }
}



