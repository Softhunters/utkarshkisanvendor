import 'package:utkrashvendor/app/CartSection/Controller/cart_api.dart';
import 'package:flutter/material.dart';

import '../../Payment/View/payment_screen.dart';
import '../Model/cart_model.dart';
import '../Model/check_out_model.dart';
import '../Model/coupon_model.dart';

class CartController extends ChangeNotifier {
  CartApi cartApi = CartApi();
  bool isSelected = false;
  TextEditingController searchController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController promoCodeController = TextEditingController();

  Map<String, dynamic>? selectedShip;

  Map<String, dynamic>? selectedAddress;
  Map<String, dynamic>? selectedPaymentMethod;

  List<CartData> cartData = [];

  bool cartLoading = false;
  double cartTotal = 0;

  Future<CartModel?> getCartDAta() async {
    cartLoading = true;
    cartTotal = 0;
    notifyListeners(); // Optional: If you want to show a loading indicator

    final result = await cartApi.getCart();
    if (result != null) {
      cartData = result.result?.cart ?? [];

      // Reset before summing
      cartTotal = 0;

      for (var i = 0; i < cartData.length; i++) {
        final price = double.tryParse(cartData[i].price ?? "0.0") ?? 0.0;
        final quantity = int.tryParse(cartData[i].quantity ?? "0") ?? 0;



        cartTotal += price * quantity;
      }



      cartLoading = false;
      notifyListeners();
    }
  }

  List<Cart> checkOutProduct = [];
  Addresss? checkOutAddress;
  String taxvalue = "0.0";
  String subtotal = "0.0";
  String totalamount = "0.0";
  String shippingcost = "0.0";

  Future<CheckOutModel?> getCheckOutData() async {
    cartLoading = true;
    // cartTotal = 0;
    final result = await cartApi.getCheckOut();

    if (result != null) {
      checkOutProduct = result.result?.cart ?? [];
      checkOutAddress = result.result?.addresss;
      taxvalue = result.result?.taxvalue ?? "0.0";
      subtotal = result.result?.subtotal ?? "0";
      totalamount = result.result?.totalamount ?? "0.0";
      shippingcost = result.result?.shippingcost ?? "0";
      // for(var i = 0; i < cartData.length; i++){
      //   cartTotal  = cartTotal +  (double.parse(cartData[i].price ??"0.0")*int.parse(cartData[i].quantity ??"0"));
      //   notifyListeners();
      // }
      cartLoading = false;
      notifyListeners();
    }
  }

  Future<CartModel?> addCartDAta(productId, int? quantity,
      ValueSetter<bool> onResponse, String sId) async {

    cartLoading = true;
    final result = await cartApi.addCart(productId, quantity, sId);

    if (result != null) {
      getCartDAta();
      onResponse(true);

      cartLoading = false;
      notifyListeners();
    }
  }

  Map<int, int> sellerQuantities = {};

  void initSellerQuantities(List<dynamic> sellers) {
    for (var seller in sellers) {
      int id = seller.vendorId ?? 0;
      sellerQuantities[id] = 1;
    }
  }

  void incrementQty(int vendorId) {
    sellerQuantities[vendorId] = (sellerQuantities[vendorId] ?? 1) + 1;
    notifyListeners();
  }

  void decrementQty(int vendorId) {
    if ((sellerQuantities[vendorId] ?? 1) > 1) {
      sellerQuantities[vendorId] = (sellerQuantities[vendorId] ?? 1) - 1;
      notifyListeners();
    }
  }

  int getQty(int vendorId) {
    return sellerQuantities[vendorId] ?? 1;
  }

  Future<CartModel?> clearCartDAta() async {
    cartLoading = true;
    final result = await cartApi.clearCart();
    if (result != null) {
      getCartDAta();
      // onResponse(true);

      cartLoading = false;
      notifyListeners();
    }
  }

  List<Coupons> promoList = [];
  bool isPromoLoading = false;
  bool applyPromoLoading = false;

  Future<CouponModel?> getPromoCode() async {
    isPromoLoading = true;

    final result = await cartApi.getCoupon();
    if (result != null) {
      promoList = result.result?.coupons ?? [];
      isPromoLoading = false;
      notifyListeners();
    }
  }

  Coupons? selectedCoupon;
  String appliedCouponValue = "0.0";

  Future<ApplyCouponModel?> applyPromoCode(
      String totalAmount, String subTotal, String couponCode) async {
    applyPromoLoading = true;

    final result = await cartApi.applyCoupon(totalAmount, subTotal, couponCode);
    if (result != null) {
      searchController.text = result.result?.coupondata?.code ?? "";
      selectedCoupon = result.result?.coupondata;
      appliedCouponValue = result.result?.discount ?? "0";
      // getCheckOutData();
      applyPromoLoading = false;
      notifyListeners();
    }
  }

  double totalCheckOutValue = 0.0;

  double checkOutvalue(total) {
    totalCheckOutValue = total - double.parse(appliedCouponValue);
    return totalCheckOutValue;
  }

  updateShippingValue(value) {
    selectedShip = value;
    notifyListeners();
  }

  selectAddress(value) {
    selectedAddress = value;
    notifyListeners();
  }

  updatePaymentMethodValue(value) {
    selectedPaymentMethod = value;
    notifyListeners();
  }

  saveController(value) {
    searchController.text = value;
    notifyListeners();
  }

  bool changeIndex = false;

  setvalue(value) {
    changeIndex = value;
    notifyListeners();
  }

  // bool isSelectedCoupon = false;
  //
  // setCouponValue(value) {
  //   isSelectedCoupon = value;
  //   notifyListeners();
  // }

  // int count = 0;

  bool isCartLoading = false;

  saveCartLoad(value) {
    isCartLoading = value;
    notifyListeners();
  }

  int? selectedIndex;
  String coupanCode = "";

  saveIndex(value, couponCode) async {
    selectedIndex = value;
    coupanCode = couponCode;
    notifyListeners();
  }

  bool isSelectedIndex = false;

  // double discountAmount = 0.0;
  // double calculateDiscount(double total, String? type, String? discount) {
  //   if (type == "1") {
  //     // Percentage-based discount
  //     discountAmount =(total * double.parse(discount ??"0") / 100).clamp(0.0, total);
  //     return discountAmount;
  //   } else if (type == "2") {
  //     // Flat discount
  //     discountAmount= double.parse(discount ??"0").clamp(0.0, total);
  //     return discountAmount;
  //   } else {
  //     // No discount for other types
  //     return 0;
  //   }
  // }

  List<Map<String, dynamic>> shippingType = [
    {
      "name": "Economy",
      "isSelected": false,
      "detail": "10-12 Days",
      "price": 0,
      "image": "assets/images/1_ship.png"
    },
    {
      "name": "Regular",
      "isSelected": false,
      "detail": "7-8 Days",
      "price": 49,
      "image": "assets/images/1_ship.png"
    },
    // {
    //   "name": "Cargo",
    //   "isSelected": false,
    //   "detail": "10-12 Days",
    //   "price": 49,
    //   "image": "assets/images/3_ship.png"
    // },
    {
      "name": "Express",
      "isSelected": false,
      "detail": "2-3 Days",
      "price": 99,
      "image": "assets/images/delivery.png"
    },
  ];

  List<Map<String, dynamic>> paymentMethod = [
    // {
    //   "name": "My Wallet",
    //   "isSelected": false,
    //   "type": 1,
    //   "image": "assets/images/my_wallet.png"
    // },
    // {
    //   "name": "PayPal",
    //   "isSelected": false,
    //   "type": 0,
    //   "image": "assets/images/paypal.png"
    // },
    // {
    //   "name": "Google Pay",
    //   "isSelected": false,
    //   "type": 0,
    //   "image": "assets/images/google.png"
    // },
    // {
    //   "name": "Apple Pay",
    //   "isSelected": false,
    //   "type": 0,
    //   "image": "assets/images/apple.png"
    // },
    // {
    //   "name": ".... .... .... 1234",
    //   "isSelected": false,
    //   "type": 0,
    //   "image": "assets/images/card.png"
    // },
    {
      "name": "Cash on delivery",
      "isSelected": false,
      "type": 1,
      "image": "assets/images/cod.png"
    },
  ];

  String? orderNumber;
  bool loadingPayment = false;

  int? checkIndex;

  setIndex(value) {
    checkIndex = value;
    notifyListeners();
  }

  makePayment(PaymentModel data, ValueSetter<bool> onResponse) async {
    loadingPayment = true;
    final result = await cartApi.makePaymentApi(data);
    if (result != null) {
      orderNumber = result["result"]["order_number"].toString();
      searchController.clear();
      appliedCouponValue = "0.0";
      loadingPayment = false;
      onResponse(true);
      notifyListeners();
    } else {
      loadingPayment = false;
      onResponse(false);
      notifyListeners();
    }
  }
}
