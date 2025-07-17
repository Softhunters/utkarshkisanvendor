import 'dart:convert';

import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:http/http.dart';

import '../../../common_widgets/snack_bar.dart';
import '../../../common_widgets/urls.dart';
import '../../../config/shared_prif.dart';
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
        "utype":"VDR"
      };
      final response = await post(
          Uri.parse(
            registerURL,
          ),
          body: body);

      final parseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        showSnackBar(
            snackPosition: SnackPosition.TOP,
            title: "Success",
            description: parseData['message'].toString());
        // var data = CartModel.fromJson(parseData);
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
}
