import 'dart:async';
import 'dart:convert';
import 'package:currency_converter/currency.dart';
import 'package:e_commerce/app/CartSection/Controller/cart_api.dart';
import 'package:e_commerce/app/Home/controller/home_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:http/http.dart';
import '../../../common_widgets/app_colors.dart';
import '../../../common_widgets/snack_bar.dart';
import '../../../common_widgets/urls.dart';
import '../../../config/shared_prif.dart';
import '../../CategoryProduct/model/product_detail_model.dart';
import '../../Profile/model/profile_model.dart';
import '../../Wishlist/model/wishlist_model.dart';
import '../model/home_model.dart';
import 'package:currency_converter/currency_converter.dart';

class HomeController extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  TextEditingController referralCodeController = TextEditingController();

  ApiService apiService = ApiService();
  CartApi cartApi = CartApi();
  int itemIndex = 0;
  int apiType = 0;

  setApiType(value) {
    apiType = value;
    notifyListeners();
  }

  List<Subcategorys> categoryList = [];
  List<Subcategorys> subCategories = [];

  List<Products> featureProducts = [];
  List<Products> allProducts = [];
  List<Products> filterProducts = [];
  List<Brands> brands = [];
  List<String> sliders = [];
  List<Sliders> banner = [];

  List<Products> allShopProduct = [];

  bool isLoading = false;
  bool shopProductLoading = false;
  String perPage = "20";
  String perPage1 = "20";
  int? totalShopProduct;

  updateImageIndex(value) {
    itemIndex = value;
    notifyListeners();
  }

  bool catLoading = false;

  Future<dynamic> getShopProductData(type) async {
    if (type == 0) {
      shopProductLoading = true;
      subCategoryList.clear();
      cateProduct.clear();
    } else {
      catLoading = true;
    }
    final data =
        await apiService.getShopProductApi(pageNo1, int.parse(perPage));
    if (data != null) {
      allShopProduct = data.result!.products?.data ?? [];
      perPage = data.result?.perPage ?? "";
      totalShopProduct = data.result?.products?.total;
      catLoading = false;
      shopProductLoading = false;
      notifyListeners();
    }
  }

  List<Subcategorys> mixedList = [];

  /// Get all home data
  Future<HomeModel?> getHomeData(int a) async {
    if (a == 1 && apiType == 0) {
      isLoading = true;
      sliders.clear();
      mixedList.clear();
      // cate.clear();
      filterProducts.clear();
      featureProducts.clear();
    }
    // print("start");

    final homeData = await apiService.homeApi();
    if (homeData != null) {
      categoryList = homeData.result?.categorys ?? [];
      subCategories = homeData.result?.subcategorys ?? [];

      mixedList.addAll(categoryList);
      mixedList.addAll(subCategories);

      // print(categoryList.length);
      featureProducts = homeData.result?.fproducts ?? [];
      allProducts = homeData.result?.products ?? [];
      brands = homeData.result?.brands ?? [];
      banner = homeData.result?.banners ?? [];
      globalProduct = homeData.result?.products ?? [];
      isLoading = false;

      for (var i = 0; i < homeData.result!.sliders!.length; i++) {
        sliders.add(homeData.result!.sliders![i].images ?? "");
      }
      cate = homeData.result?.brands ?? [];

      getProfile();
      getWishlistProduct(1);
      notifyListeners();
    }
  }

  String userName = "";
  String myReferralCode = "";
  String referBy = "";

  /// Get User profile
  Future<ProfileModel?> getProfile() async {
    final data = await apiService.getProfile();
    if (data != null) {
      userName = data.result?.name ?? "";
      myReferralCode = data.result?.referralCode ?? "";
      await SharedStorage.instance.userDetail(
          username: data.result?.name ?? "",
          email: data.result?.email ?? "",
          phone: data.result?.phone ?? "");
      notifyListeners();
    }
  }

  applyReferral() async {
    final data =
        await apiService.applyReferralCodeApi(referralCodeController.text);
    if (data == true) {
      referralCodeController.clear();
      getProfile();
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

  List<Subcategorys> subCategoryList = [];
  List<Products> cateProduct = [];
  List<Products> subcateProduct = [];
  String categorySlug = "";

  // List<Subcategorys> subCateProduct = [];

  int pageNo2 = 1;
  int? totalCategoryProduct;
  bool cateLoading = false;
  bool cateScrollLoading = false;

  /// Get  category product
  Future<dynamic> getCategoryData(slug, int type) async {
    if (type == 0) {
      cateLoading = true;
    } else {
      cateScrollLoading = true;
    }

    subcateProduct.clear();
    final data =
        await apiService.getCategoriesApi(slug, pageNo2, int.parse(perPage1));
    if (data != null) {
      categorySlug = data.result!.category?.slug ?? "";
      subCategoryList = data.result?.subcategorys ?? [];
      cateProduct = data.result?.products?.data ?? [];
      print(cateProduct.length);
      // perPage1 = data.result?.products?.perPage ?? '10';
      totalCategoryProduct = data.result?.products?.total;

      cateLoading = false;
      cateScrollLoading = false;
      notifyListeners();
    }
  }

  Future<dynamic> getSubCategoryData(cateSlug, subCatId, type) async {
    if (type == 0) {
      isLoading = true;
      subCategoryList.clear();
    }else {
      cateScrollLoading = true;
    }

    final data = await apiService.getSubCategoriesApi(
        cateSlug.toString(), subCatId.toString());
    if (data != null) {
      print("data");
      subCategoryList = data.result?.subcategorys ?? [];
      subcateProduct = data.result?.products?.data ?? [];
      isLoading = false;
      cateScrollLoading = false;

      notifyListeners(); // Move this inside the if block
    }
  }

  Products? productDetail;
  List<dynamic> singleProductImages = [];
  List<Varaiants> variant = [];

  int? indexx;

  changePriceWithIndex(value) {
    indexx = value;
    notifyListeners();
  }

  List<Reviews> reviews = [];
  bool productLoading = false;
  bool productLoading1 = false;
  bool wproductLoading1 = false;

  String dSlug = "";

  saveProductDetailslug(value) {
    dSlug = value;
    notifyListeners();
  }

  /// get single product detail
  Future<ProductDetailModel?> getProductDetail(id, value) async {
    if (value == 0) {
      productLoading = true;
    }
    final data = await apiService.getProductDetailApi(id.toString());
    if (data != null) {
      productDetail = data.result?.product!;
      variant = data.result?.varaiants ?? [];
      reviews = data.result?.reviews ?? [];
      String? singleProductImages1 =
          "${data.result?.product?.image}${data.result?.product!.images}";
      singleProductImages = singleProductImages1.split(",") ?? [];
      productLoading = false;
      notifyListeners();
    }
  }

  /// Share Product
  Future<void> shareProduct(String link, String message) async {
    await FlutterShare.share(
      title: 'Share App',
      text: message,
      linkUrl: link,
    );
  }

  Future<void> shareApp(String code) async {
    http: //127.0.0.1:8000/uregisteor?rcode=BTYCfJ
    // Set the app link and the message to be shared
    final String appLink = '${serverURL}uregisteor?rcode=$code';
    final String message = 'Check out my new app: $appLink';
    print(appLink);
    // Share the app link and message using the share dialog
    await FlutterShare.share(
        title: 'Share App', text: message, linkUrl: appLink);
  }

  /// Add wishlist Item
  Future<dynamic> addWishlistProduct(id, screen) async {
    // productLoading1 = true;
    final data = await apiService.addWishlistApi(id.toString());
    if (data != null) {
      var message = data['msg'];

      screen == 1
          ? getHomeData(0)
          : screen == 2
              ? getWishlistProduct(1)
              : screen == 3
                  ? getShopProductData(1)
                  : screen == 0
                      ? getProductDetail(dSlug, 1)
                      : subCates == "null"
                          ? getCategoryData(cates, 1)
                          : getSubCategoryData(cates, subCates, 1);

      productLoading1 = false;
      getWishlistProduct(1);
      showSnackBar(
          snackPosition: SnackPosition.TOP,
          title: "Success",
          description: message);
      notifyListeners();
    }
  }

  /// Remove wishlist item
  Future<dynamic> deleteAllWishlistProduct() async {
    print("stat");
    productLoading = true;
    final data = await apiService.deleteWishlistApi();
    if (data != false) {
      getHomeData(0);
      getWishlistProduct(1);
      productLoading = false;
      notifyListeners();
    }
  }

  List<Wishlist> allWishListProducts = [];

  /// Get Wishlist product
  Future<WishlistModel?> getWishlistProduct(type) async {
    if (type == 0) {
      wproductLoading1 = true;
    }
    final data = await apiService.getWishlistApi();
    if (data != null) {
      allWishListProducts = data.result?.wishlist ?? [];
      wproductLoading1 = false;
      notifyListeners(); /**/
    }
  }

  /// Move product wishlist to Cart
  Future<WishlistModel?> moveToCart(
      String id, ValueSetter<bool> onResponse) async {
    productLoading = true;
    final data = await apiService.moveToCartApi(id);
    if (data != null) {
      getHomeData(0);
      getWishlistProduct(1);
      onResponse(true);
      // allWishListProducts = data.result?.wishlist ?? [];
      // print(allWishListProducts.length);
      productLoading = false;
      notifyListeners();
    }
  }

  /// Move Cart to wishlist
  Future<WishlistModel?> moveToWishlist(
    String id,
  ) async {
    productLoading = true;
    final data = await apiService.moveToWishlistApi(id);
    if (data != false) {
      getHomeData(0);
      getWishlistProduct(1);

      // allWishListProducts = data.result?.wishlist ?? [];
      // print(allWishListProducts.length);
      productLoading = false;
      notifyListeners();
    }
  }

  int? favoriteIndex;
  String cateFavoriteIndex = "null";
  int? selectedColorIndex;
  int? categoryIds;

  filterCateProduct(value) {
    categoryIds = value;
    filterProducts.clear();
    filterProducts = allShopProduct
        .where((element) => element.categoryId == "$value")
        .toList();
    print(filterProducts.length);
    notifyListeners();
  }

  bool isFetching = false;
  bool pageLoader = false;
  int pageNo1 = 1;

  setPage() {
    pageNo1++;
    notifyListeners();
  }

  setPage1() {
    pageNo2++;
    notifyListeners();
  }

  setValue(feched, load) {
    isFetching = feched;
    pageLoader = load;
    notifyListeners();
  }

  setFavIndex(
    value,
  ) {
    favoriteIndex = value;
    notifyListeners();
  }

  String cates = "";
  String subCates = "";

  setcatFavIndex(value, cate, subCate) {
    cateFavoriteIndex = value;
    cates = cate;
    subCates = subCate;
    notifyListeners();
  }

  setColorIndex(value) {
    selectedColorIndex = value;
    notifyListeners();
  }

  List<Color> colorList = [
    AppColors.purple,
    AppColors.blue,
    AppColors.blueGrey,
    AppColors.green,
    AppColors.yellow,
    AppColors.orange,
    AppColors.redColor,
    AppColors.white,
    AppColors.primaryBlack,
  ];

  int count = 1;

  updateCount(value) {
    count = value;
    notifyListeners();
  }
}

class CurrencyProvider with ChangeNotifier {
  // final CurrencyService _currencyService = CurrencyService();

  List<Currency> currencyList = [Currency.inr, Currency.usd];
  Currency? selectedCurrency;
  getCurrency(){
    selectedCurrency =  parseCurrency(SharedStorage.localStorage?.getString("currency"));
  }


  Currency? parseCurrency(String? currencyString) {
    if (currencyString == null) return null;
    switch (currencyString) {
      case 'Currency.inr':
        return Currency.inr;
      case 'Currency.usd':
        return Currency.usd;
      default:
        return null; // Handle unknown currency case
    }
  }



  void updateCurrency(Currency value, ValueSetter<bool> onResponse) {
    selectedCurrency = value;
    SharedStorage.localStorage?.setString("currency", selectedCurrency.toString());
    onResponse(true);
    notifyListeners();
  }

  Future<double> convertToUSD(double salePriceInINR) async {
    // double exchangeRate = await getExchangeRate();
    var result=  salePriceInINR / double.parse(dollarRate);
    // notifyListeners();
    return result;
  }
double? exchangeRate;


}

