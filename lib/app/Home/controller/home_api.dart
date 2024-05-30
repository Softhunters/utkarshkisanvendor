import 'dart:convert';

import 'package:e_commerce/app/Auth/view/login_screen.dart';
import 'package:e_commerce/app/CategoryProduct/model/cate_product_model.dart';
import 'package:e_commerce/app/Profile/model/profile_model.dart';
import 'package:e_commerce/common_widgets/snack_bar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../../../common_widgets/urls.dart';
import '../../../config/shared_prif.dart';
import '../../CategoryProduct/category_product_screen.dart';
import '../../CategoryProduct/model/all_product_model.dart';
import '../../CategoryProduct/model/product_detail_model.dart';
import '../../Wishlist/model/wishlist_model.dart';
import '../model/home_model.dart';

class ApiService {
  var token;

  Future<dynamic> homeApi() async {

    token =  SharedStorage.localStorage?.getString("token");
   var headers = {
     'Accept': 'application/json',
      'Authorization': 'Bearer $token'
   };
   print(token);

    try {
      final response = await get(Uri.parse(homeURL),headers: headers);
      print(response.statusCode);

      final parseData = jsonDecode(response.body);

      print(parseData);

      if (response.statusCode == 200) {
        var data= HomeModel.fromJson(parseData);
        return data;
      } else if (response.statusCode == 401) {
       showSnackBar(snackPosition: SnackPosition.TOP,
         title: "Warning",
         description: parseData["message"]

       );
       Get.offAll(LoginScreen());
        return parseData;
      }
      else {
        return null;
      }
    } on Exception catch (e) {
      // TODO
    }
    return null;
  }


  Future<AllShopProduct?> getShopProductApi(int page, int perPage) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final url = Uri.parse("$shopProductURL?per_page=${page * perPage}");
    print(url);
    try {
      final response = await get(url,headers: headers);


      final parseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var data = AllShopProduct.fromJson(parseData);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      // TODO
    }
  }


  Future<CategoryProductModel?> getCategoriesApi(String slug,int page, int perPage) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var url =Uri.parse("${cateURL + slug}?per_page=${page * perPage}");
    print(page);
    print(url);
    try {
      final response = await get(url,headers: headers);

      final parseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print("Data aana chahiye ab to");
        var data = CategoryProductModel.fromJson(parseData);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      // TODO
    }
  }

  Future<CategoryProductModel?> getSubCategoriesApi(String cateSlug, String subCatSlug,) async {
    print("start Api");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var url = Uri.parse("${cateURL + cateSlug}/$subCatSlug");
    print(url);
    try {
      final response = await get(url,headers: headers);

      final parseData = jsonDecode(response.body);

      print("=====${response.statusCode}");
      if (response.statusCode == 200) {
        var data = CategoryProductModel.fromJson(parseData);
         print("given data");
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      // TODO
    }
  }

  Future<ProductDetailModel?> getProductDetailApi(String id) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await get(Uri.parse(productDetailURL + id),headers: headers);

      final parseData = jsonDecode(response.body);

      if (response.statusCode == 200) {

        final data = ProductDetailModel.fromJson(parseData);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      // TODO
    }
    return null;
  }

  Future<dynamic> addWishlistApi(String id) async {
    print("id=$id");
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



  Future<bool?> deleteWishlistApi() async {
    print("yeeee");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await get(Uri.parse(deleteAllWishlistURL),headers: headers);
      print("there");
      print(response.statusCode);

      final parseData = jsonDecode(response.body);


      if (response.statusCode == 200) {

        showSnackBar(snackPosition: SnackPosition.TOP,
        description: parseData['msg']);
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      // TODO
    }
  }

  Future<WishlistModel?> getWishlistApi() async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    print(token);
    try {
      final response = await get(Uri.parse(getWishlistURL),headers: headers);

      final parseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = WishlistModel.fromJson(parseData);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      // TODO
    }
  }

  Future<dynamic> moveToCartApi(String id) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await get(Uri.parse(moveToCartURL+id),headers: headers);

      final parseData = jsonDecode(response.body);

      if (response.statusCode == 200) {

          showSnackBar(snackPosition: SnackPosition.TOP,
          title:"Success",
          description: parseData["msg"]);

        return parseData;
      } else {
        return null;
      }
    } on Exception catch (e) {
      // TODO
    }
  }

  Future<bool?> moveToWishlistApi(String id) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await get(Uri.parse(moveToWishlistURL+id),headers: headers);

      final parseData = jsonDecode(response.body);

      if (parseData["status"]==true) {

          showSnackBar(snackPosition: SnackPosition.TOP,
          title: "",
          description: parseData["msg"]);


        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      // TODO
    }
  }



  Future<ProfileModel?> getProfile() async {


    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await get(Uri.parse(getProfileURL),headers: headers);

      final parseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final data = ProfileModel.fromJson(parseData);
        return data;
      }else if (response.statusCode == 401) {
        showSnackBar(snackPosition: SnackPosition.TOP,
            title: "Warning",
            description: parseData["message"]

        );
        Get.offAll(LoginScreen());
        return parseData;
      } else {
        return null;
      }
    } on Exception catch (e) {
      // TODO
    }
  }

  Future<bool?> applyReferralCodeApi(String referralCode) async {


    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await get(Uri.parse(applyReferralURL + referralCode),headers: headers);

      final parseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        // final data = ProfileModel.fromJson(parseData);
        showSnackBar(snackPosition: SnackPosition.TOP,
            title: "Success",
            description: parseData["message"]

        );
        return true;
      }else if (response.statusCode == 401) {
        showSnackBar(snackPosition: SnackPosition.TOP,
            title: "Warning",
            description: parseData["message"]
        );
        Get.offAll(LoginScreen());
        return false;
      } else {
        return false;
      }
    } on Exception catch (e) {
      // TODO
    }
  }

}
