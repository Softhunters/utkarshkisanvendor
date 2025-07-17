import 'dart:io';

import 'package:utkrashvendor/app/CategoryProduct/product_detail_screen.dart';
import 'package:utkrashvendor/app/Home/controller/home_controller.dart';
import 'package:utkrashvendor/app/kisan%20Dashboard/controller/dashboard_controller.dart';
import 'package:utkrashvendor/widgets/cache_network_image.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/app_colors.dart';
import '../../../common_widgets/urls.dart';
import '../../../constant/cons.dart';
import '../../../widgets/app_button_widget.dart';
import '../../../widgets/text_fields.dart';

class OrderDetaisVariantView extends StatelessWidget {
  const OrderDetaisVariantView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    final screenSize = ScreenUtils.getScreenSize(context);
    final orientation = MediaQuery.orientationOf(context);
    final layoutInfo = (screenSize, orientation);
    var isBigDevice = ScreenUtils.isBigDevice(screenSize);
    if (isBigDevice) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      });
    }
    return Consumer<DashboardController>(
      builder: (context, controller, child) => Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back)),
          title: Text("Customer Order Detail",
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
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Visibility(
            visible: !controller.isLoading,
            replacement: const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Order No.",
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.w300,
                                            color: AppColors.grey1)),
                                Text(
                                    "${controller.orderDetails?.orderApi?.orderNumber}",
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                            fontWeight: FontWeight.w300)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("Order On",
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.w300,
                                            color: AppColors.grey1)),
                                Text(
                                    "${controller.orderDetails?.createdAt?.split('T').first}",
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                            fontWeight: FontWeight.w300)),
                              ],
                            ),
                          ),
                          if (controller.orderDetails?.orderApi?.status ==
                              "delivered")
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Delivered on",
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.w300,
                                              color: AppColors.grey1)),
                                  Text(
                                      "${controller.orderDetails?.deliveredDate}",
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                              fontWeight: FontWeight.w300)),
                                ],
                              ),
                            ),

                          // if(datas.status =="delivered")
                          //   Align(
                          //       alignment: Alignment.centerRight,
                          //       child: Text("Your Order delivered on ${datas.deliveredDate}",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w300))),
                          // if(datas.status =="canceled" )
                          //   Align(
                          //       alignment: Alignment.centerRight,
                          //       child: Text("Your Order Cancel on ${datas.deliveredDate}",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w300))),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Price",
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.w300,
                                            color: AppColors.grey1)),
                                Text(
                                    "₹${(num.tryParse("${controller.orderDetails?.price ?? '0'}") ?? 0) * (num.tryParse("${controller.orderDetails?.quantity ?? '0'}") ?? 0)}",
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                            fontWeight: FontWeight.w300)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("Status",
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.w300,
                                            color: AppColors.grey1)),
                                Text(
                                    "${controller.orderDetails?.orderApi?.status}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                            fontWeight: FontWeight.w300,
                                            color: controller.orderDetails
                                                        ?.orderApi?.status ==
                                                    "ordered"
                                                ? AppColors.orange
                                                : controller
                                                            .orderDetails
                                                            ?.orderApi
                                                            ?.status ==
                                                        "delivered"
                                                    ? AppColors.green
                                                    : AppColors.redColor)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Consumer<DashboardController>(
                                            builder:
                                                (context, controller, child) =>
                                                    GestureDetector(
                                              onTap: () {},
                                              child: MyCacheNetworkImages(
                                                imageUrl:
                                                    "$imageURL${controller.orderDetails?.productApi?.image}",
                                                radius: 10,
                                                fit: BoxFit.cover,
                                                width: 70,
                                                height: 80,
                                              ),
                                            ),
                                          )),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              controller.orderDetails
                                                      ?.productApi?.name ??
                                                  "",
                                              maxLines: 2,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                      color: AppColors
                                                          .primaryColor),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Price: ₹${controller.orderDetails?.mrpPrice ?? ""}",
                                              maxLines: 1,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge
                                                  ?.copyWith(
                                                      color: AppColors
                                                          .primaryBlack,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Qty. :${controller.orderDetails?.quantity}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelLarge
                                                      ?.copyWith(
                                                          color: AppColors
                                                              .primaryColor),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 22,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Card(
                          elevation: 4,
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Unit Price",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w300,
                                                  color: AppColors.grey1),
                                        ),
                                        Text(
                                          "₹${(((num.tryParse("${controller.orderDetails?.price ?? '0'}") ?? 0) * (100 - (num.tryParse("${controller.orderDetails?.gst ?? '0'}") ?? 0)) / 100))} * ${controller.orderDetails?.quantity} = ${(((num.tryParse("${controller.orderDetails?.price ?? '0'}") ?? 0) * (100 - (num.tryParse("${controller.orderDetails?.gst ?? '0'}") ?? 0)) / 100) * (num.tryParse("${controller.orderDetails?.quantity ?? '1'}") ?? 1))} ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w300),
                                        )
                                      ],
                                    )),
                                    Expanded(
                                        child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "CGST",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w300,
                                                  color: AppColors.grey1),
                                        ),
                                        Text(
                                          "${(num.tryParse(controller.orderDetails?.gst ?? '') ?? 0) / 2}% ( ₹${((num.tryParse("${controller.orderDetails?.price ?? '0'}") ?? 0) * ((num.tryParse("${controller.orderDetails?.gst ?? '0'}") ?? 0) / 2) / 100)})",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w300),
                                        )
                                      ],
                                    )),
                                  ],
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "SGST",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w300,
                                                  color: AppColors.grey1),
                                        ),
                                        Text(
                                            "${(num.tryParse(controller.orderDetails?.gst ?? '') ?? 0) / 2}% ( ₹${((num.tryParse("${controller.orderDetails?.price ?? '0'}") ?? 0) * ((num.tryParse("${controller.orderDetails?.gst ?? '0'}") ?? 0) / 2) / 100)})",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.w300))
                                      ],
                                    )),
                                    Expanded(
                                        child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text("IGST",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                    fontWeight: FontWeight.w300,
                                                    color: AppColors.grey1)),
                                        Text("0% (₹0.0)",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.w300))
                                      ],
                                    )),
                                  ],
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Total",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.w700)),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Text("=",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.w700)),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Text(
                                        "₹${(num.tryParse("${controller.orderDetails?.price ?? '0'}") ?? 0) * (num.tryParse("${controller.orderDetails?.quantity ?? '0'}") ?? 0)}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.w700)),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
