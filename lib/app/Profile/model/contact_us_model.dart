class ContactUsModel {
  bool? status;
  ContactData? result;
  String? dollarRate;

  ContactUsModel({this.status, this.result,this.dollarRate});

  ContactUsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result =
    json['result'] != null ? ContactData.fromJson(json['result']) : null;
    dollarRate = json['dollar_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    data['dollar_rate'] = this.dollarRate;
    return data;
  }
}

class ContactData {
  int? id;
  String? siteName;
  String? email;
  String? webLogo;
  String? favicon;
  String? mobileLogo;
  String? phone;
  String? phone2;
  String? address;
  String? map;
  String? twiter;
  String? facebook;
  String? pinterest;
  String? instagram;
  String? youtube;
  String? createdAt;
  String? updatedAt;

  ContactData(
      {this.id,
        this.siteName,
        this.email,
        this.webLogo,
        this.favicon,
        this.mobileLogo,
        this.phone,
        this.phone2,
        this.address,
        this.map,
        this.twiter,
        this.facebook,
        this.pinterest,
        this.instagram,
        this.youtube,
        this.createdAt,
        this.updatedAt});

  ContactData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    siteName = json['site_name'];
    email = json['email'];
    webLogo = json['web_logo'];
    favicon = json['favicon'];
    mobileLogo = json['mobile_logo'];
    phone = json['phone'];
    phone2 = json['phone2'];
    address = json['address'];
    map = json['map'];
    twiter = json['twiter'];
    facebook = json['facebook'];
    pinterest = json['pinterest'];
    instagram = json['instagram'];
    youtube = json['youtube'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['site_name'] = siteName;
    data['email'] = email;
    data['web_logo'] = webLogo;
    data['favicon'] = favicon;
    data['mobile_logo'] = mobileLogo;
    data['phone'] = phone;
    data['phone2'] = phone2;
    data['address'] = address;
    data['map'] = map;
    data['twiter'] = twiter;
    data['facebook'] = facebook;
    data['pinterest'] = pinterest;
    data['instagram'] = instagram;
    data['youtube'] = youtube;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}