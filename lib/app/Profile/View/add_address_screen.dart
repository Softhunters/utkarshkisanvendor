import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:utkrashvendor/common_widgets/app_colors.dart';
import 'package:utkrashvendor/widgets/app_button_widget.dart';
import 'package:utkrashvendor/widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/snack_bar.dart';
import '../Controller/profile_controller.dart';
import '../model/country_model.dart';

class AddAddressScreen extends StatefulWidget {
  final int id;

  const AddAddressScreen({super.key, required this.id});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  late ProfileController controller;
  
  void initState(){
    final controller = Provider.of<ProfileController>(context, listen: false);
    controller.selectedCountry();
    controller.countryController.text ="India";
  }


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Consumer<ProfileController>(
      builder: (context, controller, child) => Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                controller.countries.clear();
                controller.stateList.clear();
                controller.cityList.clear();
                controller.nameController.clear();
                controller.mobileController.clear();
                controller.optionalMobileController.clear();
                controller.streetController.clear();
                controller.street2Controller.clear();
                controller.landmarkController.clear();
                controller.pinController.clear();
                controller.selectedCountryId = null;
                controller.selectedStateId = null;
                controller.selectedCityId = null;
                controller.isChecked = false;

                controller.setAddressType(AddressType.home);
                // controller._addressType = AddressType.other;

                Get.back();
              },
              child: const Icon(Icons.arrow_back)),
          title: Text("Add Address",
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
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SafeArea(
              child: Form(
                key: controller.formkey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ListView(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name*",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w500)),
                      const SizedBox(
                        height: 5,
                      ),

                      AppTextFormWidget(
                          hintText: "Full Name",
                          controller: controller.nameController,
                          focusNode: controller.name,
                          keyBoardType: TextInputType.text,
                          maxLines: 1,
                          onComplete: (value) {
                            controller.name.unfocus();
                            FocusScope.of(context).requestFocus(controller.mobile);
                          },
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: AppColors.divideColor)),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: width * .43,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Mobile*",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontWeight: FontWeight.w500)),
                                const SizedBox(
                                  height: 5,
                                ),
                                AppTextFormWidget(
                                  maxLength: 10,
                                  hintText: "Mobile no.",
                                  keyBoardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  controller: controller.mobileController,
                                  focusNode: controller.mobile,
                                  maxLines: 1,
                                  onComplete: (value) {
                                    controller.mobile.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(controller.mobile2);
                                  },
                                  // width: width * .43,
                                  // height: 65,
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: AppColors.divideColor),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter phone number";
                                    } else if (value.length < 10) {
                                      return "Please enter atleast 10 digit";
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: width * .43,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Mobile (Optional)",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.primaryBlack)),
                                const SizedBox(
                                  height: 5,
                                ),
                                AppTextFormWidget(
                                    hintText: "Mobile no.",
                                    maxLength: 10,
                                    width: width * .43,
                                    height: 65,
                                    controller: controller.optionalMobileController,
                                    keyBoardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    focusNode: controller.mobile2,
                                    maxLines: 1,
                                    onComplete: (value) {
                                      controller.mobile2.unfocus();
                                      FocusScope.of(context)
                                          .requestFocus(controller.street);
                                    },
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: AppColors.divideColor)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: width * .88,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Address*",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontWeight: FontWeight.w500)),
                                const SizedBox(
                                  height: 5,
                                ),
                                AppTextFormWidget(
                                    hintText: "Enter Street Name",
                                    controller: controller.streetController,
                                    focusNode: controller.street,
                                    keyBoardType: TextInputType.streetAddress,
                                    maxLines: 1,
                                    onComplete: (value) {
                                      controller.street.unfocus();
                                      FocusScope.of(context)
                                          .requestFocus(controller.street2);
                                    },
                                    // width: width * .43,
                                    // height: 50,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please enter address";
                                      }
                                    },
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: AppColors.divideColor)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                            width: width * .88,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Apt/Suite/Floor*",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontWeight: FontWeight.w500)),
                                const SizedBox(
                                  height: 5,
                                ),
                                AppTextFormWidget(
                                    hintText: "Apt/Suite/Floor",
                                    // width: width * .43,
                                    // height: 50,
                                    controller: controller.street2Controller,
                                    focusNode: controller.street2,
                                    keyBoardType: TextInputType.streetAddress,
                                    maxLines: 1,
                                    onComplete: (value) {
                                      controller.street2.unfocus();
                                      FocusScope.of(context)
                                          .requestFocus(controller.landmark);
                                    },
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: AppColors.divideColor)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text("Landmark",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w500)),
                      const SizedBox(
                        height: 5,
                      ),
                      AppTextFormWidget(
                          hintText: "Enter Landmark",
                          controller: controller.landmarkController,
                          maxLines: 1,

                          keyBoardType: TextInputType.text,
                          focusNode: controller.landmark,
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: AppColors.divideColor)),
                      const SizedBox(
                        height: 20,
                      ),

                      /// Country and State
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Country*",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w500)),
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                width: 150,
                                child: AppTextFormWidget(
                                    hintText: "India",
                                    controller: controller.countryController,
                                    maxLines: 1,
                                    enable: false,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: Colors.black),

                                    keyBoardType: TextInputType.text,
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: AppColors.divideColor)),

                              ),
                              // DropdownButtonHideUnderline(
                              //   child: DropdownButton2<String>(
                              //     value: controller.selectedCountryId,
                              //     style: const TextStyle(
                              //         fontSize: 14, fontWeight: FontWeight.normal),
                              //     iconStyleData: const IconStyleData(
                              //         icon: Icon(
                              //           Icons.keyboard_arrow_down_outlined,
                              //         ),
                              //         iconSize: 30,
                              //         iconEnabledColor: AppColors.primaryBlack),
                              //     isExpanded: true,
                              //     hint: const Text(
                              //       "Country",
                              //       style: TextStyle(
                              //           fontSize: 14,
                              //           fontWeight: FontWeight.normal),
                              //     ),
                              //     items: [
                              //       ...controller.countries
                              //           .map((e) => DropdownMenuItem(
                              //           value: e.id.toString(),
                              //           child: SizedBox(
                              //             height:
                              //             MediaQuery.sizeOf(context).width *
                              //                 .05,
                              //             width:
                              //             MediaQuery.sizeOf(context).width *
                              //                 .65,
                              //             child: Text(e.name ?? "",
                              //                 style: TextStyle(
                              //                     fontSize: 14,
                              //                     fontWeight: FontWeight.w600,
                              //                     color: Theme.of(context)
                              //                         .primaryColor)),
                              //           )))
                              //           .toList(),
                              //     ],
                              //     onChanged: (String? value) {
                              //       // controller.country = value;
                              //         print("gfgfgfgfgf Country ʼd ${value}");
                              //
                              //     },
                              //     menuItemStyleData: const MenuItemStyleData(
                              //       height: 45,
                              //     ),
                              //     buttonStyleData: ButtonStyleData(
                              //       height: 50,
                              //       width: width * .43,
                              //       padding:
                              //       const EdgeInsets.only(left: 14, right: 14),
                              //       decoration: BoxDecoration(
                              //           borderRadius: BorderRadius.circular(14),
                              //           color: AppColors.textFieldColor),
                              //       elevation: 0,
                              //     ),
                              //     dropdownStyleData: DropdownStyleData(
                              //       maxHeight:
                              //       MediaQuery.sizeOf(context).height * .8,
                              //       width: MediaQuery.sizeOf(context).width * .6,
                              //       decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.circular(14),
                              //         color: Colors.white,
                              //       ),
                              //       offset: const Offset(-20, 0),
                              //       scrollbarTheme: ScrollbarThemeData(
                              //         radius: const Radius.circular(40),
                              //         thickness: MaterialStateProperty.all(6),
                              //         thumbVisibility:
                              //         MaterialStateProperty.all(true),
                              //       ),
                              //     ),
                              //   ),
                              // ),

                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("State*",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w500)),
                              const SizedBox(
                                height: 5,
                              ),
                              DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  value: controller.selectedStateId,
                                  style: const TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.normal),
                                  iconStyleData: const IconStyleData(
                                      icon: Icon(
                                        Icons.keyboard_arrow_down_outlined,
                                      ),
                                      iconSize: 30,
                                      iconEnabledColor: AppColors.primaryBlack),
                                  isExpanded: true,
                                  hint: const Text(
                                    "State",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  items: [
                                    ...controller.stateList
                                        .map((e) => DropdownMenuItem(
                                        value: e.id.toString(),
                                        child: SizedBox(
                                          height:
                                          MediaQuery.sizeOf(context).width *
                                              .05,
                                          width:
                                          MediaQuery.sizeOf(context).width *
                                              .65,
                                          child: Text(e.name ?? "",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: Theme.of(context)
                                                      .primaryColor)),
                                        )))
                                        .toList(),
                                  ],
                                  onChanged: (String? value) {
                                    // controller.selectedState = value;
                                    controller.selectedStateId = value;
                                    controller.getCity(
                                        controller.selectedStateId.toString());
                                  },
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 45,
                                  ),
                                  buttonStyleData: ButtonStyleData(
                                    height: 50,
                                    width: width * .43,
                                    padding:
                                    const EdgeInsets.only(left: 14, right: 14),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: AppColors.textFieldColor),
                                    elevation: 0,
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    maxHeight:
                                    MediaQuery.sizeOf(context).height * .8,
                                    width: MediaQuery.sizeOf(context).width * .6,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: Colors.white,
                                    ),
                                    offset: const Offset(-20, 0),
                                    scrollbarTheme: ScrollbarThemeData(
                                      radius: const Radius.circular(40),
                                      thickness: MaterialStateProperty.all(6),
                                      thumbVisibility:
                                      MaterialStateProperty.all(true),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          )
                        ],
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("City*",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w500)),
                              const SizedBox(
                                height: 5,
                              ),
                              DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  value: controller.selectedCityId,
                                  style: const TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.normal),
                                  iconStyleData: const IconStyleData(
                                      icon: Icon(
                                        Icons.keyboard_arrow_down_outlined,
                                      ),
                                      iconSize: 30,
                                      iconEnabledColor: AppColors.primaryBlack),
                                  isExpanded: true,
                                  hint: const Text(
                                    "City",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  items: [
                                    ...controller.cityList
                                        .map((e) => DropdownMenuItem(
                                        value: e.id.toString(),
                                        child: SizedBox(
                                          height:
                                          MediaQuery.sizeOf(context).width *
                                              .05,
                                          width:
                                          MediaQuery.sizeOf(context).width *
                                              .65,
                                          child: Text(e.name ?? "",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: Theme.of(context)
                                                      .primaryColor)),
                                        )))
                                        .toList(),
                                  ],
                                  onChanged: (String? value) {
                                    controller.cityValueSave(
                                      value,
                                    );
                                  },
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 45,
                                  ),
                                  buttonStyleData: ButtonStyleData(
                                    height: 50,
                                    width: width * .43,
                                    padding:
                                    const EdgeInsets.only(left: 14, right: 14),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: AppColors.textFieldColor),
                                    elevation: 0,
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    maxHeight:
                                    MediaQuery.sizeOf(context).height * .8,
                                    width: MediaQuery.sizeOf(context).width * .6,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: Colors.white,
                                    ),
                                    offset: const Offset(-20, 0),
                                    scrollbarTheme: ScrollbarThemeData(
                                      radius: const Radius.circular(40),
                                      thickness: MaterialStateProperty.all(6),
                                      thumbVisibility:
                                      MaterialStateProperty.all(true),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: width * .43,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Zip Code*",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontWeight: FontWeight.w500)),
                                const SizedBox(
                                  height: 5,
                                ),
                                AppTextFormWidget(
                                    width: width * .43,
                                    maxLength: 6,
                                    keyBoardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    hintText: "Zip code",
                                    controller: controller.pinController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please enter zip code";
                                      }
                                    },
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: AppColors.divideColor)),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          Flexible(
                            // flex: 1,
                            child: RadioListTile<AddressType>(
                              contentPadding: EdgeInsets.zero,
                              title: const Text("Home"),
                              value: AddressType.home,
                              groupValue: controller.addressType,
                              onChanged: (value) {
                                controller.setAddressType(value!);
                              },
                            ),
                          ),
                          Flexible(
                            // flex: 1,
                            child: RadioListTile<AddressType>(
                              contentPadding: EdgeInsets.zero,
                              title: const Text("Work"),
                              value: AddressType.office,
                              groupValue: controller.addressType,
                              onChanged: (value) {
                                controller.setAddressType(value!);
                              },
                            ),
                          ),
                          Flexible(
                            // flex: 1,
                            child: RadioListTile<AddressType>(
                              contentPadding: EdgeInsets.zero,
                              title: const Text("Other"),
                              value: AddressType.other,
                              groupValue: controller.addressType,
                              onChanged: (value) {
                                controller.setAddressType(value!);
                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Checkbox(
                          //     value: controller.isChecked,
                          //     onChanged: (value) {
                          //       controller.checkValue(value);
                          //     },
                          //     side: const BorderSide(color: AppColors.primaryColor),
                          //     checkColor: AppColors.primaryColor),
                          //

                          Checkbox(
                            value: controller.isChecked,
                            onChanged: (value) {
                              controller.checkValue(value);
                            },
                            activeColor: controller.isChecked
                                ? AppColors.primaryBlack
                                : AppColors.primaryWhite,
                          ),

                          const Text(
                            "Make default address",
                            style: TextStyle(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      AppButton(
                        title: "Add Address",
                        onTap: () {
                          if (!controller.formkey.currentState!.validate()) {
                            return;
                          } else if ((controller.selectedCountryId ?? '').isEmpty) {
                            showSnackBar(
                              snackPosition: SnackPosition.TOP,
                              title: "Error",
                              description: "Please select a country",
                            );
                            return;
                          } else if ((controller.selectedStateId ?? '').isEmpty) {
                            showSnackBar(
                              snackPosition: SnackPosition.TOP,
                              title: "Error",
                              description: "Please select your state",
                            );
                            return;
                          } else if ((controller.selectedCityId ?? '').isEmpty) {
                            showSnackBar(
                              snackPosition: SnackPosition.TOP,
                              title: "Error",
                              description: "Please select your city",
                            );
                            return;
                          }
                          else if ((controller.streetController.text ?? '').isEmpty) {
                            showSnackBar(
                              snackPosition: SnackPosition.TOP,
                              title: "Error",
                              description: "Please fill your address.",
                            );
                            return;
                          }
                          else {
                            var data = AddressModel(
                                id: widget.id.toString(),
                                name: controller.nameController.text,
                                mobile: controller.mobileController.text,
                                optionalMobile:
                                controller.optionalMobileController.text,
                                street: controller.streetController.text,
                                street2: controller.street2Controller.text,
                                landmark: controller.landmarkController.text,
                                country: "101",
                                state: controller.selectedStateId.toString(),
                                city:  controller.selectedCityId.toString(),
                                zip: controller.pinController.text,
                                isDefaultAddress:
                                controller.isChecked == true ? 1 : 0,
                                addressType: controller.addressType
                                    .toString()
                                    .split(".")
                                    .last);

                            controller.saveAddress(data, (value) {
                              if (value == true) {
                                // showSnackBar(snackPosition: SnackPosition.TOP,
                                //     title: "Success",
                                //     description: "Successfully");
                                Navigator.pop(context);
                                Navigator.pop(context);
                              }
                            });
                          }

                          // controller.nameController.clear();
                          // // controller.cityController.clear();
                          // controller.streetController.clear();
                          // controller.landmarkController.clear();
                          // // controller.districtController.clear();
                          // controller.pinController.clear();
                          // Get.back();
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}

class AddressModel {
  final String? id;
  final String? name;
  final String? mobile;
  final String? optionalMobile;
  final String? street;
  final String? street2;
  final String? country;
  final String? state;
  final String? landmark;
  final String? city;
  final String? addressType;
  final int? isDefaultAddress;
  final String? zip;

  AddressModel(
      {this.id,
        this.name,
        this.mobile,
        this.optionalMobile,
        this.street,
        this.street2,
        this.country,
        this.state,
        this.city,
        this.landmark,
        this.addressType,
        this.zip,
        this.isDefaultAddress});
}
