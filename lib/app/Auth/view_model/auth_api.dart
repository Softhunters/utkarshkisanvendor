import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:http/http.dart';

import '../../../common_widgets/snack_bar.dart';
import '../../../common_widgets/urls.dart';
import '../../../config/shared_prif.dart';
import '../modal/my_package_response.dart';
import '../modal/subscription_pakage_response.dart';
import '../view/register_screen.dart';

class AuthApi {
  String device_token = "";

  Future<dynamic> userRegister(UserModel data) async {
    device_token = SharedStorage.localStorage?.getString("fcm_token") ?? "";



    try {
      final body = {
        'name': data.userName,
        'email': data.email,
        'phone': data.phone,
        'password': data.password,
        'device_token': device_token,
        "utype":"VDR",
        "package":data.pakageId,
      };
      final response = await post(
          Uri.parse(
            registerURL,
          ),
          body: body);


      print("mnmnmnmnmn $body");

      final parseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if(parseData['status']==true){
          showSnackBar(
              snackPosition: SnackPosition.TOP,
              title: "Success",
              description: parseData['message'].toString());
          // var data = CartModel.fromJson(parseData);
          return parseData;
        }
        else{
          if (parseData['errors'] != null && parseData['errors'] is Map) {
            final errors = parseData['errors'] as Map<String, dynamic>;
            for (var entry in errors.entries) {
              if (entry.value is List) {
                for (var message in entry.value) {
                  showSnackBar(
                    snackPosition: SnackPosition.TOP,
                    title: "${entry.key.capitalizeFirst} Error",
                    description: message.toString(),
                  );
                  await Future.delayed(const Duration(seconds: 2)); // Small delay between snackbars
                }
              }
            }
          }
          return null;
        }
      } else {
        // Show validation errors one by one (if available)

      }
    } on Exception catch (e) {
      // TODO
    }
  }

  Future<dynamic> userLogin(UserModel data) async {
    device_token = SharedStorage.localStorage?.getString("fcm_token") ?? "";
    try {
      final body = {
        'email': data.email,
        'password': data.password,
        'device_token': device_token
      };


      final response = await post(Uri.parse(loginURL), body: body);

      final parseData = jsonDecode(response.body);

      if (parseData["status"] != false) {
        return parseData;
      } else {
        showSnackBar(
            snackPosition: SnackPosition.TOP,
            title: "Failed",
            description: parseData['message'].toString());
        return null;
      }
    } on Exception catch (e) {
      // TODO
    }
  }

  Future<bool?> otpSending(String number) async {
    device_token = SharedStorage.localStorage?.getString("fcm_token") ?? "";
    try {

      var body = {
        'number': number
      };
      final url = Uri.parse(
        getOtpURL,
      );


      final response = await post(url,body: body);

      final parseData = jsonDecode(response.body);
      print("wewewewewewe ${parseData}");
      if (parseData["status"] != false) {
        showSnackBar(
            snackPosition: SnackPosition.TOP,
            title: "Success",
            description: parseData['message'].toString());
        return true;
      } else {
        showSnackBar(
            snackPosition: SnackPosition.TOP,
            title: "Failed",
            description: parseData['message'].toString());
        return false;
      }
    } on Exception catch (e) {
      // TODO
    }
  }

  Future<dynamic> otpVerifyApi(String number, String otp) async {
    device_token = SharedStorage.localStorage?.getString("fcm_token") ?? "";
    try {
      final body = {
        'number': number,
        'otp': otp,
        'device_token': device_token,
      };
      final response = await post(
          Uri.parse(
            verifyOtpURL,
          ),
          body: body);

      final parseData = jsonDecode(response.body);

      if (parseData["status"] != false) {
        showSnackBar(
            snackPosition: SnackPosition.TOP,
            title: "Success",
            description: parseData['message'].toString());
        return parseData;
      } else {
        showSnackBar(
            snackPosition: SnackPosition.TOP,
            title: "Failed",
            description: parseData['message'].toString());
        return null;
      }
    } on Exception catch (e) {
      // TODO
    }
  }

  Future<bool?> forgotPassword(String email) async {
    device_token = SharedStorage.localStorage?.getString("fcm_token") ?? "";
    try {
      var headers = {'Accept': 'application/json'};

      final body = {
        'email': email,
      };

      final response = await post(Uri.parse(forgotPasswordURL),
          headers: headers, body: body);

      final parseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        showSnackBar(
            snackPosition: SnackPosition.TOP,
            title: "Success",
            description: parseData['message'].toString());
        return true;
      } else {
        showSnackBar(
            snackPosition: SnackPosition.TOP,
            title: "Failed",
            description: parseData['message'].toString());
        return false;
      }
    } on Exception catch (e) {
      // TODO
    }
  }




  Future<SubscriptionPakageResponse?> getSubscriptionPakageList() async {
    var headers = {
      'Accept': 'application/json',
    };
    try {
      final response = await get(Uri.parse(subscritionPakageList),headers: headers);

      final parseData = jsonDecode(response.body);
     print("lklklklklk $parseData}");


      if (response.statusCode == 200) {
        var data = SubscriptionPakageResponse.fromJson(parseData);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      // TODO
    }
  }



  Future<MyPakckgeResponse?> getMyPackageList() async {
    String token = SharedStorage.localStorage?.getString("token") ?? "";
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      final response = await get(Uri.parse(mySubscripedPakage),headers: headers);

      final parseData = jsonDecode(response.body);
      print("my package data $parseData}");

      print("status code ; ${response.statusCode}");
      if (response.statusCode == 200) {
        var data = MyPakckgeResponse.fromJson(parseData);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      // TODO
    }
  }




}
