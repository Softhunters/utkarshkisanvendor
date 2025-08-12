import 'package:utkrashvendor/app/CartSection/Controller/cart_controller.dart';
import 'package:utkrashvendor/app/CartSection/View/CheckOut/all_promo_coupan.dart';
import 'package:utkrashvendor/app/CartSection/View/CheckOut/choose_shipping.dart';
import 'package:utkrashvendor/app/CartSection/View/CheckOut/shipping_address.dart';
import 'package:utkrashvendor/app/Payment/View/payment_screen.dart';
import 'package:utkrashvendor/app/Profile/Controller/profile_controller.dart';
import 'package:utkrashvendor/common_widgets/snack_bar.dart';
import 'package:utkrashvendor/widgets/app_button_widget.dart';
import 'package:utkrashvendor/widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../../../common_widgets/app_colors.dart';
import '../../../../common_widgets/urls.dart';
import '../../../../widgets/cache_network_image.dart';
import '../../../CategoryProduct/product_detail_screen.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Consumer<CartController>(

      builder: (context, cartProvider, child) => Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back)),
          title: Text("Check Out",
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
        bottomNavigationBar: SafeArea(child: Card(
          surfaceTintColor: AppColors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                child: AppButton(
                  title: "Continue Payment",
                  onTap: () {
                    // cartProvider.searchController.clear();
                    // if(cartProvider.checkOutAddress !=null) {
                    Get.to(()=>const PaymentOptionScreen());
                    //   }else{
                    //   showSnackBar(snackPosition: SnackPosition.TOP,
                    //   title: "Warning",
                    //     description: "Please Select"
                    //   );
                    // }
                  },
                ),
              ),
              
            ],
          ),
        )),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                shippingAddress(context, cartProvider),
                const Divider(
                  color: AppColors.divideColor,
                ),
                orderList(context, width),
                const Divider(
                  color: AppColors.divideColor,
                ),
                // chooseShipping(context,cartProvider),
                // const Divider(
                //   color: AppColors.divideColor,
                // ),
                promoCode(context, cartProvider)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget shippingAddress(
    context,
    CartController read,
  ) {
    var e = read.checkOutAddress;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Shipping Address",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(
          height: 10,
        ),
        read.checkOutAddress != null
            ? ListTile(
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
                  e!.name ?? "",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                subtitle: Text(
                  "${e.line1}, ${e.line2}, ${e.city?.name}, ${e.state?.name},${e.country?.name},${e.zipcode}",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                // trailing: GestureDetector(
                //   onTap: () {
                //     Get.to(const ShippingAddressScreen());
                //   },
                //   child: Container(
                //     height: 25,
                //     width: 25,
                //     decoration: BoxDecoration(
                //         color: AppColors.primaryColor,
                //         borderRadius: BorderRadius.circular(5)),
                //     child: const Icon(
                //       Icons.edit,
                //       color: AppColors.white,
                //       size: 18,
                //     ),
                //   ),
                // ),
              )
            : ListTile(
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
                  "Select Address",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                /* subtitle: Text(
        "${e.line1}, ${e.line2}, ${e.city?.name}, ${e.state?.name},${e.country?.name},${e.zipcode}",
              style: Theme.of(context).textTheme.bodySmall,
            ),*/
                // trailing: GestureDetector(
                //   onTap: () {
                //     Get.to(const ShippingAddressScreen());
                //   },
                //   child: Container(
                //     height: 25,
                //     width: 25,
                //     decoration: BoxDecoration(
                //         color: AppColors.primaryColor,
                //         borderRadius: BorderRadius.circular(5)),
                //     child: const Icon(
                //       Icons.edit,
                //       color: AppColors.white,
                //       size: 18,
                //     ),
                //   ),
                // ),
              ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget orderList(context, width) {
    return Consumer<CartController>(
      builder: (context, controller, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            "Order List",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
              child: ListView.builder(
            itemCount: controller.checkOutProduct.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final data = controller.checkOutProduct[index];

              return Card(
                elevation: 1,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4.0, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: width * .2,
                            child: MyCacheNetworkImages(
                              imageUrl: "$imageURL${data.productImage}",
                              width: 70,
                              height: 90,
                              radius: 10,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: width * .68,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: width * .6,
                                  child: Text(
                                    data.productName ?? "",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.product?.salePrice ?? "",
                                      maxLines: 1,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                              color: AppColors.primaryBlack),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    if(double.tryParse(data.product?.salePrice ?? "")!=double.tryParse(data.product?.regularPrice ?? ""))
                                    Text(
                                      data.product?.regularPrice ?? "",
                                      maxLines: 1,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(
                                              // fontSize: 8,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color: AppColors.redColor),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    if(double.tryParse(data.product?.salePrice ?? "")!=double.tryParse(data.product?.regularPrice ?? ""))
                                    Text(
                                      "${data.product?.discountValue}% off",
                                      maxLines: 1,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 24,
                                      height: 25,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          color: AppColors.divideColor),
                                      child: Center(
                                        child: Text(
                                          (data.quantity ?? "").toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                  color:
                                                      AppColors.primaryColor),
                                        ),
                                      ),
                                    ),
                                    // SizedBox(width: 10,)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Widget chooseShipping(
    context,
    CartController read,
  ) {
    dynamic result;
    bool val = false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          "Choose Shipping",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(
          height: 10,
        ),
        ListTile(
          onTap: () async {
            var result = await Get.to(()=>const ChooseShipping());
            if (result != null) {
              read.setvalue(true);
              read.updateShippingValue(result);
              // val = true;
            }
          },
          contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          leading: Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
                color: AppColors.grey, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              // child: Icon(Icons.delivery_dining,color: AppColors.primaryColor,),
              child: Image.asset(
                read.changeIndex != false
                    ? read.selectedShip!["image"]
                    : "assets/images/delivery.png",
                color: AppColors.primaryColor,
              ),
            ),
          ),
          title: Text(
            read.changeIndex != false
                ? read.selectedShip!["name"]
                : "Choose Shipping Type",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          subtitle: Text(
            read.selectedShip != null ? read.selectedShip!["detail"] : "",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: AppColors.primaryColor,
            size: 18,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget promoCode(
    context,
    CartController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          "Promo Code",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width * .75,
              height: 55,
              child: GestureDetector(
                onTap: () {
                  Get.to(()=>const ChoosePromoCoupon());
                },
                child: AppTextFormWidget(

                  height: 55,
                  enable: false,
                  hintText: "Enter promo Code",
                  controller: controller.searchController,
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.divideColor,
                  ),
                  onChanged: (value) {
                    controller.saveController(value);
                  },
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                controller.getPromoCode();
                var result = await Get.to(()=>const ChoosePromoCoupon());
                if (result != null) {
                  // controller.setCouponValue(true);
                  // controller.updateCouponValue(result);
                  // controller.saveController(controller.selectedCoupon?.couponName);
                  // val = true;
                }
              },
              child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Icon(
                    Icons.add,
                    color: AppColors.white,
                  )),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Card(
          color: AppColors.white,
          surfaceTintColor: AppColors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Amount",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text("₹${num.tryParse(controller.totalamount)?.toStringAsFixed(2)}",
                        style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Discount",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                        "- ₹${(double.parse(controller.totalamount) - double.parse(controller.subtotal)).toStringAsFixed(2)}",
                        style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                //
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text("Sub Total", style: Theme.of(context).textTheme.bodyLarge,),
                //     Text("₹${controller.subtotal}", style: Theme.of(context).textTheme.bodyLarge),
                //
                //   ],
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Shipping",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    // if(controller.changeIndex)
                    Text(controller.shippingcost,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: AppColors.primaryBlack)),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                if (controller.selectedCoupon != null)
                if (controller.appliedCouponValue != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Promo",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),

                      /// create function for discount on cart total
                      Text("-₹${controller.appliedCouponValue}",
                          style: Theme.of(context).textTheme.bodyLarge),
                      // Text("${controller.calculateDiscount(controller.cartTotal, controller.selectedCoupon!.type, controller.selectedCoupon!.value)}", style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  color: AppColors.divideColor,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                        "₹${controller.checkOutvalue(double.parse(controller.subtotal))}",
                        style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
