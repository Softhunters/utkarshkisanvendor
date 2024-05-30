import 'package:e_commerce/app/CartSection/Controller/cart_controller.dart';
import 'package:e_commerce/app/Wallet/Controller/wallets_controller.dart';
import 'package:e_commerce/app/bottom_bar/bottom_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/app_colors.dart';
import '../../../common_widgets/snack_bar.dart';
import '../../../constant/cons.dart';
import '../../../widgets/app_button_widget.dart';

class PaymentOptionScreen extends StatelessWidget {
  const PaymentOptionScreen({super.key});

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
    var walletProvider = Provider.of<WalletsController>(context,listen: false);

    return Consumer<CartController>(
      builder: (context, controller, child) =>Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                controller.selectedPaymentMethod =null;
                for (int i = 0; i < controller.paymentMethod.length; i++)
                {
                  controller.paymentMethod[i]["isSelected"] = false;
                }
                Get.back();
              },
              child: const Icon(Icons.arrow_back)),
          title: Text("Payment Method",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w500)),
          centerTitle: false,
          actions: [
            // Container(
            //     child: Icon(Icons.search)),
            const SizedBox(
              width: 15,
            )
          ],
          elevation: 0,
          surfaceTintColor: AppColors.white,
        ),

        bottomNavigationBar: Card(
          surfaceTintColor: AppColors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if(controller.loadingPayment != false)
                Text("Please Wait....", style: Theme.of(context).textTheme.labelSmall,),
              Padding(
                // padding: const EdgeInsets.symmetric(horizontal:  10.0,vertical: 20),
                padding: switch (layoutInfo){
                  (_,Orientation.landscape)=>  const EdgeInsets.symmetric(horizontal: 40.0,vertical: 10) ,_=>
                      const EdgeInsets.only(left: 10.0,right: 10,top: 5,bottom: 20)},

                child: AppButton(title: "Confirm Payment", onTap: () {

                  final data = PaymentModel(
                    paymentType: "cod",
                    addressId: controller.checkOutAddress?.id.toString(),
                    subtotal: controller.totalCheckOutValue.toString(),
                    discount: controller.appliedCouponValue,
                    tax: controller.taxvalue,
                    shippingCharge: controller.shippingcost,
                    total: controller.subtotal
                  );


                  if(int.parse(controller.subtotal) < walletProvider.totalWallet || controller.checkIndex !=0 ) {
                      if (controller.selectedPaymentMethod != null) {
                        for (int i = 0;
                            i < controller.paymentMethod.length;
                            i++) {
                          controller.paymentMethod[i]["isSelected"] = false;
                        }
                        // openDialog(context, controller, layoutInfo);
                        if (controller.loadingPayment == false) {
                          controller.makePayment(data, (value) {
                            if (value) {
                              openDialog(context, controller, layoutInfo);
                            }
                          });
                        } else {}
                        //
                      } else {
                        showSnackBar(
                            snackPosition: SnackPosition.TOP,
                            title: "Warning",
                            description: "Please select a payment option");
                      }
                    }else{
                    showSnackBar(
                        snackPosition: SnackPosition.TOP,
                        title: "Warning",
                        description: "Your wallet don't have enough balance");
                  }
                  },),
              ),
              SizedBox(height: 20)
            ],
          ),
        ),
        body: SafeArea(child: Padding(
          padding: switch (layoutInfo){
            (_,Orientation.landscape)=>  const EdgeInsets.symmetric(horizontal: 40.0) ,_=>
                const EdgeInsets.symmetric(horizontal: 10.0)},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),
              Text("Select the payment method you want to use.",style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.divideColor),),
              const SizedBox(height: 15,),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.paymentMethod.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>  Card(
                    surfaceTintColor: AppColors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: ListTile(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

                        contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        leading: Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                  // color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Image.asset(controller.paymentMethod[index]["image"],
                                  fit: BoxFit.contain,),
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          controller.paymentMethod[index]["name"],
                          style: Theme.of(context).textTheme.titleLarge,
                        ),

                        trailing: Container(
                          width: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if(index==0)
                                Consumer<WalletsController>(builder: (context, wController, child) => Text("${wController.totalWallet}",style: Theme.of(context).textTheme.bodyLarge,)),
                              Container(
                                width: 50,
                                child:  GestureDetector(
                                  onTap: () {
                                    controller.setIndex(index);
                                    if(controller.paymentMethod[index]["type"] !=0) {
                                      for (int i = 0; i < controller.paymentMethod.length; i++)
                                      {
                                        controller.paymentMethod[i]["isSelected"] = (i == index);
                                      }
                                      controller.updatePaymentMethodValue(controller.paymentMethod[index]);
                                    }else {
                                      showSnackBar(snackPosition: SnackPosition.TOP,
                                        title: "Warning",
                                        description: "${controller.paymentMethod[index]["name"]} is not active"
                                      );
                                    }

                                  },
                                  child: Icon(
                                    controller.paymentMethod[index]["isSelected"] == false
                                        ? Icons.circle_outlined
                                        : Icons.circle,
                                    color: AppColors.primaryColor,
                                    size: 18,
                                  ),
                                )
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),),
              ),
            ],
          ),
        )),
      ),
    );
  }

  openDialog(context,CartController controller,layOutInfo,) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              backgroundColor: AppColors.white,
              surfaceTintColor: AppColors.white,

              content: Container(
                width: switch(layOutInfo){
                  (_,Orientation.landscape)=>MediaQuery.sizeOf(context).width*.4,_=> MediaQuery.sizeOf(context).width
                },
                // height: MediaQuery.sizeOf(context).height*.6,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Text("Are You Sure !, remove this item from cart.",style: Theme.of(context).textTheme.bodyLarge,),
                     SizedBox(height: MediaQuery.sizeOf(context).height*.1,),
                    Container(
                      height: 150,
                      width: 150,
                      child: Image.asset("assets/images/cart_icon.png",fit: BoxFit.cover,),
                    ),
                    const SizedBox(height: 10,),
                    Text(
                      "Order Confirmed !",
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10,),
                    Text(
                      "Your order has been successfully placed order. ",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      "Your order id number id ${controller.orderNumber}",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).height*.08,),
                    AppButton(title: "Continue Shopping", onTap: () {
                      controller.selectedPaymentMethod=null;
                      Get.offAll(const BottomBarScreen(index: 0,type: 1,));
                    },),
                    const SizedBox(height: 15,),
                    // AppButton(
                    //   bgColor: AppColors.gery1Color,
                    //   style: Theme.of(context).textTheme.bodyLarge,
                    //
                    //   title: "View E-Receipt", onTap: () {
                    //   read.saveCartLoad(false);
                    // },),
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
            );
          },
        );
      },
    );
  }

}



class PaymentModel {
  String? paymentType;//cod
  String? addressId;//6
  String? subtotal;//789
  String? discount;
  String? tax;
  String? shippingCharge;
  String? total;

  PaymentModel({
    this.paymentType,
    this.addressId,
    this.subtotal,
    this.discount,
    this.tax,
    this.shippingCharge,
    this.total,
  });
}