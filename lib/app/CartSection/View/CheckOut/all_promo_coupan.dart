

import 'package:utkrashvendor/widgets/app_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../common_widgets/app_colors.dart';
import '../../../../common_widgets/snack_bar.dart';
import '../../../../constant/cons.dart';
import '../../Controller/cart_controller.dart';

class ChoosePromoCoupon extends StatelessWidget {
  const ChoosePromoCoupon({super.key});

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
    // CartController read = context.read<CartController>();
    // CartController controller = context.controller<CartController>();

return Consumer<CartController>(
  builder: (context, controller, child) =>  Scaffold(
  
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                // if(controller.selectedCoupon != null) {
                //   Get.back(result: controller.selectedCoupon);
                // }else{
                // controller.isSelectedCoupon = false;
                controller.selectedIndex = null;
                controller.selectedCoupon = null;
                  Get.back();
  
  
                // }
              },
              child: const Icon(Icons.arrow_back)),
          title: Text("Add Promo",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w500)),
          centerTitle: false,
          actions: [
  
            const SizedBox(
              width: 15,
            )
          ],
          elevation: 0,
          surfaceTintColor: AppColors.white,
        ),
        bottomNavigationBar: SafeArea(child: Card(
          surfaceTintColor: AppColors.white,
          child: Padding(
            padding: switch (layoutInfo){
              (_,Orientation.landscape)=>  EdgeInsets.symmetric(horizontal: 40.0,vertical: 10) ,_=>
                  EdgeInsets.symmetric(horizontal: 10.0,vertical: 10)},

            child: AppButton(title: "Apply",    onTap: () {
              if(controller.selectedIndex != null) {
                controller.applyPromoCode(controller.totalamount.toString(), double.parse(controller.subtotal).toStringAsFixed(2), controller.coupanCode);

                // controller.isSelectedCoupon = false;
                controller.selectedIndex = null;
                Get.back(result: controller.selectedCoupon);
              }else{

                showSnackBar(
                    snackPosition: SnackPosition.BOTTOM,
                    title: "Warning",
                    description: "Please select a promo option");

              }
            },),
          ),
        )),

        body: SafeArea(
            child: Padding(
              padding: switch (layoutInfo){
                (_,Orientation.landscape)=>  EdgeInsets.symmetric(horizontal: 40.0) ,_=>
                    EdgeInsets.symmetric(horizontal: 10.0)},
              child: Visibility(
                visible: !controller.isPromoLoading,
                replacement: Center(child: CircularProgressIndicator.adaptive(),),
                child: Visibility(
                  visible: controller.promoList.isNotEmpty,
                  replacement: Center(child: Text("No Promo code available for you",style: Theme.of(context).textTheme.bodyLarge,),),
                  child: ListView.builder(
                    itemCount: controller.promoList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var data = controller.promoList[index];
                      controller.isSelectedIndex = index==controller.selectedIndex;
                      // bool isSelected = indexs==index;
                      return ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      leading: Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                            color: AppColors.grey,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                color: AppColors.couponBackground,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  data.type =="1" ?
                              Image.asset("assets/images/percentage.png",
                                fit: BoxFit.contain,):
                              Image.asset("assets/images/coupon.png",
                               fit: BoxFit.contain,),
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                       data.type =="1" ? "Special ${data.value}% Off "
                           :"Flat ${data.value} ₹ off" ??"",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      subtitle: Text(
                         data.couponName ??"",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      trailing: Container(
                        width: 50,
                        child:  GestureDetector(
                          onTap: () {
                            controller.saveIndex (index,data.code);
                            },
                          child: Icon(
                            controller.isSelectedIndex == false
                                ? Icons.circle_outlined
                                : Icons.circle,
                            color: AppColors.primaryColor,
                            size: 18,
                          ),
                        )
                      ),
                    );
                    },),
                ),
              ),
            )),
      ),
);

  }
}
