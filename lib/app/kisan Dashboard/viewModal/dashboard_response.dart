class DashboardResponse {
  bool? status;
  DashboardResult? result;

  DashboardResponse({this.status, this.result});

  DashboardResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result =
    json['result'] != null ? new DashboardResult.fromJson(json['result']) : null;
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

class DashboardResult {
  int? totalProducts;
  int? totalSellers;
  int? vendorProducts;
  int? totalVendorOrders;

  DashboardResult(
      {this.totalProducts,
        this.totalSellers,
        this.vendorProducts,
        this.totalVendorOrders});

  DashboardResult.fromJson(Map<String, dynamic> json) {
    totalProducts = json['totalProducts'];
    totalSellers = json['totalSellers'];
    vendorProducts = json['vendorProducts'];
    totalVendorOrders = json['totalVendorOrders'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalProducts'] = this.totalProducts;
    data['totalSellers'] = this.totalSellers;
    data['vendorProducts'] = this.vendorProducts;
    data['totalVendorOrders'] = this.totalVendorOrders;
    return data;
  }
}