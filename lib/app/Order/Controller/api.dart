
import 'dart:convert';
import 'dart:io';

import 'package:e_commerce/app/Order/model/order_deatil_model.dart';
import 'package:e_commerce/common_widgets/snack_bar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../../../common_widgets/urls.dart';
import '../../../config/shared_prif.dart';
import '../View/order_detail_screen.dart';
import '../model/order_history_model.dart';

class OrderApi {

  Future<OrderHistoryModel?> getAllOrder() async {
    String  token =  SharedStorage.localStorage?.getString("token") ??"";
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await get(Uri.parse(orderURL),headers: headers);

      final parseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var data = OrderHistoryModel.fromJson(parseData);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      // TODO
    }
  }


  Future<OrderDetailModel?> getAllOrderDetail(orderId) async {
    String  token =  SharedStorage.localStorage?.getString("token") ??"";
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await get(Uri.parse(orderDetailURL+orderId),headers: headers);

      final parseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var data = OrderDetailModel.fromJson(parseData);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      // TODO
    }
  }

 Future<dynamic> createReviewApi(ReviewCreate data)async{
    String  token =  SharedStorage.localStorage?.getString("token") ??"";
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var request = http.MultipartRequest('POST', Uri.parse(addReviewURL));
    request.fields.addAll({
      'product_id': data.productId ??"",
      'order_id': data.orderId??"",
      'orderlist_id': data.orderListId ??"",
      'rating': data.rating ??"0",
      'message': data.review ??""
    });


    for (File image in data.image!) {
      request.files.add(await http.MultipartFile.fromPath(
        'images[]', image.path,
      ));
    }

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    // print("review status===${response.statusCode}");
    // print(await response.stream.bytesToString());
    var data1 = await response.stream.bytesToString();
    dynamic jsonData = json.decode(data1);

    if (response.statusCode == 200) {

      return jsonData;
    } else {
    return null;
    }

  }

 Future<dynamic> cancelOrderApi(String orderId, String itemId)async{
    String  token =  SharedStorage.localStorage?.getString("token") ??"";
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var url =Uri.parse("$cancelOrderURL$orderId/$itemId");
    print(url);
    final response = await get(url,headers: headers);

    final parseData = jsonDecode(response.body);

      print(parseData);
      print(response.statusCode);
    if (response.statusCode == 200) {
      showSnackBar(snackPosition: SnackPosition.TOP,
      title: "Success",
      description: parseData["message"]);
      return parseData;
    } else {
    return null;
    }

  }

  Future<dynamic> returnOrderApi(String orderId, String itemId)async{
    String  token =  SharedStorage.localStorage?.getString("token") ??"";
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var url =Uri.parse("$returnOrderURL$orderId/$itemId");
    print(url);
    final response = await get(url,headers: headers);

    final parseData = jsonDecode(response.body);

      print(parseData);
      print(response.statusCode);
    if (response.statusCode == 200) {
      showSnackBar(snackPosition: SnackPosition.TOP,
      title: "Success",
      description: parseData["message"]);
      return parseData;
    } else {
    return null;
    }

  }

}