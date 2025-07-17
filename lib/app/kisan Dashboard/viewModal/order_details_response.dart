class OrderDetailsVarientResponse {
  bool? status;
  OrderDetailsResult? result;

  OrderDetailsVarientResponse({this.status, this.result});

  OrderDetailsVarientResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result =
    json['result'] != null ? new OrderDetailsResult.fromJson(json['result']) : null;
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

class OrderDetailsResult {
  int? id;
  int? productId;
  int? orderId;
  int? sellerId;
  String? mrpPrice;
  String? price;
  int? quantity;
  String? gst;
  int? rstatus;
  String? options;
  Null? deliveredDate;
  Null? canceledDate;
  String? createdAt;
  String? updatedAt;
  OrderApi? orderApi;
  ProductApiForOrderDetail? productApi;

  OrderDetailsResult(
      {this.id,
        this.productId,
        this.orderId,
        this.sellerId,
        this.mrpPrice,
        this.price,
        this.quantity,
        this.gst,
        this.rstatus,
        this.options,
        this.deliveredDate,
        this.canceledDate,
        this.createdAt,
        this.updatedAt,
        this.orderApi,
        this.productApi});

  OrderDetailsResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    orderId = json['order_id'];
    sellerId = json['seller_id'];
    mrpPrice = json['mrp_price'];
    price = json['price'];
    quantity = json['quantity'];
    gst = json['gst'];
    rstatus = json['rstatus'];
    options = json['options'];
    deliveredDate = json['delivered_date'];
    canceledDate = json['canceled_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    orderApi = json['order_api'] != null
        ? new OrderApi.fromJson(json['order_api'])
        : null;
    productApi = json['product_api'] != null
        ? new ProductApiForOrderDetail.fromJson(json['product_api'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['order_id'] = this.orderId;
    data['seller_id'] = this.sellerId;
    data['mrp_price'] = this.mrpPrice;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['gst'] = this.gst;
    data['rstatus'] = this.rstatus;
    data['options'] = this.options;
    data['delivered_date'] = this.deliveredDate;
    data['canceled_date'] = this.canceledDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.orderApi != null) {
      data['order_api'] = this.orderApi!.toJson();
    }
    if (this.productApi != null) {
      data['product_api'] = this.productApi!.toJson();
    }
    return data;
  }
}

class OrderApi {
  int? id;
  String? name;
  String? mobile;
  String? line1;
  String? line2;
  String? landmark;
  int? countryId;
  int? stateId;
  int? cityId;
  String? zipcode;
  String? status;
  String? orderNumber;
  Null? deliveredDate;
  Null? canceledDate;
  String? createdAt;
  Country? country;
  State? state;
  City? city;

  OrderApi(
      {this.id,
        this.name,
        this.mobile,
        this.line1,
        this.line2,
        this.landmark,
        this.countryId,
        this.stateId,
        this.cityId,
        this.zipcode,
        this.status,
        this.orderNumber,
        this.deliveredDate,
        this.canceledDate,
        this.createdAt,
        this.country,
        this.state,
        this.city});

  OrderApi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    line1 = json['line1'];
    line2 = json['line2'];
    landmark = json['landmark'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    zipcode = json['zipcode'];
    status = json['status'];
    orderNumber = json['order_number'];
    deliveredDate = json['delivered_date'];
    canceledDate = json['canceled_date'];
    createdAt = json['created_at'];
    country =
    json['country'] != null ? new Country.fromJson(json['country']) : null;
    state = json['state'] != null ? new State.fromJson(json['state']) : null;
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['line1'] = this.line1;
    data['line2'] = this.line2;
    data['landmark'] = this.landmark;
    data['country_id'] = this.countryId;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['zipcode'] = this.zipcode;
    data['status'] = this.status;
    data['order_number'] = this.orderNumber;
    data['delivered_date'] = this.deliveredDate;
    data['canceled_date'] = this.canceledDate;
    data['created_at'] = this.createdAt;
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    if (this.state != null) {
      data['state'] = this.state!.toJson();
    }
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    return data;
  }
}

class Country {
  int? id;
  String? name;
  String? iso3;
  String? numericCode;
  String? iso2;
  String? phonecode;
  String? capital;
  String? currency;
  String? currencyName;
  String? currencySymbol;
  String? tld;
  String? native;
  String? region;
  int? regionId;
  String? subregion;
  int? subregionId;
  String? nationality;
  String? timezones;
  String? translations;
  String? latitude;
  String? longitude;
  String? emoji;
  String? emojiU;
  String? createdAt;
  String? updatedAt;
  int? flag;
  String? wikiDataId;

  Country(
      {this.id,
        this.name,
        this.iso3,
        this.numericCode,
        this.iso2,
        this.phonecode,
        this.capital,
        this.currency,
        this.currencyName,
        this.currencySymbol,
        this.tld,
        this.native,
        this.region,
        this.regionId,
        this.subregion,
        this.subregionId,
        this.nationality,
        this.timezones,
        this.translations,
        this.latitude,
        this.longitude,
        this.emoji,
        this.emojiU,
        this.createdAt,
        this.updatedAt,
        this.flag,
        this.wikiDataId});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    iso3 = json['iso3'];
    numericCode = json['numeric_code'];
    iso2 = json['iso2'];
    phonecode = json['phonecode'];
    capital = json['capital'];
    currency = json['currency'];
    currencyName = json['currency_name'];
    currencySymbol = json['currency_symbol'];
    tld = json['tld'];
    native = json['native'];
    region = json['region'];
    regionId = json['region_id'];
    subregion = json['subregion'];
    subregionId = json['subregion_id'];
    nationality = json['nationality'];
    timezones = json['timezones'];
    translations = json['translations'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    emoji = json['emoji'];
    emojiU = json['emojiU'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    flag = json['flag'];
    wikiDataId = json['wikiDataId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['iso3'] = this.iso3;
    data['numeric_code'] = this.numericCode;
    data['iso2'] = this.iso2;
    data['phonecode'] = this.phonecode;
    data['capital'] = this.capital;
    data['currency'] = this.currency;
    data['currency_name'] = this.currencyName;
    data['currency_symbol'] = this.currencySymbol;
    data['tld'] = this.tld;
    data['native'] = this.native;
    data['region'] = this.region;
    data['region_id'] = this.regionId;
    data['subregion'] = this.subregion;
    data['subregion_id'] = this.subregionId;
    data['nationality'] = this.nationality;
    data['timezones'] = this.timezones;
    data['translations'] = this.translations;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['emoji'] = this.emoji;
    data['emojiU'] = this.emojiU;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['flag'] = this.flag;
    data['wikiDataId'] = this.wikiDataId;
    return data;
  }
}

class State {
  int? id;
  String? name;
  int? countryId;
  String? countryCode;
  String? fipsCode;
  String? iso2;
  String? type;
  String? latitude;
  String? longitude;
  String? createdAt;
  String? updatedAt;
  int? flag;
  String? wikiDataId;

  State(
      {this.id,
        this.name,
        this.countryId,
        this.countryCode,
        this.fipsCode,
        this.iso2,
        this.type,
        this.latitude,
        this.longitude,
        this.createdAt,
        this.updatedAt,
        this.flag,
        this.wikiDataId});

  State.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryId = json['country_id'];
    countryCode = json['country_code'];
    fipsCode = json['fips_code'];
    iso2 = json['iso2'];
    type = json['type'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    flag = json['flag'];
    wikiDataId = json['wikiDataId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['country_id'] = this.countryId;
    data['country_code'] = this.countryCode;
    data['fips_code'] = this.fipsCode;
    data['iso2'] = this.iso2;
    data['type'] = this.type;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['flag'] = this.flag;
    data['wikiDataId'] = this.wikiDataId;
    return data;
  }
}

class City {
  int? id;
  String? name;
  int? stateId;
  String? stateCode;
  int? countryId;
  String? countryCode;
  String? latitude;
  String? longitude;
  String? createdAt;
  String? updatedAt;
  int? flag;
  String? wikiDataId;

  City(
      {this.id,
        this.name,
        this.stateId,
        this.stateCode,
        this.countryId,
        this.countryCode,
        this.latitude,
        this.longitude,
        this.createdAt,
        this.updatedAt,
        this.flag,
        this.wikiDataId});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    stateId = json['state_id'];
    stateCode = json['state_code'];
    countryId = json['country_id'];
    countryCode = json['country_code'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    flag = json['flag'];
    wikiDataId = json['wikiDataId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['state_id'] = this.stateId;
    data['state_code'] = this.stateCode;
    data['country_id'] = this.countryId;
    data['country_code'] = this.countryCode;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['flag'] = this.flag;
    data['wikiDataId'] = this.wikiDataId;
    return data;
  }
}

class ProductApiForOrderDetail {
  int? id;
  String? name;
  String? slug;
  String? image;
  String? regularPrice;
  String? salePrice;
  String? variantDetail;

  ProductApiForOrderDetail(
      {this.id,
        this.name,
        this.slug,
        this.image,
        this.regularPrice,
        this.salePrice,
        this.variantDetail});

  ProductApiForOrderDetail.fromJson(Map<String, dynamic> json) {
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
