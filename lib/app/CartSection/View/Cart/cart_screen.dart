import 'dart:io';

import 'package:currency_converter/currency.dart';
import 'package:utkrashvendor/common_widgets/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../common_widgets/app_colors.dart';
import '../../../../constant/cons.dart';
import '../../../../widgets/cache_network_image.dart';
import '../../../CategoryProduct/product_detail_screen.dart';
import '../../../Home/controller/home_controller.dart';
import '../../../Profile/Controller/profile_controller.dart';
import '../../Controller/cart_controller.dart';
import '../CheckOut/shipping_address.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // String? quotesId;
  var e;
  ProfileController profileProvider = ProfileController();

  @override
  void initState() {
    profileProvider = Provider.of<ProfileController>(context, listen: false);
    profileProvider.getAllAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final screenSize = ScreenUtils.getScreenSize(context);
    final orientation = MediaQuery.orientationOf(context);
    final layoutInfo = (screenSize, orientation);
    var isBigDevice = ScreenUtils.isBigDevice(screenSize);
    if (isBigDevice) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      });
    }

    final homeController = Provider.of<HomeController>(context, listen: false);
    final provider = Provider.of<CartController>(context, listen: false);
    provider.getCartDAta();

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<ProfileController>(
              builder: (context, value, child) {
                if (value.defaultAddress.isNotEmpty) {
                  e = value.defaultAddress.first;
                }
                return RichText(
                    text: TextSpan(
                        text: "Address:  ",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: AppColors.primaryBlack),
                        children: [
                      profileProvider.defaultAddress.isNotEmpty
                          ? TextSpan(
                              recognizer:
                                  TapGestureRecognizer() // GestureDetector or InkWell can be used here
                                    ..onTap = () {
                                      Get.to(
                                          () => const ShippingAddressScreen());
                                    },
                              text:
                                  "${e.line1}, ${e.line2},\n${e.city?.name}, ${e.state?.name},${e.country?.name},${e.zipcode}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: AppColors.indigo),
                            )
                          : TextSpan(
                              recognizer:
                                  TapGestureRecognizer() // GestureDetector or InkWell can be used here
                                    ..onTap = () {
                                      Get.to(
                                          () => const ShippingAddressScreen());
                                    },
                              text: "Select Address",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: AppColors.indigo),
                            )
                    ]));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Consumer<CartController>(
              builder: (context, controller, child) => Expanded(

                  // width: width,
                  child: Visibility(
                visible: !provider.cartLoading,
                replacement: const Center(
                  child: CupertinoActivityIndicator(),
                ),
                child: Visibility(
                  visible: controller.cartData.isNotEmpty,
                  replacement: Center(
                    child: Text(
                      "Your Cart is empty.",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  child: ListView.builder(
                    itemCount: controller.cartData.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final data = controller.cartData[index];
                      print("qwqwqwqw ${data.toJson()}");
                      return Card(
                        child: Container(
                          // decoration: BoxDecoration(border: Border.all(color: AppColors.grey),borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4.0, vertical: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    homeController
                                        .changePriceWithIndex(data.id);
                                    homeController
                                        .saveProductDetailslug(data.slug);
                                    homeController.getProductDetail(
                                        data.slug, 0);
                                    Get.to(() => ProductDetailScreen(
                                          productSlug: data.slug ?? "",
                                          id: data.id ?? 0,
                                        ));
                                  },
                                  child: Container(
                                    width: width * .2,
                                    child: MyCacheNetworkImages(
                                      imageUrl: "$imageURL${data.productImage}",
                                      width: 100,
                                      height: 110,
                                      radius: 10,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: width *
                                      switch (layoutInfo) {
                                        (_, Orientation.landscape) => .6,
                                        _ => .68
                                      },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              homeController
                                                  .changePriceWithIndex(
                                                      data.id);
                                              homeController
                                                  .saveProductDetailslug(
                                                      data.slug);
                                              homeController.getProductDetail(
                                                  data.slug, 0);
                                              Get.to(() => ProductDetailScreen(
                                                    productSlug:
                                                        data.slug ?? "",
                                                    id: data.id ?? 0,
                                                  ));
                                            },
                                            child: Container(
                                              width: width * .5,
                                              child: Text(
                                                data.productName ?? "",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                openDialog(
                                                    controller,
                                                    data.productId,
                                                    (data.sellerId ?? '')
                                                        .toString());
                                              },
                                              child: const Icon(
                                                Icons.delete,
                                                size: 18,
                                              )),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        (data.sellerName == null ||
                                                data.sellerName == "null")
                                            ? ""
                                            : data.sellerName ?? '',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.primaryColor),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Consumer<CurrencyProvider>(
                                        builder: (context, currencyProvider,
                                                child) =>
                                            FutureBuilder<double>(
                                          future: currencyProvider
                                                      .selectedCurrency ==
                                                  Currency.usd
                                              ? currencyProvider.convertToUSD(
                                                  double.parse(
                                                      data.price ?? "0.0"))
                                              : Future.value(double.parse(
                                                  data.price ?? "0.0")),
                                          builder:
                                              (context, salePriceSnapshot) {
                                            if (!salePriceSnapshot.hasData) {
                                              return Text("loading");
                                            }
                                            double salePrice =
                                                salePriceSnapshot.data ?? 0.0;
                                            return FutureBuilder<double>(
                                              future: currencyProvider
                                                          .selectedCurrency ==
                                                      Currency.usd
                                                  ? currencyProvider
                                                      .convertToUSD(double.parse(
                                                          data.regularPrice ??
                                                              "0.0"))
                                                  : Future.value(double.parse(
                                                      data.regularPrice ??
                                                          "0.0")),
                                              builder: (context,
                                                  regularPriceSnapshot) {
                                                if (!regularPriceSnapshot
                                                    .hasData) {
                                                  return const CircularProgressIndicator();
                                                }
                                                double regularPrice =
                                                    regularPriceSnapshot.data ??
                                                        0.0;
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "₹${double.tryParse(data.price ?? " ")?.toStringAsFixed(2)}",
                                                      maxLines: 1,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge
                                                          ?.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                    const SizedBox(width: 2),
                                                    if (salePrice !=
                                                        regularPrice)
                                                      Text(
                                                        "₹${double.tryParse(data.regularPrice ?? " ")?.toStringAsFixed(2)}",
                                                        maxLines: 1,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall
                                                            ?.copyWith(
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough,
                                                                color: AppColors
                                                                    .redColor),
                                                      ),
                                                    const SizedBox(width: 2),
                                                    if (salePrice !=
                                                        regularPrice)
                                                      Text(
                                                        "${data.discountValue}% off",
                                                        maxLines: 1,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelSmall,
                                                      ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      Text(
                                        data?.stockStatus ==
                                            "instock"
                                            ? "In Stock"
                                            : "Out Of Stock",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: data
                                                ?.stockStatus ==
                                                "instock"
                                                ? AppColors.green
                                                : AppColors.redColor),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Total: ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                          Text(
                                            "₹${double.parse(data.price ?? "0") * int.parse(data.quantity ?? "0")}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                    color: AppColors.green),
                                          ),
                                          // SizedBox(width: 10,)
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              homeController
                                                  .moveToWishlist(
                                                      (data.id ?? "")
                                                          .toString())
                                                  .whenComplete(() =>
                                                      controller.getCartDAta());
                                            },
                                            child: Container(
                                              width: width * .3,
                                              // height: 2,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(),
                                                // color: AppColors.primaryBlack
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0,
                                                        vertical: 4),
                                                child: Center(
                                                  child: Text(
                                                    "Move to Wishlist",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelSmall
                                                        ?.copyWith(
                                                            color: AppColors
                                                                .primaryBlack),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 25,
                                          ),
                                          Container(
                                            // width: 80,
                                            // height: 25,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                color: AppColors.divideColor),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                int.parse(data.quantity ??
                                                            "0") >
                                                        1
                                                    ? GestureDetector(
                                                        onTap: () async {
                                                          if (int.parse(
                                                                  data.quantity ??
                                                                      "1") ==
                                                              1) {
                                                            await controller.addCartDAta(
                                                                data.productId,
                                                                0,
                                                                (value) {},
                                                                (data.sellerId ??
                                                                        '1')
                                                                    .toString());
                                                            await controller
                                                                .getCartDAta();
                                                          } else {
                                                            await controller.addCartDAta(
                                                                data.productId,
                                                                int.parse(data
                                                                            .quantity ??
                                                                        "0") -
                                                                    1,
                                                                (value) {},
                                                                (data.sellerId ??
                                                                        '1')
                                                                    .toString());
                                                            await controller
                                                                .getCartDAta();
                                                          }
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: const Icon(
                                                            Icons.remove,
                                                            size: 15,
                                                          ),
                                                        ))
                                                    : SizedBox(
                                                        width: 30,
                                                      ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(data.quantity ?? "",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                GestureDetector(
                                                    onTap: () async {
                                                      await controller.addCartDAta(
                                                          data.productId,
                                                          int.parse(
                                                                  data.quantity ??
                                                                      "0") +
                                                              1,
                                                          (value) {},
                                                          (data.sellerId ?? '1')
                                                              .toString());
                                                      await controller
                                                          .getCartDAta();
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: const Icon(
                                                        Icons.add,
                                                        size: 15,
                                                      ),
                                                    )),
                                              ],
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
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )),
            ),
          ],
        ),
      )),
    );
  }

  openDialog(CartController controller, productId, sellerId) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              backgroundColor: AppColors.white,
              surfaceTintColor: AppColors.white,
              title: Text(
                "Delete Item ?",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              content: Text(
                "Are You Sure , remove this item from cart.",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                    child: Text(
                      "No",
                      style: Theme.of(context).textTheme.titleSmall,
                    )),
                ElevatedButton(
                    onPressed: () async {

                      setState(() {
                        Navigator.pop(context);
                        controller.addCartDAta(productId, 0, (value) {

                        }, sellerId);
                      });
                    },
                    child: Text(
                      "Yes",
                      style: Theme.of(context).textTheme.titleSmall,
                    ))
              ],
            );
          },
        );
      },
    );
  }
}
