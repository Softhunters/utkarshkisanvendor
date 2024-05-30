class ProfileModel {
  bool? status;
  Result? result;

  ProfileModel({this.status, this.result});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
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

class Result {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? emailVerifiedAt;
  String? profile;
  String? utype;
  String? status;
  String? isActive;
  String? createdAt;
  String? updatedAt;
  String? deviceToken;
  String? referralCode;
  String? referralBy;

  Result(
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
        this.deviceToken,
        this.referralCode,
        this.referralBy});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    emailVerifiedAt = json['email_verified_at'];
    profile = json['profile'];
    utype = json['utype'];
    status = json['status'].toString();
    isActive = json['is_active'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deviceToken = json['device_token'];
    referralCode = json['referral_code'];
    referralBy = json['referral_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['referral_code'] = this.referralCode;
    data['referral_by'] = this.referralBy;
    return data;
  }
}