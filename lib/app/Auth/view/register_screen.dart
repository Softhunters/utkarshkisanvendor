import 'package:utkrashvendor/app/Auth/view/login_screen.dart';
import 'package:utkrashvendor/widgets/app_button_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/app_colors.dart';
import '../../../common_widgets/app_strings.dart';
import '../../../config/shared_prif.dart';
import '../../bottom_bar/bottom_bar_screen.dart';
import '../view_model/auth_controller.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formKey = GlobalKey<FormState>();

  bool validateEmail(String email) {
    // Regular expression for email validation
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    // var authProvider = context.read<AuthController>();

    return Consumer<AuthController>(
      builder: (context, authProvider, child) => Scaffold(
        resizeToAvoidBottomInset: false,

        body:GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SafeArea(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: height * .02,
                    ),
                    Center(child: Image.asset("assets/images/app_logo_large.png",height: height*.1,)),

                    SizedBox(
                      height: height * .02,
                    ),
                    Text(
                      "Create your Account",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(fontSize: 34, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: height * .04,
                    ),
                    TextFormField(
                      controller: authProvider.nameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        // contentPadding: EdgeInsets.all(10.0),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(30)),
                        fillColor: AppColors.textFieldColor,
                        filled: true,
                        prefixIcon: const Icon(
                          Icons.person,
                          color: AppColors.divideColor,
                        ),
                        hintText: 'Name',
                      ),
                      maxLines: 1,
                      focusNode: authProvider.name,
                      textAlign: TextAlign.start,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter your User Name";
                        } else if (value.length < 4) {
                          return "please enter user name atleast 4 letter ";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    TextFormField(
                      controller: authProvider.emailController,
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
                      focusNode: authProvider.email,
                      textAlign: TextAlign.start,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter your Email Address";
                        } else if (!validateEmail(value)) {
                          return "please enter a valid email";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    TextFormField(
                      controller: authProvider.phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        // contentPadding: EdgeInsets.all(10.0),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(30)),
                        fillColor: AppColors.textFieldColor,
                        filled: true,
                        prefixIcon: Icon(
                          Icons.phone,
                          color: AppColors.divideColor,
                        ),

                        hintText: 'Phone',
                      ),
                     maxLines: 1,
                      maxLength: 10,
                      focusNode: authProvider.phone,
                      textAlign: TextAlign.start,
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return "Please Enter your number";
                      //   } else if (value.length != 10) {
                      //     return "please enter  atleast 10 digit  of phone number ";
                      //   } else {
                      //     return null;
                      //   }
                      // },

                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your phone number";
                        } else {
                          // Regular expression to match 10 digits
                          final RegExp phoneRegex = RegExp(r'^[0-9]{10}$');

                          if (!phoneRegex.hasMatch(value)) {
                            return "Please enter a valid 10-digit phone number";
                          } else {
                            return null;
                          }
                        }
                      },
                    ),

                    SizedBox(
                      height: height * .02,
                    ),
                    TextFormField(
                      controller: authProvider.passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: authProvider.regisObscureText,
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
                        suffixIcon: IconButton(
                          icon: Icon(
                            authProvider.regisObscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            // Toggles the password visibility
                            setState(() {
                              authProvider.regisObscureText = !authProvider.regisObscureText;
                            });
                          },
                        ),

                        hintText: 'Password',
                      ),
                     maxLines: 1,
                      focusNode: authProvider.password,
                      textAlign: TextAlign.start,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter your Password";
                        } else if (value.length < 8) {
                          return "please enter atleast 8 digit of password ";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    TextFormField(
                      controller: authProvider.cPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: authProvider.regisConObscureText,
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
                        suffixIcon: IconButton(
                          icon: Icon(
                            authProvider.regisConObscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            // Toggles the password visibility
                            setState(() {
                              authProvider.regisConObscureText = !authProvider.regisConObscureText;
                            });
                          },
                        ),

                        hintText: 'Confirm Password',
                      ),
                     maxLines: 1,
                      focusNode: authProvider.confmPassword,
                      textAlign: TextAlign.start,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please confirm your password";
                        } else if (value !=
                            authProvider.passwordController.text) {
                          return "Password not matched";
                        } else {
                          return null;
                        }
                      },
                    ),

                    SizedBox(
                      height: height * .04,
                    ),
                    AppButton(
                      title: "Sign up",
                      onTap: () {
                        validate(authProvider);
                      },
                    ),
                    SizedBox(
                      height: height * .01,
                    ),

                    SizedBox(
                      height: height * .01,
                    ),

                    // Spacer(),
                    Center(
                      child: RichText(
                          text: TextSpan(
                              text: "You have an account? ",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(color: AppColors.divideColor),
                              children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ));
                                },
                              text: " Sign in",
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
    if (!formKey.currentState!.validate()) {
      return;
    }
    final data = UserModel(
      userName: controller.nameController.text,
      email: controller.emailController.text,
      phone: controller.phoneController.text,
      password: controller.cPasswordController.text,
    );

    controller.registerUser(data,(value){
      if(value){

        SharedStorage.localStorage?.setBool(AppStrings.isLogin, true);
        controller.nameController.clear();
        controller.emailController.clear();
        controller.phoneController.clear();
        controller.passwordController.clear();
        controller.cPasswordController.clear();
        Get.offAll(const BottomBarScreen(index: 0,type: 0,),);
      }
    });
  }
}

class UserModel {
  String? userName;
  String? email;
  String? phone;
  String? password;

  UserModel({this.userName, this.phone, this.email, this.password});
}
