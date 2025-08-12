import '../app/Home/model/home_model.dart';

/// Server Url

// const String serverURL = "https://utkarsh.jaipurdreams.com/";   // demo
const String serverURL = "https://utkarshkisan.com/";     //live
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
const String registerURL = "${baseURL}vendor/auth/register";
const String loginURL = "${baseURL}vendor/auth/login";
const String getOtpURL = "${baseURL}vendor/get-otp";
const String verifyOtpURL = "${baseURL}vendor/mobile-login";
const String forgotPasswordURL = "${baseURL}vendor/password/email";

///Home Url
const String homeURL = "${baseURL}vendor/home";
const String cateURL = "${baseURL}category/";
const String shopProductURL = "${baseURL}shop";
const String productDetailURL = "${baseURL}vendor/product-detail/";
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

//kisan dashboard

const String dashboard = "${baseURL}vendor/dashboard";
const String variant = "${baseURL}vendor/variant";
const String toggleStockStatus = "${baseURL}vendor/variant/stock-status-toggle";
const String updateVariant = "${baseURL}vendor/variant/update";
const String editVariant = "${baseURL}vendor/edit-variant";
const String addVariant = "${baseURL}vendor/variant/create";
const String orderListVander = "${baseURL}vendor/order-list";
const String orderDetailsVander = "${baseURL}vendor/order-detail";
const String profileUpdateVedor = "${baseURL}vendor/profile/update";
const String profileGETVedor = "${baseURL}vendor/profile";
const String productVendor = "${baseURL}vedndor-products";
const String orderAcceptByVandar = "${baseURL}vendor/order-accept";
const String orderRejectByVandar = "${baseURL}vendor/order-reject";
const String ordersForVandor = "${baseURL}vendor/vendor-orders";
const String addQuantityVandor = "${baseURL}vendor/add-quantity";
const String vandorHistoryByProduct = "${baseURL}vendor/product-order-history";
const String productHistoryById = "${baseURL}vendor/product-history";

const String paymentComplete = "${baseURL}completepayment";
const String subscritionPakageList = "${baseURL}package-list";

const String mySubscripedPakage = "${baseURL}vendor/my-package";
const String subscriptionPaymentComplete = "${baseURL}vendor/completepayment";






List<dynamic> globalProduct = [];
List<Brands> cate = [];
String dollarRate = "";
