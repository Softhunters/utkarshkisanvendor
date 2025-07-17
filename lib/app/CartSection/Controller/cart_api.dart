
import 'dart:convert';

import 'package:utkrashvendor/app/CartSection/Model/cart_model.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:http/http.dart';

import '../../../common_widgets/snack_bar.dart';
import '../../../common_widgets/urls.dart';
import '../../../config/shared_prif.dart';
import '../../Payment/View/payment_screen.dart';
import '../Model/check_out_model.dart';
import '../Model/coupon_model.dart';

class CartApi{



  Future<CartModel?> getCart() async {
  String  token =  SharedStorage.localStorage?.getString("token") ??"";
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await get(Uri.parse(getCartURL),headers: headers);

      final parseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var data = CartModel.fromJson(parseData);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      // TODO
    }
  }


  Future<CheckOutModel?> getCheckOut() async {
  String  token =  SharedStorage.localStorage?.getString("token") ??"";
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await get(Uri.parse(checkOutURL),headers: headers);

      final parseData = jsonDecode(response.body);



      if (response.statusCode == 200) {
        var data = CheckOutModel.fromJson(parseData);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      // TODO
    }
  }


  Future<dynamic> addCart(product_id, quantity, String sId) async {
    String token = SharedStorage.localStorage?.getString("token") ?? "";
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      // ✅ Construct URL without sId in path
      final url = Uri.parse("$addCartURL$product_id/$quantity")
          .replace(queryParameters: {"sid": sId});



      final response = await get(url, headers: headers);
      final parseData = jsonDecode(response.body);



      if (response.statusCode == 200) {
        showSnackBar(
          snackPosition: SnackPosition.TOP,
          title: "Success",
          description: parseData['msg'].toString(),
        );
        return parseData;
      } else {

        return null;
      }
    } on Exception catch (e) {

      return null;
    }
  }



  Future<dynamic> clearCart() async {
    String  token =  SharedStorage.localStorage?.getString("token") ??"";
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await get(Uri.parse(clearCartURL),headers: headers);

      final parseData = jsonDecode(response.body);

      if (response.statusCode == 200) {

        showSnackBar(snackPosition: SnackPosition.TOP,
            title: "Success",
            description: parseData['msg'].toString());

        return parseData;
      } else {
        return null;
      }
    } on Exception catch (e) {
      // TODO
    }
  }




  Future<CouponModel?> getCoupon() async {
    String  token =  SharedStorage.localStorage?.getString("token") ??"";
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await get(Uri.parse(promoCodeURL),headers: headers);

      final parseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var data = CouponModel.fromJson(parseData);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      // TODO
    }
  }


  Future<ApplyCouponModel?> applyCoupon(String totalAmount,String subTotal, String couponCode) async {
    String  token =  SharedStorage.localStorage?.getString("token") ??"";
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var body = {
      'totalamount': totalAmount,
      'subtotal': subTotal,
      'CouponCode': couponCode
    };
    try {
      final response = await post(Uri.parse(applyCouponURL),headers: headers,body:body);

      final parseData = jsonDecode(response.body);

      if (response.statusCode == 200) {

          showSnackBar(snackPosition: SnackPosition.TOP,
            title: "Success",
            description: parseData['message'].toString());
          var data = ApplyCouponModel.fromJson(parseData);

        return data ;
      } else {
        return  showSnackBar(snackPosition: SnackPosition.TOP,
            title: "Failed",
            description: parseData['message'].toString());;
      }
    } on Exception catch (e) {
      // TODO
    }
  }


  Future<dynamic> makePaymentApi(PaymentModel data) async {
    String  token =  SharedStorage.localStorage?.getString("token") ??"";
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var body = {
      'payment_type': data.paymentType,
      'shipping_id': data.addressId,
      'subtotal': data.subtotal,
      'discount': data.discount,
      'tax': data.tax,
      'shipping_charge': data.shippingCharge,
      'total': data.total
    };

    try {
      final response = await post(Uri.parse(makeOrderURL),headers: headers,body:body);

      final parseData = jsonDecode(response.body);



      if (response.statusCode == 200) {

          showSnackBar(snackPosition: SnackPosition.TOP,
            title: "Success",
            description: parseData['message'].toString());


        return parseData ;
      } else {
        showSnackBar(snackPosition: SnackPosition.TOP,
            title: "Failed",
            description: parseData['message'].toString());

        return null;
      }
    } on Exception catch (e) {
      // TODO
    }
  }

}