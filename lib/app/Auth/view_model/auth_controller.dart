import 'dart:async';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../config/shared_prif.dart';
import '../../CartSection/Model/check_out_model.dart';
import '../../Home/controller/home_api.dart';
import '../modal/my_package_response.dart';
import '../modal/subscription_pakage_response.dart';
import '../view/register_screen.dart';
import 'auth_api.dart';

class AuthController extends ChangeNotifier {
  AuthApi authApi = AuthApi();
  TextEditingController forgotPasswordController = TextEditingController();
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();

  TextEditingController mobileNumberController = TextEditingController();
  String selectedCountryCode = "+91";
  // TextEditingController otpController = TextEditingController();
  final mobileFormKey = GlobalKey<FormState>();
  // final otpFormKey = GlobalKey<FormState>();
  StreamController<ErrorAnimationType>? errorController;
  String currentText = "";
  String storedOTP = "";
  Timer? _timer;
  int secondsRemaining = 60;
  bool otpSent = false;
  List<PackageList> subscriptionPakageList = [];

 var mypackage = MyPakckgeResponse();

  String? selectedPname;
  int? selectedId;


  void selectPackage(String pname, int id) {
    selectedPname = pname;
    selectedId = id;
    notifyListeners();
  }


  Timer? otpTimer;

  void startOtpTimer() {
    secondsRemaining = 60;
    otpTimer?.cancel();
    otpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining > 0) {
        secondsRemaining--;
      } else {
        timer.cancel();
      }
      notifyListeners();
    });
  }

  void cancelOtpTimer() {
    otpTimer?.cancel();
  }

  Country countrys = Country(
      geographic: true,
      phoneCode: "91",
      countryCode: 'IN',
      e164Sc: 1,
      level: 1,
      name: 'India',
      example: '',
      displayName: '',
      displayNameNoCountryCode: '',
      e164Key: '');

  updateCountry(value) {
    selectedCountryCode = value.phoneCode;
    countrys = value;
    notifyListeners();
  }

  setCurrentText(value){
    currentText =value;
    notifyListeners();
  }

   void otpSend(ValueSetter<bool> onResponse)async{
     secondsRemaining = 60;
    final result = await authApi.otpSending(mobileNumberController.text);
    if(result==true){
      otpSent = true;
      onResponse(true);
      errorController = StreamController<ErrorAnimationType>();
      // startTimer();
      notifyListeners();
    }else{
      onResponse(false);
      notifyListeners();
    }
  }
  // void startTimer() {
  //   _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
  //
  //       if (secondsRemaining > 0) {
  //         secondsRemaining--;
  //         // notifyListeners();
  //       } else {
  //         _timer?.cancel();
  //         // notifyListeners();
  //       }
  //
  //   });
  //   notifyListeners();
  // }


  void otpVerify(ValueSetter<bool> onResponse)async{

    final result = await authApi.otpVerifyApi(mobileNumberController.text,currentText);
    if(result!=null){
      SharedStorage.localStorage?.setString("token", result['token']);
      SharedStorage.localStorage?.setBool("isBuySubscription", result['isSubscriptionBuy']);
      print("mnmnmnmnmmn ${result['isSubscriptionBuy']}");
      otpSent = false;
      mobileNumberController.clear();
      // otpController.clear();
      onResponse(true);
      errorController!.close();
      _timer?.cancel();
      // dispose();
      notifyListeners();
    }else{
      onResponse(false);

      notifyListeners();
    }
  }


  // @override
  // void dispose() {
  //   errorController!.close();
  //   _timer?.cancel();
  //   super.dispose();
  // }

  FocusNode loginEmail = FocusNode();
  FocusNode loginPass = FocusNode();

  FocusNode name = FocusNode();
  FocusNode email = FocusNode();
  FocusNode phone = FocusNode();
  FocusNode password = FocusNode();
  FocusNode confmPassword = FocusNode();

  bool loginObscureText = true;

  bool regisObscureText = true;
  bool regisConObscureText = true;


  Future<dynamic> registerUser(
      UserModel data1, ValueSetter<bool> onResponse) async {
    final data = await authApi.userRegister(data1);
    print("iiiiii ${data}");
    if (data != null) {
      SharedStorage.localStorage?.setString("token", data['token']);
      onResponse(true);

      notifyListeners();
    } else {
      onResponse(false);
      notifyListeners();
    }
  }

  ApiService apiService = ApiService();

  Future<dynamic> loginUser(
      UserModel data1, ValueSetter<bool> onResponse) async {
    final data = await authApi.userLogin(data1);
    if (data != null) {
      SharedStorage.localStorage?.setString("token", data['token']);
      SharedStorage.localStorage?.setBool("isBuySubscription", data['isSubscriptionBuy']);
      onResponse(true);
      notifyListeners();
    } else {
      onResponse(false);
      notifyListeners();
    }
  }



  Future<void> subscriptionPakageModalDetails(
       ) async {
    final data = await authApi.getSubscriptionPakageList();
    if (data != null) {
      subscriptionPakageList = data.result?.packageList??[];
      notifyListeners();
    } else {
      notifyListeners();
    }
  }


  Future<void> myPakageModalDetails(
      ) async {
    final data = await authApi.getMyPackageList();
    print("uuuuu ${data?.result?.upToDate}");
    if (data != null) {
      mypackage = data;
      notifyListeners();
    } else {
      notifyListeners();
    }
  }






  bool isChecked = false;
  final storage = const FlutterSecureStorage();

  checkValue(value) {
    isChecked = value;
    notifyListeners();
  }

  void storeCredentials(String username, String password) async {
    await storage.write(key: 'username', value: username);
    await storage.write(key: 'password', value: password);
  }

  void deleteCredentials(String username, String password) async {
    await storage.delete(key: 'username');
    await storage.delete(
      key: 'password',
    );
  }

  getCredentials() async {
    String? username = await storage.read(key: 'username');
    String? password = await storage.read(key: 'password');

    if (username != null && password != null) {
      loginEmailController.text = username;
      loginPasswordController.text = password;
      isChecked = true;

      notifyListeners();
    } else {
      loginEmailController.text = '';
      loginPasswordController.text = '';
      notifyListeners();
    }
  }

  Future<void> forgotPassword(
      String email,
      ValueSetter<Map<String, dynamic>> onResponse,
      ) async {
    try {
      final res = await authApi.forgotPassword(email); // this should return bool or a response

      if (res != null && res == true) {
        onResponse({
          "success": true,
          "message": "Password reset link sent to your email",
        });
      } else {
        onResponse({
          "success": false,
          "message": "Failed to send reset link",
        });
      }

      notifyListeners();
    } catch (e) {
      onResponse({
        "success": false,
        "message": "Something went wrong",
      });
    }
  }



  void someCleanupMethod() {

  }
}
