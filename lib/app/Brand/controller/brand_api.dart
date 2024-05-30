

import 'dart:convert';

import 'package:http/http.dart';

import '../../../common_widgets/urls.dart';
import '../../../config/shared_prif.dart';
import '../model/brand_model.dart';

class BrandApi {
  Future<BrandProductModel?> getBrandProduct(String brandSlug,page,perPage) async {
    String  token =  SharedStorage.localStorage?.getString("token") ??"";
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await get(Uri.parse("$brandProductURL$brandSlug?per_page=${page * perPage}"),headers: headers);

      final parseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var data = BrandProductModel.fromJson(parseData);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      // TODO
    }
  }



  Future<dynamic> addWishlistApi(String id) async {
    print("id=$id");
    String  token =  SharedStorage.localStorage?.getString("token") ??"";
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final url = Uri.parse(addWishlistURL + id);
    print(url);
    try {
      final response = await get(url,headers: headers);
      print(response.statusCode);
      // print(response.body);
      final parseData =await jsonDecode(response.body);

      print(parseData);
      if (response.statusCode == 200) {
        return parseData;
      } else {
        print(parseData);
        return null;
      }
    } on Exception catch (e) {
      // TODO
    }
  }
}