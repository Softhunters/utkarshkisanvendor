class SubscriptionPakageResponse {
  bool? status;
  SubscriptionPakageResult? result;

  SubscriptionPakageResponse({this.status, this.result});

  SubscriptionPakageResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result =
    json['result'] != null ? new SubscriptionPakageResult.fromJson(json['result']) : null;
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

class SubscriptionPakageResult {
  List<PackageList>? packageList;

  SubscriptionPakageResult({this.packageList});

  SubscriptionPakageResult.fromJson(Map<String, dynamic> json) {
    if (json['package_list'] != null) {
      packageList = <PackageList>[];
      json['package_list'].forEach((v) {
        packageList!.add(new PackageList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.packageList != null) {
      data['package_list'] = this.packageList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PackageList {
  int? id;
  String? ptype;
  String? pname;
  String? pslug;
  String? price;
  String? validity;
  String? upToDate;
  int? status;
  String? description;
  int? count;
  String? createdAt;
  String? updatedAt;

  PackageList(
      {this.id,
        this.ptype,
        this.pname,
        this.pslug,
        this.price,
        this.validity,
        this.upToDate,
        this.status,
        this.description,
        this.count,
        this.createdAt,
        this.updatedAt});

  PackageList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ptype = json['ptype'];
    pname = json['pname'];
    pslug = json['pslug'];
    price = json['price'];
    validity = json['validity'];
    upToDate = json['up_to_date'];
    status = json['status'];
    description = json['description'];
    count = json['count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ptype'] = this.ptype;
    data['pname'] = this.pname;
    data['pslug'] = this.pslug;
    data['price'] = this.price;
    data['validity'] = this.validity;
    data['up_to_date'] = this.upToDate;
    data['status'] = this.status;
    data['description'] = this.description;
    data['count'] = this.count;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
