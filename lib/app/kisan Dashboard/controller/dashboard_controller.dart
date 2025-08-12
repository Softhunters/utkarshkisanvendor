import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:utkrashvendor/app/kisan%20Dashboard/viewModal/dashboard_response.dart';
import 'package:utkrashvendor/app/kisan%20Dashboard/viewModal/order_details_response.dart';
import 'package:utkrashvendor/app/kisan%20Dashboard/viewModal/order_list_variant_response.dart';
import 'package:utkrashvendor/app/kisan%20Dashboard/viewModal/variant_response.dart';
import 'package:utkrashvendor/app/kisan%20Dashboard/viewModal/vendor_orders_response.dart';
import '../../../common_widgets/snack_bar.dart';
import '../../Profile/model/country_model.dart';
import '../view/open_pdf_view.dart';
import '../viewModal/edit_response.dart' as edit;
import '../viewModal/order_history_by_product.dart';
import '../viewModal/product_inventory_history_response.dart';
import '../viewModal/profile_vendor_response.dart';
import '../viewModal/vendor_product_details_response.dart';
import 'dashboard_api.dart';

class DashboardController extends ChangeNotifier {
  ApiServicess apiService = ApiServicess();

  TextEditingController searchController = TextEditingController();

  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController additionalInfoController = TextEditingController();

  TextEditingController priceAddController = TextEditingController();
  TextEditingController quantityAddController = TextEditingController();
  TextEditingController additionalInfoAddController = TextEditingController();
  String selectedAddStatus = 'Active';

  TextEditingController addressController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController gstNumberController = TextEditingController();
  TextEditingController addquantityForVandorController =
      TextEditingController();
  final FocusNode address = FocusNode();
  final FocusNode address2 = FocusNode();

  String selectedStatus = 'Active';
  bool isLoading = false;
  DashboardResult? dashboard;
  List<OrderListResult>? orderList;
  List<VendorOrdersResult>? vendorOrders;
  OrderDetailsResult? orderDetails;
  VendorProductDetailResult? vendorProductDetail;
  ProfileResult? profileData;
  VariantResult? variant;
  List<VendorOrderHistoryByProductResult>? orderHistoryByProduct;
  List<ProductInventoryHistoryResult>? productInventoryHistory;
  edit.EditVariantResult? variantEdit;

  final Map<String, bool> itemLoading = {};

  void setItemLoading(String id, bool isLoading) {
    itemLoading[id] = isLoading;
    notifyListeners();
  }

  bool isItemLoading(String id) => itemLoading[id] ?? false;

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> getHomeData() async {
    isLoading = true;
    notifyListeners();

    final dashboardData = await apiService.getDashboard();

    if (dashboardData != null && dashboardData is DashboardResponse) {
      if (dashboardData.status == true) {
        dashboard = dashboardData.result; // ✅ store result
      } else {
        Get.snackbar(
          "Warning",
          "Dashboard fetch failed!",
          snackPosition: SnackPosition.TOP,
        );
      }
    } else {
      Get.snackbar(
        "Error",
        "Something went wrong!",
        snackPosition: SnackPosition.TOP,
      );
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> orderAcceptByVandarDetails(String? id) async {
    isLoading = true;
    notifyListeners();

    final orderAcceptData = await apiService.orderAcceptByVandarData(id);

    if (orderAcceptData != null && orderAcceptData is Map<String, dynamic>) {
      final bool status = orderAcceptData['status'] ?? false;
      final String message = orderAcceptData['message'] ?? "No message";

      if (status) {
        showSnackBar(
          snackPosition: SnackPosition.TOP,
          title: "Success",
          description: message,
        );
      } else {
        showSnackBar(
          snackPosition: SnackPosition.TOP,
          title: "Warning",
          description: message,
        );
      }
    } else {
      showSnackBar(
        snackPosition: SnackPosition.TOP,
        title: "Error",
        description: "Something went wrong!",
      );
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> orderRejectByVandarDetails(String? id) async {
    isLoading = true;
    notifyListeners();

    final orderAcceptData = await apiService.orderRejectByVandarData(id);

    if (orderAcceptData != null && orderAcceptData is Map<String, dynamic>) {
      final bool status = orderAcceptData['status'] ?? false;
      final String message = orderAcceptData['message'] ?? "No message";

      if (status) {
        showSnackBar(
          snackPosition: SnackPosition.TOP,
          title: "Success",
          description: message,
        );
      } else {
        showSnackBar(
          snackPosition: SnackPosition.TOP,
          title: "Warning",
          description: message,
        );
      }
    } else {
      showSnackBar(
        snackPosition: SnackPosition.TOP,
        title: "Error",
        description: "Something went wrong!",
      );
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> getVariantData() async {
    isLoading = true;
    notifyListeners();

    final variantData = await apiService.getVariant();

    if (variantData != null && variantData is VariantResponse) {
      if (variantData.status == true) {
        variant = variantData.result; // ✅ store result
      } else {
        Get.snackbar(
          "Warning",
          "Dashboard fetch failed!",
          snackPosition: SnackPosition.TOP,
        );
      }
    } else {
      Get.snackbar(
        "Error",
        "Something went wrong!",
        snackPosition: SnackPosition.TOP,
      );
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> getOrderHistoryByProductData() async {
    isLoading = true;
    notifyListeners();

    final orderHistoryByProducth = await apiService.getOrderHistoryByProduct();

    if (orderHistoryByProducth != null &&
        orderHistoryByProducth is VendorOrderHistoryByProductResponse) {
      if (orderHistoryByProducth.status == true) {
        orderHistoryByProduct =
            orderHistoryByProducth.result ?? []; // ✅ store result
      } else {
        Get.snackbar(
          "Warning",
          "Dashboard fetch failed!",
          snackPosition: SnackPosition.TOP,
        );
      }
    } else {
      Get.snackbar(
        "Error",
        "Something went wrong!",
        snackPosition: SnackPosition.TOP,
      );
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> getProductInventoryHistoryDetails(String? id) async {
    isLoading = true;
    notifyListeners();

    final productInventoryHistoryData =
        await apiService.getProductInventoryHistory(id);

    if (productInventoryHistoryData != null &&
        productInventoryHistoryData is ProductInventoryHistoryResponse) {
      if (productInventoryHistoryData.status == true) {
        productInventoryHistory =
            productInventoryHistoryData.result ?? []; // ✅ store result
        print("llllll ${productInventoryHistory?.length}");
      } else {
        Get.snackbar(
          "Warning",
          "Dashboard fetch failed!",
          snackPosition: SnackPosition.TOP,
        );
      }
    } else {
      Get.snackbar(
        "Error",
        "Something went wrong!",
        snackPosition: SnackPosition.TOP,
      );
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> stockStatusToggle(String variantId) async {
    final result = await apiService.toggleStockStatusData(variantId);
    if (result == true) {
      // startTimer();
      notifyListeners();
    } else {
      notifyListeners();
    }
  }

  Future<dynamic> updateVariantDetails(
      VariantUpdateModel data1, ValueSetter<bool> onResponse) async {
    final data = await apiService.updateVariantData(data1);

    if (data != null) {
      onResponse(true);
      notifyListeners();
    } else {
      onResponse(false);
      notifyListeners();
    }
  }

  Future<dynamic> addVariantDetails(
      VariantAddModel data1, ValueSetter<bool> onResponse) async {
    final data = await apiService.addVariantData(data1);

    if (data != null && data['status'] != false) {
      onResponse(true);
      notifyListeners();
    } else {
      onResponse(false);
      notifyListeners();
    }
  }

  Future<dynamic> addQuantityVandorDetails(
      AddQuantityModel data1, ValueSetter<bool> onResponse) async {
    final data = await apiService.addQuantityVandorData(data1);

    if (data != null) {
      onResponse(true);
      notifyListeners();
    } else {
      onResponse(false);
      notifyListeners();
    }
  }

  VariantList convertEditResultToVariant(edit.EditVariantResult editData) {
    return VariantList(
      id: editData.id,
      productId: editData.productId,
      vendorId: editData.vendorId,
      price: editData.price,
      quantity: editData.quantity,
      additionalInfo: editData.additionalInfo,
      status: editData.status,
      stockStatus: editData.stockStatus,
      createdAt: editData.createdAt,
      updatedAt: editData.updatedAt,
      deletedAt: editData.deletedAt,
      productApi: ProductApi(
        id: editData.productApi?.id,
        slug: editData.productApi?.slug,
        name: editData.productApi?.name,
        image: editData.productApi?.image,
        regularPrice: editData.productApi?.regularPrice,
        salePrice: editData.productApi?.salePrice,
        variantDetails: editData.productApi?.variantDetail,
      ),
    );
  }

  Future<void> getEditVarientData(String productId) async {
    isLoading = true;
    notifyListeners();

    final editVarientData = await apiService.editvariant(productId);

    if (editVarientData != null &&
        editVarientData is edit.EditVarientResponse) {
      if (editVarientData.status == true) {
        variantEdit = editVarientData?.result; // ✅ store result
      } else {
        Get.snackbar(
          "Warning",
          "Dashboard fetch failed!",
          snackPosition: SnackPosition.TOP,
        );
      }
    } else {
      Get.snackbar(
        "Error",
        "Something went wrong!",
        snackPosition: SnackPosition.TOP,
      );
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> getVendorProductDetails(String productID) async {
    isLoading = true;
    notifyListeners();

    final vendorProductDetailsData =
        await apiService.verndorProductDetail(productID);

    if (vendorProductDetailsData != null &&
        vendorProductDetailsData is VendorProductDetailResponse) {
      if (vendorProductDetailsData.status == true) {
        vendorProductDetail = vendorProductDetailsData.result; // ✅ store result
      } else {
        Get.snackbar(
          "Warning",
          "Dashboard fetch failed!",
          snackPosition: SnackPosition.TOP,
        );
      }
    } else {
      Get.snackbar(
        "Error",
        "Something went wrong!",
        snackPosition: SnackPosition.TOP,
      );
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> getVendorOrdersData() async {
    isLoading = true;
    notifyListeners();

    final vendorOrdersData = await apiService.getVandorOrders();

    if (vendorOrdersData != null && vendorOrdersData is VendorOrdersResponse) {
      if (vendorOrdersData.status == true) {
        vendorOrders = vendorOrdersData.result; // ✅ store result
      } else {
        Get.snackbar(
          "Warning",
          "Dashboard fetch failed!",
          snackPosition: SnackPosition.TOP,
        );
      }
    } else {
      Get.snackbar(
        "Error",
        "Something went wrong!",
        snackPosition: SnackPosition.TOP,
      );
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> getOrderListData(String id) async {
    isLoading = true;
    notifyListeners();

    final orderListData = await apiService.getOrderList(id);

    if (orderListData != null && orderListData is OrderListVarientResponse) {
      if (orderListData.status == true) {
        orderList = orderListData.result; // ✅ store result
      } else {
        Get.snackbar(
          "Warning",
          "Dashboard fetch failed!",
          snackPosition: SnackPosition.TOP,
        );
      }
    } else {
      Get.snackbar(
        "Error",
        "Something went wrong!",
        snackPosition: SnackPosition.TOP,
      );
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> getVendorProfileDetails() async {
    isLoading = true;
    notifyListeners();
    final profileDataVendor = await apiService.getProfileData();

    if (profileDataVendor != null &&
        profileDataVendor is ProfileVendorResponse) {
      if (profileDataVendor.status == true) {
        profileData = profileDataVendor.result; // ✅ store result
      } else {
        Get.snackbar(
          "Warning",
          "Dashboard fetch failed!",
          snackPosition: SnackPosition.TOP,
        );
      }
    } else {
      Get.snackbar(
        "Error",
        "Something went wrong!",
        snackPosition: SnackPosition.TOP,
      );
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> getOrderDetailsData(String id) async {
    isLoading = true;
    notifyListeners();

    final orderDetailtData = await apiService.getOrderDetails(id);

    if (orderDetailtData != null &&
        orderDetailtData is OrderDetailsVarientResponse) {
      if (orderDetailtData.status == true) {
        orderDetails = orderDetailtData.result; // ✅ store result
      } else {
        Get.snackbar(
          "Warning",
          "Dashboard fetch failed!",
          snackPosition: SnackPosition.TOP,
        );
      }
    } else {
      Get.snackbar(
        "Error",
        "Something went wrong!",
        snackPosition: SnackPosition.TOP,
      );
    }

    isLoading = false;
    notifyListeners();
  }

  List<Countries> countries = [];
  String? country;
  String? selectedCountryId;

  Future<dynamic> getCountry() async {
    final data = await apiService.getCountryList();

    if (data != null) {
      countries = data.countries ?? [];
      notifyListeners();
    }
  }

  ///State
  List<States> stateList = [];
  States? selectedState;
  String? selectedStateId;

  Future<dynamic> getState(String countryId) async {
    final data = await apiService.getState(countryId);

    if (data != null) {
      stateList = data.states ?? [];
      notifyListeners();
    }
  }

  /// City
  List<Cities> cityList = [];
  Cities? selectedcity;
  String? selectedCityId;

  Future<dynamic> getCity(String stateId) async {
    final data = await apiService.getDistrict(stateId);

    if (data != null) {
      cityList = data.cities ?? [];

      notifyListeners();
    }
  }

  cityValueSave(
    id,
  ) {
    // selectedcity = name;
    selectedCityId = id;
    notifyListeners();
  }

  final List<String> idProofItems = [
    'Aadhar Card',
    'PAN Card',
    'Voter ID',
  ];
  String selectedIdProof = 'Aadhar Card';

  String? selectedPdfFileUrl;
  String? gstPdfUrl;

  File? selectedPdfFile;
  File? gstPdf;

  Future<void> pickPdfFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      selectedPdfFile = File(result.files.single.path!);
      notifyListeners();
    }
  }

  Future<void> pickPdfFileForGST() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      gstPdf = File(result.files.single.path!);
      notifyListeners();
    }
  }

  void openPdfViewer(BuildContext context) {
    if (selectedPdfFile != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SfPdfViewer.file(selectedPdfFile!),
        ),
      );
    } else if (selectedPdfFileUrl != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SfPdfViewer.network(selectedPdfFileUrl!),
        ),
      );
    }
  }

  void openPdfViewerForGST(BuildContext context) {
    if (gstPdf != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SfPdfViewer.file(gstPdf!),
        ),
      );
    } else if (gstPdfUrl != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SfPdfViewer.network(gstPdfUrl!),
        ),
      );
    }
  }

  Future<http.MultipartFile?> fileToMultipart(
      File? file, String fieldName) async {
    if (file == null) return null;
    return await http.MultipartFile.fromPath(fieldName, file.path);
  }

  Future<dynamic> updateProfileVendor(
      ProfileUpdateRequest data1, ValueSetter<bool> onResponse) async {
    final data = await apiService.updateProfileData(data1);
    if (data != null) {
      onResponse(true);
      notifyListeners();
    } else {
      onResponse(false);
      notifyListeners();
    }
  }
}

class VariantUpdateModel {
  String? productId;
  String? price;
  String? quantity;
  String? additionalInfo;
  String? status;

  VariantUpdateModel(
      {this.productId,
      this.price,
      this.quantity,
      this.additionalInfo,
      this.status});
}

class VariantAddModel {
  String? productId;
  String? price;
  String? quantity;
  String? additionalInfo;

  VariantAddModel(
      {this.productId, this.price, this.quantity, this.additionalInfo});
}

class AddQuantityModel {
  String? id;
  String? quantity;

  AddQuantityModel({this.id, this.quantity});
}

class ProfileUpdateRequest {
  String? address;
  String? country;
  String? state;
  String? city;
  String? pinCode;
  String? idProofType;
  String? gstInNumber;
  http.MultipartFile? idProofPdf;
  http.MultipartFile? gSTInPDF;

  ProfileUpdateRequest(
      {this.address,
      this.country,
      this.state,
      this.city,
      this.pinCode,
      this.idProofType,
      this.gstInNumber,
      this.idProofPdf,
      this.gSTInPDF});
}
