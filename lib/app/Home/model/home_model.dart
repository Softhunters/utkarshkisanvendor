import '../../CategoryProduct/model/product_detail_model.dart';

class HomeModel {
  bool? status;
  Result? result;

  HomeModel({this.status, this.result});

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result =
        json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  List<Sliders>? sliders;
  List<Subcategorys>? categorys;
  List<Subcategorys>? subcategorys;
  List<Brands>? brands;
  List<Sliders>? banners;
  List<Sliders>? cbanners;
  List<Products>? products;
  List<Products>? fproducts;
  List<Sum>? sum;
  List<Testimonials>? testimonials;

  Result(
      {this.sliders,
      this.categorys,
      this.subcategorys,
      this.brands,
      this.banners,
      this.cbanners,
      this.products,
      this.fproducts,
      this.sum,
      this.testimonials});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['sliders'] != null) {
      sliders = <Sliders>[];
      json['sliders'].forEach((v) {
        sliders!.add(Sliders.fromJson(v));
      });
    }
    if (json['categorys'] != null) {
      categorys = <Subcategorys>[];
      json['categorys'].forEach((v) {
        categorys!.add(Subcategorys.fromJson(v));
      });
    }
    if (json['subcategorys'] != null) {
      subcategorys = <Subcategorys>[];
      json['subcategorys'].forEach((v) {
        subcategorys!.add(Subcategorys.fromJson(v));
      });
    }
    if (json['brands'] != null) {
      brands = <Brands>[];
      json['brands'].forEach((v) {
        brands!.add(Brands.fromJson(v));
      });
    }
    if (json['banners'] != null) {
      banners = <Sliders>[];
      json['banners'].forEach((v) {
        banners!.add(Sliders.fromJson(v));
      });
    }
    if (json['cbanners'] != null) {
      cbanners = <Sliders>[];
      json['cbanners'].forEach((v) {
        cbanners!.add(Sliders.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    if (json['fproducts'] != null) {
      fproducts = <Products>[];
      json['fproducts'].forEach((v) {
        fproducts!.add(Products.fromJson(v));
      });
    }
    if (json['sum'] != null) {
      sum = <Sum>[];
      json['sum'].forEach((v) {
        sum!.add(Sum.fromJson(v));
      });
    }
    if (json['testimonials'] != null) {
      testimonials = <Testimonials>[];
      json['testimonials'].forEach((v) {
        testimonials!.add(Testimonials.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.sliders != null) {
      data['sliders'] = this.sliders!.map((v) => v.toJson()).toList();
    }
    if (this.categorys != null) {
      data['categorys'] = this.categorys!.map((v) => v.toJson()).toList();
    }
    if (this.subcategorys != null) {
      data['subcategorys'] = this.subcategorys!.map((v) => v.toJson()).toList();
    }
    if (this.brands != null) {
      data['brands'] = this.brands!.map((v) => v.toJson()).toList();
    }
    if (this.banners != null) {
      data['banners'] = this.banners!.map((v) => v.toJson()).toList();
    }
    if (this.cbanners != null) {
      data['cbanners'] = this.cbanners!.map((v) => v.toJson()).toList();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    if (this.fproducts != null) {
      data['fproducts'] = this.fproducts!.map((v) => v.toJson()).toList();
    }
    if (this.sum != null) {
      data['sum'] = this.sum!.map((v) => v.toJson()).toList();
    }
    if (this.testimonials != null) {
      data['testimonials'] = this.testimonials!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sliders {
  int? id;
  String? title;
  String? link;
  String? images;
  String? status;
  String? fors;
  String? createdAt;
  String? updatedAt;

  Sliders(
      {this.id,
      this.title,
      this.link,
      this.images,
      this.status,
      this.fors,
      this.createdAt,
      this.updatedAt});

  Sliders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    link = json['link'];
    images = json['images'];
    status = json['status'].toString();
    fors = json['for'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['link'] = this.link;
    data['images'] = this.images;
    data['status'] = this.status;
    data['for'] = this.fors;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Categorys {
  int? id;
  String? name;
  String? slug;
  String? icon;
  String? categorythum;
  String? status;
  String? isHome;
  String? createdAt;
  String? updatedAt;

  Categorys(
      {this.id,
      this.name,
      this.slug,
      this.icon,
      this.categorythum,
      this.status,
      this.isHome,
      this.createdAt,
      this.updatedAt});

  Categorys.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = Map<String, dynamic>();
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

class Subcategorys {
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
  String? cname;

  Subcategorys(
      {this.id,
      this.name,
      this.slug,
      this.icon,
      this.categorythum,
      this.categoryId,
      this.status,
      this.isHome,
      this.createdAt,
      this.updatedAt,
        this.cname
      });

  Subcategorys.fromJson(Map<String, dynamic> json) {
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
    cname = json['cname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
    data['cname'] = this.cname;
    return data;
  }
}

class Brands {
  int? id;
  String? brandName;
  String? brandSlug;
  String? description;
  String? brandImage;
  String? status;
  String? isHome;
  String? createdAt;
  String? updatedAt;

  Brands(
      {this.id,
      this.brandName,
      this.brandSlug,
      this.description,
      this.brandImage,
      this.status,
      this.isHome,
      this.createdAt,
      this.updatedAt});

  Brands.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brandName = json['brand_name'];
    brandSlug = json['brand_slug'];
    description = json['description'];
    brandImage = json['brand_image'];
    status = json['status'].toString();
    isHome = json['is_home'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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

class Reviews {
  int? id;
  int? productId;
  int? orderId;
  int? orderlistId;
  int? userId;
  int? rating;
  String? message;
  String? images;
  int? status;
  int? verified;
  String? createdAt;
  String? updatedAt;
  User? user;

  Reviews(
      {this.id,
        this.productId,
        this.orderId,
        this.orderlistId,
        this.userId,
        this.rating,
        this.message,
        this.images,
        this.status,
        this.verified,
        this.createdAt,
        this.updatedAt,
        this.user});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    orderId = json['order_id'];
    orderlistId = json['orderlist_id'];
    userId = json['user_id'];
    rating = json['rating'];
    message = json['message'];
    images = json['images'];
    status = json['status'];
    verified = json['verified'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['order_id'] = this.orderId;
    data['orderlist_id'] = this.orderlistId;
    data['user_id'] = this.userId;
    data['rating'] = this.rating;
    data['message'] = this.message;
    data['images'] = this.images;
    data['status'] = this.status;
    data['verified'] = this.verified;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? emailVerifiedAt;
  String? profile;
  String? utype;
  int? status;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  String? deviceToken;

  User(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.emailVerifiedAt,
        this.profile,
        this.utype,
        this.status,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.deviceToken});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    emailVerifiedAt = json['email_verified_at'];
    profile = json['profile'];
    utype = json['utype'];
    status = json['status'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deviceToken = json['device_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['profile'] = this.profile;
    data['utype'] = this.utype;
    data['status'] = this.status;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['device_token'] = this.deviceToken;
    return data;
  }
}

class Sum {
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
  String? reviewsAvgRating;

  Sum(
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
      this.reviewsAvgRating});

  Sum.fromJson(Map<String, dynamic> json) {
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
    featured = json['featured'];
    quantity = json['quantity'];
    image = json['image'];
    images = json['images'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    subsubcategoryId = json['subsubcategory_id'];
    medtypeId = json['medtype_id'];
    parentId = json['parent_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    brandId = json['brand_id'];
    breedId = json['breed_id'];
    isBaby = json['is_baby'];
    isChild = json['is_child'];
    isYoung = json['is_young'];
    status = json['status'];
    addBy = json['add_by'];
    taxId = json['tax_id'];
    freecancellation = json['freecancellation'];
    discountValue = json['discount_value'];
    varaintDetail = json['varaint_detail'];
    flavourId = json['flavour_id'];
    veg = json['veg'];
    reviewsAvgRating = json['reviews_avg_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
    data['reviews_avg_rating'] = this.reviewsAvgRating;
    return data;
  }
}

class Testimonials {
  int? id;
  String? name;
  String? email;
  String? image;
  String? position;
  String? phone;
  String? star;
  String? description;
  String? status;
  String? verified;
  String? createdAt;
  String? updatedAt;

  Testimonials(
      {this.id,
      this.name,
      this.email,
      this.image,
      this.position,
      this.phone,
      this.star,
      this.description,
      this.status,
      this.verified,
      this.createdAt,
      this.updatedAt});

  Testimonials.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    position = json['position'];
    phone = json['phone'];
    star = json['star'].toString();
    description = json['description'];
    status = json['status'].toString();
    verified = json['verified'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['image'] = this.image;
    data['position'] = this.position;
    data['phone'] = this.phone;
    data['star'] = this.star;
    data['description'] = this.description;
    data['status'] = this.status;
    data['verified'] = this.verified;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
