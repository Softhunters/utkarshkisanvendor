import 'package:utkrashvendor/app/Profile/model/country_model.dart';

class AllAddressModel {
  bool? status;
  List<Addresss>? addresss;

  AllAddressModel({this.status, this.addresss});

  AllAddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['addresss'] != null) {
      addresss = <Addresss>[];
      json['addresss'].forEach((v) {
        addresss!.add(new Addresss.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.addresss != null) {
      data['addresss'] = this.addresss!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Addresss {
  int? id;
  String? userId;
  String? name;
  String? mobile;
  String? mobileOptional;
  String? line1;
  String? line2;
  String? landmark;
  String? countryId;
  String? stateId;
  String? cityId;
  String? zipcode;
  String? addressType;
  String? defaultAddress;
  String? createdAt;
  String? updatedAt;
  Countries? country;
  Cities? city;
  States? state;

  Addresss(
      {this.id,
        this.userId,
        this.name,
        this.mobile,
        this.mobileOptional,
        this.line1,
        this.line2,
        this.landmark,
        this.countryId,
        this.stateId,
        this.cityId,
        this.zipcode,
        this.addressType,
        this.defaultAddress,
        this.createdAt,
        this.updatedAt,
        this.country,
        this.city,
        this.state});

  Addresss.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'].toString();
    name = json['name'];
    mobile = json['mobile'];
    mobileOptional = json['mobile_optional'];
    line1 = json['line1'];
    line2 = json['line2'];
    landmark = json['landmark'];
    countryId = json['country_id'].toString();
    stateId = json['state_id'].toString();
    cityId = json['city_id'].toString();
    zipcode = json['zipcode'].toString();
    addressType = json['address_type'];
    defaultAddress = json['default_address'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    country =
    json['country'] != null ? new Countries.fromJson(json['country']) : null;
    city = json['city'] != null ? new Cities.fromJson(json['city']) : null;
    state = json['state'] != null ? new States.fromJson(json['state']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['mobile_optional'] = this.mobileOptional;
    data['line1'] = this.line1;
    data['line2'] = this.line2;
    data['landmark'] = this.landmark;
    data['country_id'] = this.countryId;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['zipcode'] = this.zipcode;
    data['address_type'] = this.addressType;
    data['default_address'] = this.defaultAddress;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    if (this.state != null) {
      data['state'] = this.state!.toJson();
    }
    return data;
  }
}

