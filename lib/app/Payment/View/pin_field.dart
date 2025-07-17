import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/app_colors.dart';
import '../../../constant/cons.dart';
import '../../../widgets/app_button_widget.dart';
import '../../CartSection/Controller/cart_controller.dart';

class PinFieldsScreen extends StatelessWidget {
  const PinFieldsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = ScreenUtils.getScreenSize(context);
    final orientation = MediaQuery.orientationOf(context);
    final layoutInfo = (screenSize, orientation);
    var isBigDevice = ScreenUtils.isBigDevice(screenSize);
    if (isBigDevice) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      });
    }
    CartController read = context.read<CartController>();
    CartController watch = context.watch<CartController>();

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: AppColors.textFieldColor,
        border: Border.all(color: AppColors.gery1Color),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      color: AppColors.textFieldColor,
      border: Border.all(color: AppColors.primaryColor),
      borderRadius: BorderRadius.circular(20),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: AppColors.textFieldColor,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              read.pinController.clear();
              Get.back();
            },
            child: const Icon(Icons.arrow_back)),
        title: Text("Enter Pin",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w500)),
        centerTitle: false,
        actions: const [

           SizedBox(
            width: 15,
          )
        ],
        elevation: 0,
        surfaceTintColor: AppColors.white,
      ),
      bottomNavigationBar: Card(
        surfaceTintColor: AppColors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
          child: AppButton(
            title: "Continue",
            onTap: () {
              read.saveCartLoad(true);

              openDialog(context,read,layoutInfo);
              read.saveCartLoad(false);
              // if(watch.selectedShip != null) {
              //
              // }else{
              //   showSnackBar(
              //       snackPosition: SnackPosition.BOTTOM,
              //       title: "Warning",
              //       description: "Please select a payment option");
              //
              // }
            },
          ),
        ),
      ),
      body: Visibility(
        visible: !watch.isCartLoading,
        replacement: Center(child: CircularProgressIndicator.adaptive(),),
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter your PIN to confirm payment",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 20,
                ),
                Pinput(
                  androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
                  obscureText: true,
                  controller: watch.pinController,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  validator: (s) {
                    return s?.length == 4 ? null : 'Pin is incorrect';
                  },
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                  onCompleted: (pin) {
                    if(pin=="2222") {

                    }

                    /// code of api
                  },
                )
              ],
            ),
          ),
        )),
      ),
    );
  }

  openDialog(context,read,layOutInfo) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              backgroundColor: AppColors.white,
              surfaceTintColor: AppColors.white,

              content: SingleChildScrollView(
                child: Container(
                  width: switch(layOutInfo){
                  (_,Orientation.landscape)=>MediaQuery.sizeOf(context).width*.4,_=> MediaQuery.sizeOf(context).width
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Text("Are You Sure !, remove this item from cart.",style: Theme.of(context).textTheme.bodyLarge,),
                      const SizedBox(height: 30,),
                      Container(
                        height: 150,
                        width: 150,
                        child: Image.asset("assets/images/cart_icon.png",fit: BoxFit.cover,),
                      ),
                      const SizedBox(height: 10,),
                      Text(
                        "Order Successful",
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10,),
                      Text(
                        "You have successfully made order",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 30,),
                      AppButton(title: "View Order", onTap: () {
                        read.saveCartLoad(false);
                        Get.back();
                      },),
                      const SizedBox(height: 15,),
                      AppButton(
                        bgColor: AppColors.gery1Color,
                        style: Theme.of(context).textTheme.bodyLarge,
                
                        title: "View E-Receipt", onTap: () {
                        read.saveCartLoad(false);
                      },),
                      const SizedBox(height: 20,),
                      // ElevatedButton(
                      //     onPressed: () {
                      //       setState(() {
                      //         Navigator.pop(context);
                      //       });
                      //     },
                      //     child: Text(
                      //       "View Order",
                      //       style: Theme.of(context).textTheme.titleSmall,
                      //     )),
                      // ElevatedButton(
                      //     onPressed: () async {
                      //       setState(() {
                      //         Navigator.pop(context);
                      //       });
                      //     },
                      //     child: Text(
                      //       "View E-Receipt",
                      //       style: Theme.of(context).textTheme.titleSmall,
                      //     ))
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
