import 'dart:convert';

import 'package:e_commerce/app/Search/search_screen.dart';
import 'package:http/http.dart';

import '../../../common_widgets/urls.dart';
import '../../../config/shared_prif.dart';
import '../../Brand/model/brand_model.dart';
import '../model/search_model.dart';

class SearchApi {
  Future<SearchModel?> getSearchProductApi(type,
      String brandSlug, String perPage, ApplyFilterModel data) async {


    String concatenatedString = data.filterBrand?.join(',') ??"";
    String token = SharedStorage.localStorage?.getString("token") ?? "";
    var headers = {'Authorization': 'Bearer $token'};

    print("${data.filterBrand?.join(', ')}");
    var url = type==1 ? Uri.parse("$searchProductURL$brandSlug?per_page=$perPage&sorting=${data.filterSortBy}&mip=${data.filterMinPrice.toString()}&map=${data.filterMaxPrice.toString()}&brandtype[0]=$concatenatedString&discount[0]=${data.filterDiscount}"):Uri.parse("$searchProductURL$brandSlug?per_page=$perPage");
    // url.replace(queryParameters: body);
    print(url);
    try {
      final response = await get(
        url,
        headers: headers,
      );
      print(response.statusCode);
      final parseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var data = SearchModel.fromJson(parseData);
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
    String token = SharedStorage.localStorage?.getString("token") ?? "";
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
      final parseData =  jsonDecode(response.body);

      print(response.body);
      print(parseData);
      if (response.statusCode == 200) {
        print(parseData);
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
