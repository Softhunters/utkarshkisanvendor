import 'package:country_picker/country_picker.dart';
import 'package:flutter/services.dart';
import 'package:utkrashvendor/app/Auth/view/otp_verify.dart';
import 'package:utkrashvendor/app/Auth/view_model/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import '../../../common_widgets/app_colors.dart';
import '../../../widgets/app_button_widget.dart';

class PhoneLogin extends StatelessWidget {
  const PhoneLogin({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return Consumer<AuthController>(
      builder: (context, controller, child) => Scaffold(
        resizeToAvoidBottomInset: true,
        // appBar: AppBar(),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: GestureDetector(
                                  onTap: () {
                                    controller.otpSent=false;
                                    controller.mobileNumberController.clear();
                                    // controller.otpController.clear();
                                    controller.errorController?.close();

                                    // Get.to(TabScreen(index: 0));
                                    Get.back();
                                  },
                                  child: const Icon(Icons.arrow_back_ios_new))),
                          Expanded(
                            flex: 15,
                            child: Center(
                              child: Text(
                                "Welcome Back!",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .copyWith(color: Colors.black),
                              ),
                            ),
                          ),
                          const Expanded(flex: 1, child: SizedBox())
                        ],
                      ),
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
                            ?.copyWith(
                                fontSize: 32, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: height * .06,
                      ),

                      SizedBox(
                        height: height * .002,
                      ),

                      SizedBox(height: height * .015),

                      Form(
                        key: controller.mobileFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Mobile No.",
                                style: Theme.of(context)
                                    .textTheme.headlineSmall!
                                    .copyWith(color: Colors.black)),
                            SizedBox(height: height * .015),
                            TextFormField(
                              controller: controller.mobileNumberController,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                // contentPadding: EdgeInsets.all(10.0),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(30)),
                                fillColor: AppColors.textFieldColor,
                                filled: true,
                                prefixIcon: GestureDetector(
                                  onTap: () {
                                    showCountryPicker(
                                      context: context,
                                      countryListTheme:
                                          const CountryListThemeData(
                                        textStyle: TextStyle(
                                            fontSize: 16,
                                            color: Colors.blueGrey),
                                        //Optional. Sets the border radius for the bottomsheet.
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20.0),
                                          topRight: Radius.circular(20.0),
                                        ),
                                        inputDecoration: InputDecoration(
                                          labelText: 'Search',
                                          hintText: 'Start typing to search',
                                          hintStyle:
                                              TextStyle(color: Colors.black),
                                          prefixIcon: Icon(Icons.search),
                                          border: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      onSelect: (Country count) {
                                        controller.updateCountry(count);
                                      },
                                    );
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                        border: Border(
                                      right: BorderSide.none,
                                    )),
                                    height: 45.0,
                                    width: 75.0,
                                    margin: const EdgeInsets.only(
                                        right: 10.0,
                                        bottom: 3.0,
                                        top: 3.0,
                                        left: 3.0),
                                    padding: const EdgeInsets.all(3.0),
                                    child: Row(
                                      children: [
                                        // CountryPickerUtils.getDefaultFlagImage(country),
                                        Text(
                                            "${controller.countrys.flagEmoji} + ${controller.countrys.phoneCode}",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal)),
                                        // SizedBox(
                                        //   width: 8.0,
                                        // ),
                                        // Text(
                                        //   "$_selectedCountryFlag +$_selectedCountryCode",
                                        //   textAlign: TextAlign.center,
                                        //   style: const TextStyle(
                                        //       color: Colors.black,
                                        //       fontSize: 15,
                                        //       fontWeight: FontWeight.normal),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),

                                hintText: 'Enter mobile number',
                              ),

                              maxLines: 1,
                              maxLength: 10,
                              // focusNode: authProvider.loginPass,
                              textAlign: TextAlign.start,
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

                            /// if send otp
                            // if (controller.otpSent == true)

                          ],
                        ),
                      ),
                      SizedBox(height: height * .07),

                      /// Otp sent button
                      // if (controller.otpSent == false)
                        Center(
                          child: AppButton(
                            width: width,
                            height: 50,
                            title: "SEND OTP",
                            onTap: () {

                              if(!controller.mobileFormKey.currentState!.validate()){
                                return;
                              }else {
                              controller.otpSend(

                                (value) {

                                  if (value) {
                                    Get.to(()=>OtpVerification());
                                  }
                                },
                              );
                            }
                          },
                          ),
                        ),
                      const SizedBox(
                        height: 15,
                      ),


                      SizedBox(
                        height: height * .19,
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }


}
