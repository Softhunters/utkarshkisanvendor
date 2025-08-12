import 'package:utkrashvendor/app/Order/View/order_detail_screen.dart';
import 'package:utkrashvendor/widgets/app_button_widget.dart';
import 'package:utkrashvendor/widgets/text_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/app_colors.dart';
import '../../../constant/cons.dart';
import '../../../widgets/cache_network_image.dart';
import '../Controller/order_controller.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  String userId = "";

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

    double width = MediaQuery.sizeOf(context).width;

    return Consumer<OrderController>(
      builder: (context, controller, child) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              children: [
                Expanded(
                  child: Visibility(
                    visible: !controller.isLoading,
                    replacement: const Center(
                      child: CupertinoActivityIndicator(),
                    ),
                    child: controller.order.isEmpty
                        ? Expanded(
                            child: Center(
                            child: Text("You haven\'t placed any orders yet.",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.primaryBlack)),
                          ))
                        : ListView.builder(
                            itemCount: controller.order.length,
                            itemBuilder: (context, index) {
                              var datas = controller.order[index];
                              return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: GestureDetector(
                                    onTap: () {
                                      controller
                                          .getOrdersDetail(datas.id.toString());
                                      Get.to(() => OrderDetailScreen());
                                    },
                                    child: Card(
                                      child: SizedBox(
                                        width: width,
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text("Order No.",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodySmall
                                                                ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300,
                                                                    color: AppColors
                                                                        .grey1)),
                                                        Text(
                                                            "${datas.orderNumber}",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyLarge
                                                                ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300)),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        // Text("",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w300)),
                                                        Text("Order On",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodySmall
                                                                ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300,
                                                                    color: AppColors
                                                                        .grey1)),
                                                        Text(
                                                            "${datas.createdAt?.split("T").first}",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyLarge
                                                                ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300)),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        // Text("",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w300)),
                                                        Text("Status",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodySmall
                                                                ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300,
                                                                    color: AppColors
                                                                        .grey1)),
                                                        Text("${datas.status}",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyLarge
                                                                ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300,
                                                                    color: datas.status ==
                                                                            "ordered"
                                                                        ? AppColors
                                                                            .indigo
                                                                        : datas.status ==
                                                                                "delivered"
                                                                            ? AppColors.green
                                                                            : datas.status == "accepted"
                                                                                ? AppColors.orange
                                                                                : AppColors.redColor)),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text("Price",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodySmall
                                                                ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300,
                                                                    color: AppColors
                                                                        .grey1)),
                                                        Text(
                                                            "₹${datas.subtotal}",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyLarge
                                                                ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300)),
                                                      ],
                                                    ),
                                                  ),

                                                  //
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        // Text("",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w300)),
                                                        Text("Payment Type",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodySmall
                                                                ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300,
                                                                    color: AppColors
                                                                        .grey1)),
                                                        Text(
                                                            "${datas.transaction?.mode}",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyLarge
                                                                ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300)),
                                                      ],
                                                    ),
                                                  ),

                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        // Text("",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w300)),
                                                        Text("Payment Status",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodySmall
                                                                ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300,
                                                                    color: AppColors
                                                                        .grey1)),
                                                        Text(
                                                            "${datas.transaction?.status}",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyLarge
                                                                ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300)),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              if (datas.status == "delivered")
                                                Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                        "Your Order delivered on ${datas.deliveredDate}",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge
                                                            ?.copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                color: AppColors
                                                                    .green))),
                                              if (datas.status == "canceled")
                                                Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                        "Your Order Cancel on ${datas.canceledDate}",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge
                                                            ?.copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                color: AppColors
                                                                    .redColor))),
                                              // Text("",textAlign: TextAlign.end,style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w300)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ));
                            },
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
