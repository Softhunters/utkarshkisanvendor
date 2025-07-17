

import 'package:utkrashvendor/common_widgets/snack_bar.dart';
import 'package:utkrashvendor/widgets/app_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../common_widgets/app_colors.dart';
import '../../../../constant/cons.dart';
import '../../Controller/cart_controller.dart';

class ChooseShipping extends StatelessWidget {
  const ChooseShipping({super.key});

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


    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              if(watch.selectedShip != null) {
                Get.back(result: watch.selectedShip);
              }else{
                Get.back();
              }
            },
            child: const Icon(Icons.arrow_back)),
        title: Text("Choose Shipping",
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
          padding: switch (layoutInfo){
            (_,Orientation.landscape)=>  EdgeInsets.symmetric(horizontal: 40.0,vertical: 10) ,_=>
                EdgeInsets.symmetric(horizontal: 10.0,vertical: 20)},

          child: AppButton(title: "Apply", onTap: () {
            if(watch.selectedShip !=null) {
              Get.back(result: watch.selectedShip);
            }else{
             showSnackBar(
               snackPosition: SnackPosition.BOTTOM,
                 title: "Warning",
             description: "Please select a shipping option");

            }
          },),
        ),
      ),
      body: SafeArea(
          child: Padding(
            padding: switch (layoutInfo){
            (_,Orientation.landscape)=>  EdgeInsets.symmetric(horizontal: 40.0) ,_=>
              EdgeInsets.symmetric(horizontal: 10.0)},
            child: Container(
              child: ListView.builder(
                itemCount: watch.shippingType.length,
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) =>  ListTile(
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
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset(watch.shippingType[index]["image"],
                            color: AppColors.white,fit: BoxFit.contain,),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    watch.shippingType[index]["name"],
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  subtitle: Text(
                    watch.shippingType[index]["detail"],
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  trailing: Container(
                    width: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,

                      children: [
                        Text(watch.shippingType[index]["price"].toString()),
                        SizedBox(width: 10,),
                        GestureDetector(
                          onTap: () {
                            for (int i = 0; i < watch.shippingType.length; i++) {
                              read.shippingType[i]["isSelected"] = (i == index);
                            }
                            read.updateShippingValue(watch.shippingType[index]);
                          },
                          child: Icon(
                            watch.shippingType[index]["isSelected"] == false
                                ? Icons.circle_outlined
                                : Icons.circle,
                            color: AppColors.primaryColor,
                            size: 18,
                          ),
                        )
                      ],
                    ),
                  ),
                ),),
            ),
          )),
    );

  }
}
