import 'package:e_commerce/common_widgets/urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common_widgets/app_strings.dart';
import '../../../common_widgets/snack_bar.dart';
import '../../../config/shared_prif.dart';
import '../../Auth/view/login_screen.dart';
import '../View/add_address_screen.dart';
import '../model/all_address_model.dart';
import '../model/contact_us_model.dart';
import '../model/country_model.dart';
import 'api.dart';

enum AddressType { home, office, other }

class ProfileController extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController optionalMobileController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController street2Controller = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController pinController = TextEditingController();


  final FocusNode name = FocusNode();
  final FocusNode mobile = FocusNode();
  final FocusNode mobile2 = FocusNode();
  final FocusNode street = FocusNode();
  final FocusNode street2 = FocusNode();
  final FocusNode landmark = FocusNode();
  final FocusNode zip = FocusNode();
  final FocusNode countrys = FocusNode();





  List<Addresss> addressList = [];
  int addressLength = 0;
  final formkey = GlobalKey<FormState>();

  List<Addresss> defaultAddress = [];

  Future<AllAddressModel?> getAllAddress() async {
    // print("call add");
    // addressList.clear();
    var data = await profileApi.getAddress();
    if (data != null) {
      addressList = data.addresss ?? [];
      addressLength = addressList.length;
      defaultAddress = addressList
          .where((element) => element.defaultAddress == "1")
          .toList();
      notifyListeners();
    }
  }

  ContactData? contactData;
  bool contactLoading = false;

   getContactDetail() async {
    contactLoading= true;
    var data = await profileApi.getContactDetail();
    if (data != null) {
     contactData = data.result;
     dollarRate = data.dollarRate ?? "";
     contactLoading =false;
      notifyListeners();
    }
  }
  //
  Future<void> makePhoneCall(Uri launchUri) async {

    await launchUrl(launchUri);
  }

  Future<void> shareApp() async {
    // Set the app link and the message to be shared
    const String appLink = 'https://play.google.com/store/apps/details?id=com.example.myapp';
    const String message = 'Check out my new app: $appLink';

    // Share the app link and message using the share dialog
    await FlutterShare.share(title: 'Share App', text: message, linkUrl: appLink);
  }

  Future<bool?> logoutApp() async {
    // print("call add");
    // addressList.clear();
    var data = await profileApi.logout();
    if (data ==true) {
      var deviceToken = SharedStorage.localStorage?.getString("fcm_token") ?? "";
      await SharedStorage.localStorage?.clear();
      SharedStorage.localStorage?.setString("fcm_token", deviceToken ?? "");
      SharedStorage.localStorage?.setBool(AppStrings.isLogin, false);
      Get.offAll(LoginScreen());
     // onResonse(true);
      notifyListeners();
    }else{
      // onResonse(false);
      notifyListeners();
    }
  }

  saveAddress(AddressModel data, ValueSetter<bool> onResponse) async {
    bool addressData = await profileApi.addAndEditAddress(data);

    if (addressData != false) {
      nameController.clear();
      mobileController.clear();
      optionalMobileController.clear();
      streetController.clear();
      street2Controller.clear();
      landmarkController.clear();
      pinController.clear();
      selectedCountryId = null;
      selectedStateId = null;
      selectedCityId = null;
      isChecked = false;
      _addressType = AddressType.other;
      getAllAddress();

      onResponse(true);
    } else {
      onResponse(false);
    }
    notifyListeners();
    return null;
  }

  removeAddress(String id) async {
    print(id);
    bool addressData = await profileApi.deleteAddress(id);
    // print(addressData);
    if (addressData != false) {
      getAllAddress();
      notifyListeners();
    }

    return null;
  }

  makeDefaultAddress(
      String id, String status, ValueSetter<bool> onResponse) async {
    print(id);
    bool addressData = await profileApi.defaultAddress(id, status);

    if (addressData != false) {
      getAllAddress();
      onResponse(true);
      notifyListeners();
    } else {
      onResponse(false);
      notifyListeners();
    }

    return null;
  }

  /// Select Address type
  AddressType _addressType = AddressType.home;

  AddressType get addressType => _addressType;

  void setAddressType(AddressType type) {
    _addressType = type;
    notifyListeners();
  }

  /// make default address
  bool isChecked = false;

  checkValue(value) {
    isChecked = value;
    notifyListeners();
  }

  bool selectedAddressIndex = false;

  ProfileApi profileApi = ProfileApi();

  changeAddressIndex(value) {
    selectedAddressIndex = value;
    notifyListeners();
  }

  editAddress(data) {
    nameController.text = data.name ?? "";
    streetController.text = data.street ?? "";
    selectedcity = data.city ?? "";
    landmarkController.text = data.locality ?? "";
    pinController.text = data.pin.toString();
    notifyListeners();
  }

  /// Country

  List<Countries> countries = [];
  String? country;
  String? selectedCountryId;

  Future<dynamic> getCountry() async {
    final data = await profileApi.getCountryList();

    if (data != null) {
      countries = data.countries ?? [];
      notifyListeners();
    }
  }

  ///State
  List<States> stateList = [];
  States? selectedState;
  String? selectedStateId;

  Future<dynamic> getState(String countryId) async {
    final data = await profileApi.getState(countryId);

    if (data != null) {
      stateList = data.states ?? [];
      notifyListeners();
    }
  }

  /// City
  List<Cities> cityList = [];
  Cities? selectedcity;
  String? selectedCityId;

  Future<dynamic> getCity(String stateId) async {
    final data = await profileApi.getDistrict(stateId);

    if (data != null) {
      cityList = data.cities ?? [];
      print(cityList.length);
      notifyListeners();
    }
  }

  cityValueSave(
    id,
  ) {
    // selectedcity = name;
    selectedCityId = id;
    notifyListeners();
  }
}
