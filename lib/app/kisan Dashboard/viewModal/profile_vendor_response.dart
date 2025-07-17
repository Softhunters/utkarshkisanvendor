class ProfileVendorResponse {
  bool? status;
  ProfileResult? result;

  ProfileVendorResponse({this.status, this.result});

  ProfileVendorResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result =
    json['result'] != null ? new ProfileResult.fromJson(json['result']) : null;
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

class ProfileResult {
  UserDetailVendor? userDetail;
  SellerDetails? sellerDetails;

  ProfileResult({this.userDetail, this.sellerDetails});

  ProfileResult.fromJson(Map<String, dynamic> json) {
    userDetail = json['user_detail'] != null
        ? new UserDetailVendor.fromJson(json['user_detail'])
        : null;
    sellerDetails = json['seller_details'] != null
        ? new SellerDetails.fromJson(json['seller_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userDetail != null) {
      data['user_detail'] = this.userDetail!.toJson();
    }
    if (this.sellerDetails != null) {
      data['seller_details'] = this.sellerDetails!.toJson();
    }
    return data;
  }
}

class UserDetailVendor {
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
  String? referralCode;
  String? referralBy;
  String? otp;

  UserDetailVendor(
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
        this.referralBy,
        this.otp});

  UserDetailVendor.fromJson(Map<String, dynamic> json) {
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
    referralCode = json['referral_code'];
    referralBy = json['referral_by'];
    otp = json['otp'];
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
    data['otp'] = this.otp;
    return data;
  }
}

class SellerDetails {
  int? id;
  int? vendorId;
  String? address;
  String? state;
  String? city;
  String? country;
  String? pinCode;
  String? idProofType;
  String? proofImage;
  String? gstinNumber;
  String? gstinImage;
  int? status;
  String? createdAt;
  String? updatedAt;

  SellerDetails(
      {this.id,
        this.vendorId,
        this.address,
        this.state,
        this.city,
        this.country,
        this.pinCode,
        this.idProofType,
        this.proofImage,
        this.gstinNumber,
        this.gstinImage,
        this.status,
        this.createdAt,
        this.updatedAt});

  SellerDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    address = json['address'];
    state = json['state'];
    city = json['city'];
    country = json['country'];
    pinCode = json['pin_code'];
    idProofType = json['id_proof_type'];
    proofImage = json['proof_image'];
    gstinNumber = json['gstin_number'];
    gstinImage = json['gstin_image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['address'] = this.address;
    data['state'] = this.state;
    data['city'] = this.city;
    data['country'] = this.country;
    data['pin_code'] = this.pinCode;
    data['id_proof_type'] = this.idProofType;
    data['proof_image'] = this.proofImage;
    data['gstin_number'] = this.gstinNumber;
    data['gstin_image'] = this.gstinImage;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

