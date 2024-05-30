

import '../app/Home/model/home_model.dart';

/// Server Url
// const String serverURL = "http://petshope.jaipurdreams.com/";
const String serverURL = "https://petshop.jaipurdreams.com/";
const String baseURL = "${serverURL}api/";


/// Image Urls
const String imageURL = "${serverURL}admin/product/feat/";
const String productListImageURL = "${serverURL}admin/product/";
const String sliderURL = "${serverURL}admin/slider/";
const String cateImageURL = "${serverURL}admin/category/icon/";
const String bannerURL = "${serverURL}admin/banner/";
const String brandURL = "${serverURL}admin/brand/";
const String reviewImageURL = "${serverURL}admin/review/";
const String adminLogoURL = "${serverURL}admin/logos/";


///Auth Url
const String registerURL = "${baseURL}auth/register";
const String loginURL = "${baseURL}auth/login";
const String getOtpURL = "${baseURL}get-otp";
const String verifyOtpURL = "${baseURL}mobile-login";
const String forgotPasswordURL = "${baseURL}password/email";


///Home Url
const String homeURL = "${baseURL}home";
const String cateURL = "${baseURL}category/";
const String shopProductURL = "${baseURL}shop";
const String productDetailURL = "${baseURL}product-detail/";
const String shareProductURL = "${serverURL}product-detail/";

/// Wishlist
const String addWishlistURL = "${baseURL}addwishlist/";
const String getWishlistURL = "${baseURL}getwishlist";
const String deleteAllWishlistURL = "${baseURL}clearwishlist";
const String getProfileURL = "${baseURL}profile";
const String applyReferralURL = "${baseURL}referral_code/";


///Brand
const String brandProductURL = "${baseURL}brand/";
const String searchProductURL = "${baseURL}search/";


/// Address
const String getCountryURL = "${baseURL}addaddress";
const String getStateURL = "${baseURL}getstates/";
const String getcityURL = "${baseURL}getcities/";
const String getAddressURL = "${baseURL}address";
const String getContactURL = "${baseURL}websetting";
const String saveAddressURL = "${baseURL}storeaddress";
const String deleteAddressURL = "${baseURL}delete-address/";
const String defaultAddressURL = "${baseURL}default-address/";

const String moveToCartURL = "${baseURL}movetocart/";
const String moveToWishlistURL = "${baseURL}movetowishlist/";

const String logoutURL = "${baseURL}logout";


/// Cart
const String getCartURL = "${baseURL}getcart";
const String addCartURL = "${baseURL}addcart/";
const String clearCartURL = "${baseURL}clearcart";
const String promoCodeURL = "${baseURL}promocode";
const String checkOutURL = "${baseURL}check-out";
const String applyCouponURL = "${baseURL}coupon-apply";
const String makeOrderURL = "${baseURL}order-place";


///order
const String orderURL = "${baseURL}orders";
const String orderDetailURL = "${baseURL}order_details/";
const String cancelOrderURL = "${baseURL}order-cancel/";
const String returnOrderURL = "${baseURL}order-return/";

///Wallet
const String walletURL = "${baseURL}wallet";

/// Review
const String addReviewURL = "${baseURL}add-review";




List<dynamic> globalProduct = [];
List<Brands> cate = [];
String dollarRate= "";