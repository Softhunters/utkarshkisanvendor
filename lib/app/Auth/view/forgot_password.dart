import 'package:e_commerce/app/Auth/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/app_colors.dart';
import '../../../widgets/app_button_widget.dart';
import '../view_model/auth_controller.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  Widget returnLabel(title) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .labelLarge
          ?.copyWith(color: AppColors.primaryBlack),
    );
  }

  // TextEditingController email = TextEditingController();

  final _formKey1 = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var controller =Provider.of<AuthController>(context,listen: false);
    bool validateEmail(String email) {
      // Regular expression for email validation
      final RegExp emailRegex =
          RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,3}$');

      return emailRegex.hasMatch(email);
    }

    return Consumer<AuthController>(
      builder: (context, controller, child) => Scaffold(
        appBar: AppBar(),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Column(
            children: [

              Center(
                child: Image.asset(
                  "assets/images/splash_icon.png",
                  width: 150,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Reset Your Password',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      returnLabel('Enter Your Email Address'),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: controller.forgotPasswordController,
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
                        textAlign: TextAlign.start,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter email";
                          } else if (!validateEmail(value)) {
                            return "Please enter a valid email";
                          }
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      AppButton(
                        title: "Send Otp",
                        onTap: () {
                          validator(controller);
                          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomBarScreen(),));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  validator(AuthController controller) async {
    if (!_formKey1.currentState!.validate()) {
      return;
    }

    controller.forgotPassword(
      controller.forgotPasswordController.text,
      (value) {
        print(value);
        if (value == true) {
          openDialog(context);

          // Get.to(OtpVerification(email:  controller.forgotPasswordController.text,indexx: 0,));
          // Navigator.pushNamed(context, "/resetpassword");
        }
      },
    );
  }

  openDialog(
    BuildContext context,
  ) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              backgroundColor: AppColors.white,
              surfaceTintColor: AppColors.white,
              title: Text(
                "Email Sent",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              content: Text(
                "Please check your email inbox and change your password.",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              actions: [
                // ElevatedButton(
                //     onPressed: () {
                //       setState(() {
                //         Navigator.pop(context);
                //       });
                //     },
                //     child: Text(
                //       "No",
                //       style: Theme.of(context).textTheme.titleSmall,
                //     )),
                ElevatedButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      Get.offAll(LoginScreen());
                      // controller.deleteAllWishlistProduct();
                    },
                    child: Text(
                      "Ok",
                      style: Theme.of(context).textTheme.titleSmall,
                    ))
              ],
            );
          },
        );
      },
    );
  }
}
