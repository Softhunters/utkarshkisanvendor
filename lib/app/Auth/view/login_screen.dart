import 'package:utkrashvendor/app/Auth/view/phone_login.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../view_model/auth_controller.dart';
import 'package:utkrashvendor/app/Auth/view/forgot_password.dart';
import 'package:utkrashvendor/app/Auth/view/register_screen.dart';
import 'package:utkrashvendor/common_widgets/app_strings.dart';
import 'package:utkrashvendor/config/shared_prif.dart';
import 'package:utkrashvendor/widgets/app_button_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/app_colors.dart';
import '../../bottom_bar/bottom_bar_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  bool validateEmail(String email) {
    // Regular expression for email validation
    final RegExp emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,3}$');

    return emailRegex.hasMatch(email);
  }

  @override
  void initState() {
    get();
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

    firebaseMessaging.getToken().then((String? token) async {
      if (token == null) {
      } else {
        var fcmToken = token;
        SharedStorage.localStorage?.setString("fcm_token", fcmToken ?? "");

      }
    }).catchError((error) {

    });
    super.initState();
  }

  get() {
    var authProvider = Provider.of<AuthController>(context, listen: false);
    authProvider.getCredentials();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    var authProvider = context.read<AuthController>();

    return Consumer<AuthController>(
      builder: (context, value, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: height * .02,
                    ),
                    Center(
                        child: Image.asset(
                      "assets/images/app_logo_large.png",
                      height: height * .15,
                    )),
                    SizedBox(
                      height: height * .03,
                    ),
                    Text(
                      "Login to your Account",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(fontSize: 32, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: height * .06,
                    ),
                    TextFormField(
                      controller: authProvider.loginEmailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        // contentPadding: EdgeInsets.all(10.0),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(30)),
                        fillColor: AppColors.textFieldColor,
                        filled: true,
                        prefixIcon: Icon(
                          Icons.mail,
                          color: AppColors.divideColor,
                        ),

                        hintText: 'Email',
                      ),
                      maxLines: 1,
                      focusNode: authProvider.loginEmail,
                      textAlign: TextAlign.start,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter email";
                        } else if (!validateEmail(value)) {
                          return "Please enter a valid email";
                        }
                      },
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    TextFormField(
                      controller: authProvider.loginPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: value.loginObscureText,
                      // Initially hides the password

                      decoration: InputDecoration(
                        // contentPadding: EdgeInsets.all(10.0),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(30)),
                        fillColor: AppColors.textFieldColor,
                        filled: true,
                        prefixIcon: const Icon(
                          Icons.lock_open,
                          color: AppColors.divideColor,
                        ),

                        hintText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            value.loginObscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            // Toggles the password visibility
                            setState(() {
                              value.loginObscureText = !value.loginObscureText;
                            });
                          },
                        ),
                      ),

                      maxLines: 1,
                      focusNode: authProvider.loginPass,
                      textAlign: TextAlign.start,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter password";
                        } else if (value.length < 8) {
                          return "Please enter atleast 8 digit";
                        }
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: authProvider.isChecked,
                            onChanged: (value) {
                              authProvider.checkValue(value);
                            },
                            activeColor: authProvider.isChecked
                                ? AppColors.primaryColor
                                : AppColors.primaryWhite,
                          ),
                          const Text(
                            "Remember Me",
                            style: TextStyle(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * .04,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: AppButton(
                        title: "Sign in",
                        onTap: () {
                          validate(value);
                          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomBarScreen(),));
                        },
                      ),
                    ),
                    SizedBox(
                      height: height * .01,
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            Get.to(()=>ForgotPasswordScreen());
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0,right: 8.0,left: 8.0),
                            child: Text("Forgot Password ?",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyLarge),
                          ),
                        )),
                    Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            Get.to(()=>PhoneLogin());
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Sign in with Phone",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyLarge),
                          ),
                        )),
                    Spacer(),
                    Center(
                      child: RichText(
                          text: TextSpan(
                              text: "Don’t have an account? ",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(color: AppColors.divideColor),
                              children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignupScreen(),
                                      ));
                                },
                              text: " Sign Up",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                      color: AppColors.primaryColor,
                                      fontSize: 14),
                            )
                          ])),
                    ),
                    SizedBox(
                      height: 5,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  validate(AuthController controller) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (controller.isChecked == true) {
      controller.storeCredentials(controller.loginEmailController.text,
          controller.loginPasswordController.text);
    } else {
      controller.deleteCredentials(controller.loginEmailController.text,
          controller.loginPasswordController.text);
    }
    final data = UserModel(
      email: controller.loginEmailController.text,
      password: controller.loginPasswordController.text,
    );

    controller.loginUser(data, (value) {
      if (value) {
        SharedStorage.localStorage?.setBool(AppStrings.isLogin, true);

        Get.offAll(
          const BottomBarScreen(
            index: 0,
            type: 0,
          ),
        );
      }
    });
  }
}
