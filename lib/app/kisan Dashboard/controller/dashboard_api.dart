import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:utkrashvendor/app/kisan%20Dashboard/controller/dashboard_controller.dart';
import 'package:utkrashvendor/app/kisan%20Dashboard/viewModal/dashboard_response.dart';
import 'package:utkrashvendor/app/kisan%20Dashboard/viewModal/order_details_response.dart';
import 'package:utkrashvendor/app/kisan%20Dashboard/viewModal/variant_response.dart';
import 'package:utkrashvendor/common_widgets/urls.dart';

import '../../../common_widgets/snack_bar.dart';
import '../../../config/shared_prif.dart';
import '../../Auth/view/login_screen.dart';
import '../../Profile/model/country_model.dart';
import '../viewModal/edit_response.dart';
import '../viewModal/order_history_by_product.dart';
import '../viewModal/order_list_variant_response.dart';
import '../viewModal/product_inventory_history_response.dart';
import '../viewModal/profile_vendor_response.dart';
import '../viewModal/vendor_orders_response.dart';
import '../viewModal/vendor_product_details_response.dart';

class ApiServicess {
  var token;

  Future<dynamic> getDashboard() async {
    token = SharedStorage.localStorage?.getString("token");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await get(Uri.parse(dashboard), headers: headers);

      final parseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var data = DashboardResponse.fromJson(parseData);
        return data;
      } else if (response.statusCode == 401) {
        showSnackBar(
            snackPosition: SnackPosition.TOP,
            title: "Warning",
            description: parseData["message"]);
        Get.offAll(LoginScreen());
        return parseData;
      } else {
        return null;
      }
    } on Exception catch (e) {
      // TODO
    }
    return null;
  }

  Future<dynamic> getProfileData() async {
    token = SharedStorage.localStorage?.getString("token");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await get(Uri.parse(profileGETVedor), headers: headers);

      final parseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var data = ProfileVendorResponse.fromJson(parseData);
        return data;
      } else if (response.statusCode == 401) {
        showSnackBar(
            snackPosition: SnackPosition.TOP,
            title: "Warning",
            description: parseData["message"]);
        Get.offAll(LoginScreen());
        return parseData;
      } else {
        return null;
      }
    } on Exception catch (e) {
      // TODO
    }
    return null;
  }

  Future<Map<String, dynamic>?> orderAcceptByVandarData(String? id) async {
    token = SharedStorage.localStorage?.getString("token");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response =
          await get(Uri.parse("$orderAcceptByVandar/$id"), headers: headers);

      final parseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 401) {
        return parseData;
      }
    } catch (e) {}

    return null;
  }

  Future<Map<String, dynamic>?> orderRejectByVandarData(String? id) async {
    token = SharedStorage.localStorage?.getString("token");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response =
          await get(Uri.parse("$orderRejectByVandar/$id"), headers: headers);

      final parseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 401) {
        return parseData;
      }
    } catch (e) {}

    return null;
  }

  Future<dynamic> getVariant() async {
    token = SharedStorage.localStorage?.getString("token");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await get(Uri.parse(variant), headers: headers);

      final parseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var data = VariantResponse.fromJson(parseData);
        return data;
      } else if (response.statusCode == 401) {
        showSnackBar(
            snackPosition: SnackPosition.TOP,
            title: "Warning",
            description: parseData["message"]);
        Get.offAll(LoginScreen());
        return parseData;
      } else {
        return null;
      }
    } on Exception catch (e) {
      // TODO
    }
    return null;
  }

  Future<bool?> toggleStockStatusData(String variantId) async {
    final token = SharedStorage.localStorage?.getString("token");

    try {
      var body = {'variant_id': variantId};
      final url = Uri.parse(toggleStockStatus);

      final response = await http.post(
        url,
        body: body,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      final parseData = jsonDecode(response.body);

      if (parseData["status"] != false) {
        showSnackBar(
          snackPosition: SnackPosition.TOP,
          title: "Success",
          description: parseData['message'].toString(),
        );
        return true;
      } else {
        showSnackBar(
          snackPosition: SnackPosition.TOP,
          title: "Failed",
          description: parseData['message'].toString(),
        );
        return false;
      }
    } on Exception catch (e) {
      showSnackBar(
        snackPosition: SnackPosition.TOP,
        title: "Error",
        description: "Something went wrong!",
      );
      return false;
    }
  }

  Future<bool?> updateVariantData(VariantUpdateModel data) async {
    final token = SharedStorage.localStorage?.getString("token");

    try {
      var body = {
        'product_id': data.productId,
        "price": data.price,
        "quantity": data.quantity,
        "additional_info": data.additionalInfo,
        "status": data.status
      };
      final url = Uri.parse(updateVariant);

      final response = await http.post(
        url,
        body: body,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      final parseData = jsonDecode(response.body);

      if (parseData["status"] != false) {
        showSnackBar(
          snackPosition: SnackPosition.TOP,
          title: "Success",
          description: parseData['message'].toString(),
        );
        return true;
      } else {
        showSnackBar(
          snackPosition: SnackPosition.TOP,
          title: "Failed",
          description: parseData['message'].toString(),
        );
        return false;
      }
    } on Exception catch (e) {
      showSnackBar(
        snackPosition: SnackPosition.TOP,
        title: "Error",
        description: "Something went wrong!",
      );
      return false;
    }
  }

  Future<dynamic> editvariant(String? productid) async {
    token = SharedStorage.localStorage?.getString("token");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response =
          await get(Uri.parse("${editVariant}/${productid}"), headers: headers);

      final parseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var data = EditVarientResponse.fromJson(parseData);
        return data;
      } else if (response.statusCode == 401) {
        showSnackBar(
            snackPosition: SnackPosition.TOP,
            title: "Warning",
            description: parseData["message"]);
        Get.offAll(LoginScreen());
        return parseData;
      } else {
        return null;
      }
    } on Exception catch (e) {
      // TODO
    }
    return null;
  }

  Future<dynamic> verndorProductDetail(String productId) async {
    token = SharedStorage.localStorage?.getString("token");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await get(Uri.parse("${productVendor}/${productId}"),
          headers: headers);

      final parseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var data = VendorProductDetailResponse.fromJson(parseData);
        return data;
      } else if (response.statusCode == 401) {
        showSnackBar(
            snackPosition: SnackPosition.TOP,
            title: "Warning",
            description: parseData["message"]);
        Get.offAll(LoginScreen());
        return parseData;
      } else {
        return null;
      }
    } on Exception catch (e) {
      // TODO
    }
    return null;
  }

  // Future<bool?> addVariantData(VariantAddModel data) async {
  //   final token = SharedStorage.localStorage?.getString("token");
  //
  //   try {
  //     var body = {
  //       'product_id': data.productId,
  //       "price": data.price,
  //       "quantity": data.quantity,
  //       "additional_info": data.additionalInfo,
  //     };
  //     final url = Uri.parse(addVariant);
  //
  //     final response = await http.post(
  //       url,
  //       body: body,
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //       },
  //     );
  //
  //     final parseData = jsonDecode(response.body);
  //     print("ewewewewew ${parseData["status"]}");
  //
  //     if (parseData["status"] != false) {
  //       showSnackBar(
  //         snackPosition: SnackPosition.TOP,
  //         title: "Success",
  //         description: parseData['message'].toString(),
  //       );
  //       return true;
  //     } else {
  //       showSnackBar(
  //         snackPosition: SnackPosition.TOP,
  //         title: "Failed",
  //         description: parseData['message'].toString(),
  //       );
  //       return false;
  //     }
  //   } on Exception catch (e) {
  //     showSnackBar(
  //       snackPosition: SnackPosition.TOP,
  //       title: "Error",
  //       description: "Something went wrong!",
  //     );
  //     return false;
  //   }
  // }

  Future<Map<String, dynamic>?> addVariantData(VariantAddModel data) async {
    final token = SharedStorage.localStorage?.getString("token");

    try {
      var body = {
        'product_id': data.productId,
        "price": data.price,
        "quantity": data.quantity,
        "additional_info": data.additionalInfo,
      };
      final url = Uri.parse(addVariant);

      final response = await http.post(
        url,
        body: body,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      final parseData = jsonDecode(response.body);
      print("ewewewewew ${parseData["status"]}");

      if (parseData["status"] != false) {
        showSnackBar(
          snackPosition: SnackPosition.TOP,
          title: "Success",
          description: parseData['message'].toString(),
        );
      } else {
        showSnackBar(
          snackPosition: SnackPosition.TOP,
          title: "Failed",
          description: parseData['message'].toString(),
        );
      }

      return parseData;
    } catch (e) {
      showSnackBar(
        snackPosition: SnackPosition.TOP,
        title: "Error",
        description: "Something went wrong!",
      );
      return null;
    }
  }


  Future<bool?> addQuantityVandorData(AddQuantityModel data) async {
    final token = SharedStorage.localStorage?.getString("token");

    try {
      var body = {
        'id': data.id,
        "quantity": data.quantity,
      };
      final url = Uri.parse(addQuantityVandor);

      print("url ${url}");
      print("body : $body");

      final response = await http.post(
        url,
        body: body,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      print("status : ${response.statusCode}");

      final parseData = jsonDecode(response.body);
      print("data ;${parseData}");

      if (parseData["status"] != false) {
        showSnackBar(
          snackPosition: SnackPosition.TOP,
          title: "Success",
          description: parseData['message'].toString(),
        );
        return true;
      } else {
        showSnackBar(
          snackPosition: SnackPosition.TOP,
          title: "Failed",
          description: parseData['message'].toString(),
        );
        return false;
      }
    } on Exception catch (e) {
      showSnackBar(
        snackPosition: SnackPosition.TOP,
        title: "Error",
        description: "Something went wrong!",
      );
      return false;
    }
  }

  Future<dynamic> getVandorOrders() async {
    token = SharedStorage.localStorage?.getString("token");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await get(Uri.parse(ordersForVandor), headers: headers);

      final parseData = jsonDecode(response.body);

      print("xzxzxzxzxzxxzx ${response.statusCode}   ${parseData}");


      if (response.statusCode == 200) {
        var data = VendorOrdersResponse.fromJson(parseData);
        return data;
      } else if (response.statusCode == 401) {
        showSnackBar(
            snackPosition: SnackPosition.TOP,
            title: "Warning",
            description: parseData["message"]);
        Get.offAll(LoginScreen());
        return parseData;
      } else {
        return null;
      }
    } on Exception catch (e) {
      // TODO
    }
    return null;
  }

  Future<dynamic> getOrderHistoryByProduct() async {
    token = SharedStorage.localStorage?.getString("token");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response =
          await get(Uri.parse(vandorHistoryByProduct), headers: headers);

      final parseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var data = VendorOrderHistoryByProductResponse.fromJson(parseData);
        return data;
      } else if (response.statusCode == 401) {
        showSnackBar(
            snackPosition: SnackPosition.TOP,
            title: "Warning",
            description: parseData["message"]);
        Get.offAll(LoginScreen());
        return parseData;
      } else {
        return null;
      }
    } on Exception catch (e) {
      // TODO
    }
    return null;
  }

  Future<dynamic> getProductInventoryHistory(String? id) async {
    token = SharedStorage.localStorage?.getString("token");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response =
          await get(Uri.parse("${productHistoryById}/${id}"), headers: headers);

      final parseData = jsonDecode(response.body);

      print("url: ${Uri.parse("${productHistoryById}/${id}")}");
      print("status :${response.statusCode}");

      if (response.statusCode == 200) {
        var data = ProductInventoryHistoryResponse.fromJson(parseData);
        return data;
      } else if (response.statusCode == 401) {
        showSnackBar(
            snackPosition: SnackPosition.TOP,
            title: "Warning",
            description: parseData["message"]);
        Get.offAll(LoginScreen());
        return parseData;
      } else {
        return null;
      }
    } on Exception catch (e) {
      // TODO
    }
    return null;
  }

  Future<dynamic> getOrderList(String id) async {
    token = SharedStorage.localStorage?.getString("token");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'

    };


    try {
      final response =
          await get(Uri.parse("${orderListVander}/${id}"), headers: headers);

      final parseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var data = OrderListVarientResponse.fromJson(parseData);
        return data;
      } else if (response.statusCode == 401) {
        showSnackBar(
            snackPosition: SnackPosition.TOP,
            title: "Warning",
            description: parseData["message"]);
        Get.offAll(LoginScreen());
        return parseData;
      } else {
        return null;
      }
    } on Exception catch (e) {
      // TODO
    }
    return null;
  }

  Future<dynamic> getOrderDetails(String id) async {
    token = SharedStorage.localStorage?.getString("token");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response =
          await get(Uri.parse("${orderDetailsVander}/${id}"), headers: headers);

      final parseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var data = OrderDetailsVarientResponse.fromJson(parseData);
        return data;
      } else if (response.statusCode == 401) {
        showSnackBar(
            snackPosition: SnackPosition.TOP,
            title: "Warning",
            description: parseData["message"]);
        Get.offAll(LoginScreen());
        return parseData;
      } else {
        return null;
      }
    } on Exception catch (e) {
      // TODO
    }
    return null;
  }

  Future<CountryModel?> getCountryList() async {
    String token = SharedStorage.localStorage?.getString("token") ?? "";
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await get(Uri.parse(getCountryURL), headers: headers);

      final parseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var data = CountryModel.fromJson(parseData);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      // TODO
    }
  }

  Future<StateModel?> getState(String id) async {
    String token = SharedStorage.localStorage?.getString("token") ?? "";
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await get(Uri.parse(getStateURL + id), headers: headers);

      final parseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var data = StateModel.fromJson(parseData);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      // TODO
    }
  }

  Future<DistrictModel?> getDistrict(String id) async {
    String token = SharedStorage.localStorage?.getString("token") ?? "";
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await get(Uri.parse(getcityURL + id), headers: headers);

      final parseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var data = DistrictModel.fromJson(parseData);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      // TODO
    }
  }

  Future<bool?> updateProfileData(ProfileUpdateRequest data) async {
    final token = SharedStorage.localStorage?.getString("token");

    try {
      final url = Uri.parse(profileUpdateVedor);

      var request = http.MultipartRequest('POST', url);

      request.headers['Authorization'] = 'Bearer $token';

      // Add text fields
      request.fields['address'] = data.address ?? '';
      request.fields['country'] = data.country ?? '';
      request.fields['state'] = data.state ?? '';
      request.fields['city'] = data.city ?? '';
      request.fields['pin_code'] = data.pinCode ?? '';
      request.fields['id_proof_type'] = data.idProofType ?? '';
      request.fields['gstin_number'] = data.gstInNumber ?? '';

      // Add PDF files if available
      if (data.idProofPdf != null) {
        request.files.add(data.idProofPdf!);
      }

      if (data.gSTInPDF != null) {
        request.files.add(data.gSTInPDF!);
      }

      final streamedResponse = await request.send();

      final response = await http.Response.fromStream(streamedResponse);

      final parseData = jsonDecode(response.body);

      if (parseData["status"] != false) {
        showSnackBar(
          snackPosition: SnackPosition.TOP,
          title: "Success",
          description: parseData['message'].toString(),
        );
        return true;
      } else {
        showSnackBar(
          snackPosition: SnackPosition.TOP,
          title: "Failed",
          description: parseData['message'].toString(),
        );
        return false;
      }
    } catch (e) {
      showSnackBar(
        snackPosition: SnackPosition.TOP,
        title: "Error",
        description: "Something went wrong!",
      );
      return false;
    }
  }
}
