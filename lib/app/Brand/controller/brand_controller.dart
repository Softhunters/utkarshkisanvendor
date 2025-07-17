import 'package:utkrashvendor/app/Brand/controller/brand_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

import '../../../common_widgets/snack_bar.dart';
import '../../CategoryProduct/model/product_detail_model.dart';
import '../../Home/controller/home_api.dart';
import '../../Home/model/home_model.dart';
import '../model/brand_model.dart';

class BrandController extends ChangeNotifier {
  BrandApi brandApi = BrandApi();

  // ApiService apiService = ApiService();

  bool isLoading = false;
  bool brandProductLoading = false;
  List<Products> products = [];
  Brand? brand;

  bool isFetching = false;
  bool pageLoader = false;
  bool pageIncrease = false;
  int pageNo1 = 1;

  setPage() {
    pageIncrease = true;
    pageNo1++;
    notifyListeners();
  }

  setValue(feched, load) {
    isFetching = feched;
    pageLoader = load;
    notifyListeners();
  }

  int? totalBrandProduct;
  String perPage = "10";

  Future<BrandProductModel?> getBrandDAta(String brandSlug) async {
    if (products.isEmpty) {
      isLoading = true;
    } else {
      brandProductLoading = true;
    }
    // products.clear();
    final result =
        await brandApi.getBrandProduct(brandSlug, pageNo1, int.parse(perPage));
    if (result != null) {
      brand = result.result?.brand;

      products = result.result?.products?.data ?? [];
      totalBrandProduct = result.result?.products?.total;
      perPage = result.result?.products?.perPage ?? "";
      isLoading = false;
      brandProductLoading = false;
      pageIncrease = false;
      notifyListeners();
    }
  }

  Future<dynamic> addWishlistProduct(
      id, slug, ValueSetter<bool> onResponse,String sId) async {
    final data = await brandApi.addWishlistApi(id.toString(),sId);
    if (data != null) {
      var message = data['msg'];
      getBrandDAta(slug);
      onResponse(true);
      // productLoading = false;

      showSnackBar(
          snackPosition: SnackPosition.TOP,
          title: "Success",
          description: message);
      notifyListeners();
    }
  }

  String formatValue(int value) {
    if (value > 999 && value <= 99999) {
      double formattedValue = value / 1000;
      return '${formattedValue.toStringAsFixed(1)} K';
    } else if (value > 99999) {
      double formattedValue = value / 100000;
      return '${formattedValue.toStringAsFixed(1)} L';
    } else {
      return '$value';
    }
  }
}
