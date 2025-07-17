import 'package:utkrashvendor/app/Profile/View/add_address_screen.dart';
import 'package:utkrashvendor/app/Profile/model/country_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/app_colors.dart';
import '../../../widgets/app_button_widget.dart';
import '../Controller/profile_controller.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    var provider = Provider.of<ProfileController>(context, listen: false);

    return Consumer<ProfileController>(
      builder: (context, controller, child) => Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back)),
          title: Text("Address",
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
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: AppButton(
              title: "Add new Address",
              onTap: () {
                controller.getCountry();
                Get.to(()=>const AddAddressScreen(
                  id: 0,
                ));
              },
            ),
          ),
        ),),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: controller.addressList.isEmpty?Center(child: Text("You haven't added an address yet.",style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.w500),textAlign: TextAlign.center,),):ListView.builder(
            itemCount: controller.addressList.length,
            itemBuilder: (context, index) {
              var e = controller.addressList[index];

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Card(
                  surfaceTintColor: AppColors.white,
                  child: Container(
                    width: width,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  width: width * .66,
                                  child: Text(
                                    e.name ?? "",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(fontWeight: FontWeight.w700),
                                  )),
                              // const Spacer(),
                              GestureDetector(
                                  onTap: () {
                                    controller.removeAddress(e.id.toString());

                                  },
                                  child: const Icon(Icons.delete,color: AppColors.redColor,)),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                  onTap: () {

                                    provider.getCountry();
                                    provider.getState(e.country!.id.toString());
                                    provider.getCity(e.state!.id.toString());

                                    controller.nameController.text =
                                        e.name ?? "";
                                    controller.mobileController.text =
                                        e.mobile ?? "";
                                    controller.optionalMobileController.text =
                                        e.mobileOptional ?? "";
                                    controller.streetController.text =
                                        e.line1 ?? "";
                                    controller.street2Controller.text =
                                        e.line2 ?? "";
                                    controller.landmarkController.text =
                                        e.landmark ?? "";
                                    controller.pinController.text =
                                        e.zipcode ?? "";
                                    controller.selectedCountryId =
                                        e.country?.id.toString();
                                    controller.selectedStateId =
                                        e.state?.id.toString();
                                    controller.selectedCityId =
                                        e.city?.id.toString();

                                    var type = e.addressType == "home"
                                        ? AddressType.home
                                        : e.addressType == "office"
                                        ? AddressType.office
                                        : AddressType.other;
                                    controller.setAddressType(type);
                                    controller.isChecked =
                                    e.defaultAddress == "1" ? true : false;

                                    Get.to(()=>AddAddressScreen(
                                      id: e.id ?? 0,
                                    ));
                                  },
                                  // child: Text("Edit",style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.redColor),)),
                                  child: const Icon(Icons.edit,color: AppColors.blue,)),
                            ],
                          ),
                          const SizedBox(height: 5,),

                          Text(
                              "${e.line1}, ${e.line2}, ${e.city?.name}, \n${e.state?.name}, ${e.country?.name},\n${e.zipcode}",
                              textAlign: TextAlign.start,
                              maxLines: 3,
                              style: Theme.of(context).textTheme.bodyLarge),
                          const SizedBox(height: 5,),

                          Row(
                            children: [
                              const Icon(Icons.phone,size: 18,),
                              const SizedBox(width: 10,),
                              Text(
                                  "${e.mobile}",
                                  textAlign: TextAlign.start,
                                  maxLines: 3,
                                  style: Theme.of(context).textTheme.bodyLarge),
                            ],
                          ),
                          const SizedBox(height: 5,),
                          Text(
                              e.addressType == "home"
                                  ? "Home"
                                  : e.addressType == "office"
                                  ? "Office"
                                  : "Other",
                              maxLines: 3,
                              style: Theme.of(context).textTheme.bodySmall),
                          CheckboxListTile(
                            tileColor: AppColors.white,

                            title: const Text("Use as the shipping address"),
                            value: e.defaultAddress == "1" ? true : false,
                            onChanged: (newValue) {
                              int status = newValue ==true ?1:0;

                              controller.makeDefaultAddress(e.id.toString(),status.toString(),(value) {
                                if(value==true){
                                  Navigator.pop(context);
                                }
                              },);

                            },
                            controlAffinity: ListTileControlAffinity.leading,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        )),
      ),
    );
  }
}
