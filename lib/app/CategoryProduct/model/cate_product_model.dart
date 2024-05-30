import 'package:e_commerce/app/CategoryProduct/model/product_detail_model.dart';
import 'package:e_commerce/app/CategoryProduct/model/product_detail_model.dart';

import '../../Brand/model/brand_model.dart';
import '../../Home/model/home_model.dart';

class CategoryProductModel {
  bool? status;
  Result? result;

  CategoryProductModel({this.status, this.result});

  CategoryProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class Result {
  Category? category;
  List<Subcategorys>? subcategorys;
  List<String>? cbanners;
  Data? products;

  Result({this.category, this.subcategorys, this.cbanners, this.products});

  Result.fromJson(Map<String, dynamic> json) {
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    if (json['subcategorys'] != null) {
      subcategorys = <Subcategorys>[];
      json['subcategorys'].forEach((v) {
        subcategorys!.add( Subcategorys.fromJson(v));
      });
    }
    if(json['cbanners'] !=null){
      cbanners = <String>[];
      json['cbanners'].forEach((v) {
        cbanners = json['cbanners'].cast<String>();
      });
    }
    // cbanners = json['cbanners'].cast<String>();
    products = json['products'] != null
        ?  Data.fromJson(json['products'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (subcategorys != null) {
      data['subcategorys'] = subcategorys!.map((v) => v.toJson()).toList();
    }
    data['cbanners'] = cbanners;
    if (products != null) {
      data['products'] = products!.toJson();
    }
    return data;
  }
}

class Data {
  int? currentPage;
  List<Products>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  String? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Products>[];
      json['data'].forEach((v) {
        data!.add(new Products.fromJson(v));
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
    perPage = json['per_page'].toString();
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
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
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['icon'] = icon;
    data['categorythum'] = categorythum;
    data['status'] = status;
    data['is_home'] = isHome;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
