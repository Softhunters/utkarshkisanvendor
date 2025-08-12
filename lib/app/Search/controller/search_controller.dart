import 'package:utkrashvendor/app/Home/controller/home_controller.dart';
import 'package:utkrashvendor/app/Search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

import '../../../common_widgets/snack_bar.dart';
import '../../../common_widgets/urls.dart';
import '../../CategoryProduct/model/product_detail_model.dart';
import '../../Home/controller/home_api.dart';
import '../../Home/model/home_model.dart';
import '../model/search_model.dart';
import 'api.dart';

class SearchScreenController extends ChangeNotifier {
  // HomeController homeController = HomeController();

  SearchApi searchApi = SearchApi();
  // ApiService apiService = ApiService();

  TextEditingController searchController = TextEditingController();

  List<int> favoriteIndex = [];

  // List<int> selectedBrands = [];
  int? sortIndex;
  int? ratingIndex;
  double discreteValue = 0.0;
  RangeValues values = const RangeValues(0, 5000);
  List<Products> searchProduct = [];

  // List<Products>? products;

  saveController(value) {
    searchController.text = value;
    notifyListeners();
  }

  bool searchProductLoading = false;
  String perPage = "10";
  int? totalShopProduct;

  bool productLoading = false;
int isloader=0;

  Future<dynamic> addWishlistProduct1(id,ValueSetter<bool>onResponse,sid) async {

    productLoading = true;
    final data = await searchApi.addWishlistApi(id.toString(),sid);
    if (data != null) {
      var message = data['msg'];
      final datas = ApplyFilterModel(
          filterBrand: selectedBrands,
          filterMinPrice: priceLow,
          filterMaxPrice: priceHigh,
          filterSortBy: sortby ,
          filterDiscount: discounts );
      isloader =1;
      searchedProduct(searchType,
        searchController.text,
        datas,
        (value) {notifyListeners();},
      );

      onResponse(true);

      productLoading = false;

      showSnackBar(
          snackPosition: SnackPosition.TOP,
          title: "Success",
          description: message);
      notifyListeners();
    }
  }

  int searchType = 0;
  List<int> selectedBrands = [];
  String priceLow = "";
  String priceHigh = "";
  String sortby = "";
  String discounts = "0";


  Future<SearchModel?> searchedProduct(
      type, value, ApplyFilterModel? data, ValueSetter<bool> onResponse) async {
    searchType = type;
    searchProductLoading = true;

    if (searchController.text.isEmpty) {
      searchProduct.clear();
      searchProductLoading = false;
      notifyListeners();
      return null;
    }

    final productCount = int.parse(perPage) * pageNo1;

    final searchData = await searchApi.getSearchProductApi(
      searchType,
      value,
      productCount.toString(),
      data!,
    );

    if (searchData != null) {
      final newProducts = searchData.result?.products?.data ?? [];

      if (pageNo1 == 1) {
        if (newProducts.isNotEmpty) {
          searchProduct = newProducts;
        } else {
          // Keep previous data
          print("No new data on page 1. Keeping old data.");
        }
      } else {
        searchProduct.addAll(newProducts);
      }

      perPage = searchData.result?.perPage ?? "10";
      priceLow = searchData.result?.mip ?? "0";
      priceHigh = searchData.result?.map ?? "1000000";
      sortby = searchData.result?.sorting ?? "default";
      totalShopProduct = searchData.result?.products?.total ?? 0;

      print("pageNo1: $pageNo1");
      print("New products fetched: ${newProducts.length}");
      print("Total current: ${searchProduct.length}");

      onResponse(true);
    }

    searchProductLoading = false;
    notifyListeners();
    return null;
  }


  bool isFetching = false;
  bool pageLoader = false;
  int pageNo1 = 1;

  setPage() {
    pageNo1++;

    notifyListeners();
  }

  setValue(feched, load) {
    isFetching = feched;
    pageLoader = load;
    notifyListeners();
  }

  setfavIndex(value) {
    favoriteIndex.add(value);
    notifyListeners();
  }

  setSortIndex(value) {
    sortIndex = value;
    notifyListeners();
  }

  back() {
    searchController.clear();
    searchProduct.clear();
    totalShopProduct = null;
    values = const RangeValues(0, 5000);
    setSortIndex(null);
    setRatingIndex(null);
    pageNo1 = 1;
    // setfavIndex(null);
    notifyListeners();
  }

  setRatingIndex(value) {
    ratingIndex = value;
    notifyListeners();
  }

  List<String> rate = [
    "50",
    "40",
    "30",
    "20",
    "10",
  ];

  List<String> sort = [
    "Popular",
    "Most Popular",
    "Price High",
    "Price Low",
    "New Arrival",
  ];
}
