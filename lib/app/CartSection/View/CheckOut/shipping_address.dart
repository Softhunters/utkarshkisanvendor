

import 'package:utkrashvendor/app/CartSection/Controller/cart_controller.dart';
import 'package:utkrashvendor/app/Profile/Controller/profile_controller.dart';
import 'package:utkrashvendor/widgets/app_button_white_background_widget.dart';
import 'package:utkrashvendor/widgets/app_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../common_widgets/app_colors.dart';
import '../../../Profile/View/add_address_screen.dart';

class ShippingAddressScreen extends StatelessWidget {

  const ShippingAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Consumer<ProfileController>(
      builder: (context, controller, child) =>  Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back)),
          title: Text("Shipping Address",
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

        body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  Container(
                    child: ListView.builder(
                      itemCount: controller.addressList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var e = controller.addressList[index];
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
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Icon(
                              Icons.location_on,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        e.name ??"",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      subtitle: Text("${e.line1}, ${e.line2},\n${e.city?.name}, ${e.state?.name},${e.country?.name},${e.zipcode}",maxLines: 3,style: Theme.of(context).textTheme.bodySmall),

                          trailing:
                          Checkbox(value: e.defaultAddress == "1" ? true : false,
                              onChanged: (value) {
                                e.defaultAddress = value==true ?"1":"0";
                                int status = value == true ? 1:0;
                                controller.makeDefaultAddress(e.id.toString(),status.toString(),(value) {
                                  if(value==true){
                                    Navigator.pop(context);
                                  }
                                }, );
                              },)


                          // CheckboxListTile(
                          //   title: const Text("Use as the shipping address"),
                          //   value: e.defaultAddress == "1" ? true : false,
                          //   onChanged: (newValue) {
                          //     int status = newValue == true ? 1:0;
                          //
                          //     controller.makeDefaultAddress(e.id.toString(),status.toString());
                          //
                          //   },
                          //   controlAffinity: ListTileControlAffinity.leading,
                          // )


                      //     GestureDetector(
                      //   onTap: () {
                      //     int status = newValue ==true ?1:0;
                      //
                      //     controller.makeDefaultAddress(e.id.toString(),status.toString());
                      //   },
                      //   child:  Icon(
                      //    e.defaultAddress!="1" ?  Icons.circle_outlined :Icons.circle,
                      //     color: AppColors.primaryColor,
                      //     size: 18,
                      //   ),
                      // ),
                    );
                      },),
                  ),
                  SizedBox(height: 25,),
                  AppButtonWhiteBackgroundWidget(

                    title: "Add New Address",
                    style: Theme.of(context).textTheme.titleLarge,
                    onTap: () {
                      controller.getCountry();
                      Get.to(()=>AddAddressScreen(id: 0,));
                  },)

                ],
              ),
            )),
      ),
    );

  }
}
