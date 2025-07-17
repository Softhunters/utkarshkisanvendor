import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/app_colors.dart';
import '../../../common_widgets/app_strings.dart';
import '../../../config/shared_prif.dart';
import '../../../widgets/app_button_widget.dart';
import '../../bottom_bar/bottom_bar_screen.dart';
import '../view_model/auth_controller.dart';

class OtpVerification extends StatefulWidget {
  final String? email;
  final int? indexx;

  const OtpVerification({Key? key, this.email, this.indexx}) : super(key: key);

  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  TextEditingController otpController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;

  final formKey1 = GlobalKey<FormState>();
  Timer? _timer;
  int _secondsRemaining = 60;

  String currentText = "";
  String storedOTP = "";
  AuthController? _authController;



  @override
  void initState() {
    super.initState();
    errorController = StreamController<ErrorAnimationType>();

    // Use controller timer
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = Provider.of<AuthController>(context, listen: false);
      controller.startOtpTimer();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Capture the reference to the ancestor here
    _authController = Provider.of<AuthController>(context);
  }

  @override
  void dispose() {
    errorController?.close();
    _authController?.cancelOtpTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return Consumer<AuthController>(
      builder: (context, controller, child) => Scaffold(
        appBar: AppBar(),
        body: Form(
          key: formKey1,
          child: Container(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("OTP Verification",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 10,
                ),
                Center(
                    child: Text(
                      "We sent you 6-digit OTP code to verify\nyour phone number",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w500),
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "OTP Code",
                              // style: AppTextStyle.reguler14text,
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10),
                              child: PinCodeTextField(
                                appContext: context,
                                pastedTextStyle: TextStyle(
                                  color: Colors.green.shade600,
                                  fontWeight: FontWeight.bold,
                                ),
                                length: 6,
                                blinkWhenObscuring: true,
                                animationType: AnimationType.fade,
                                textStyle: TextStyle(
                                  color: AppColors.primaryBlack
                                ),
                                pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(10),
                                  borderWidth: 1,
                                  fieldHeight: 45,
                                  fieldWidth: 45,
                                  selectedFillColor: AppColors.grey1.shade200,
                                  activeFillColor: AppColors.grey1.shade200,
                                  activeColor: AppColors.primaryColor,
                                  inactiveColor: AppColors.primaryBlack,
                                  disabledColor: AppColors.redColor,
                                  errorBorderColor: AppColors.redColor,
                                  inactiveFillColor: AppColors.grey1.shade200,
                                  selectedColor: AppColors.green,
                                ),
                                cursorColor: AppColors.primaryColor,
                                animationDuration:
                                const Duration(milliseconds: 300),
                                enableActiveFill: true,
                                errorAnimationController: errorController,
                                controller: otpController,
                                keyboardType: TextInputType.number,
                                autovalidateMode:
                                AutovalidateMode.disabled,
                                onCompleted: (v) {},
                                onChanged: (value) {

                                  // currentText =value;
                                  controller.setCurrentText(value);
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please Enter Otp Pin";
                                  } else if (value.length != 6) {
                                    return "Please enter Atleast 6 Digit";
                                  } else {
                                    return null;
                                  }
                                },
                                beforeTextPaste: (text) {
                                  return true;
                                },
                              )),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: AppButton(
                          width: width,
                          height: 50,
                          title: "Verify",
                          onTap: () {
                            if (!formKey1.currentState!.validate()) {
                              return;
                            }

                            controller.otpVerify(
                                  (value) {
                                if (value == true) {
                                  SharedStorage.localStorage?.setBool(
                                      AppStrings.isLogin, true);

                                  Get.offAll(
                                    const BottomBarScreen(
                                      index: 0,
                                      type: 0,
                                    ),
                                  );
                                } else {
                                  SharedStorage.localStorage?.setBool(
                                      AppStrings.isLogin, false);
                                }
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      if (controller.otpSent == true)
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Sec. ${controller.secondsRemaining} Remaining...',
                              style: const TextStyle(
                                  color: AppColors.primaryBlack,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13),
                            ),
                            if (controller.secondsRemaining == 0)
                              TextButton(
                                onPressed: () {
                                  controller.startOtpTimer();
                                  otpController.clear();
                                  controller.otpSend(
                                        (value) {},
                                  );
                                  // controller.sendOtpAgain(controller);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text(
                                    'Resend code',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.redColor,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
