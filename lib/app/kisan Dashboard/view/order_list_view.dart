import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/app_colors.dart';
import '../../../common_widgets/urls.dart';
import '../../../constant/cons.dart';
import '../../../widgets/cache_network_image.dart';
import '../controller/dashboard_controller.dart';
import 'order_detais_variant_view.dart';

class OrderListView extends StatefulWidget {
  const OrderListView({super.key});

  @override
  State<OrderListView> createState() => _OrderListViewState();
}

class _OrderListViewState extends State<OrderListView> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
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

      builder: (context, controller, _) => Scaffold(
        appBar: AppBar(
          title: const Text("Customer Order List"),
          centerTitle: false,
        ),
        body: controller.orderList == null || controller.orderList!.isEmpty
            ? const Center(
                child: Text(
                  "No Order Yet",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryBlack,
                  ),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.orderList?.length ?? 0,
                itemBuilder: (context, index) {
                  var data = controller.orderList![index];
                  print("qqqqqwwwww ${data?.status}");
                  return GestureDetector(
                    onTap: () async {
                      await controller.getOrderDetailsData(data.id.toString());
                      Get.to(() => const OrderDetaisVariantView());
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4.0, vertical: 10),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: width * 0.2,
                                  child: MyCacheNetworkImages(
                                    imageUrl:
                                        "$imageURL${data.productApi?.image}",
                                    width: 100,
                                    height: 110,
                                    radius: 10,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Container(
                                  width: width * 0.6,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.productApi?.name ?? "",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        "MRP: ${data.productApi?.regularPrice ?? ''}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                                fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "Your Selling Price: ₹${data.price ?? ''}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                                fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Order No.",
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                fontWeight: FontWeight.w300,
                                                color: AppColors.grey1,
                                              ),
                                        ),
                                        Text(
                                          "${data.orderApi?.orderNumber}",
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w300),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          "Order On",
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                fontWeight: FontWeight.w300,
                                                color: AppColors.grey1,
                                              ),
                                        ),
                                        Text(
                                          "${data.createdAt?.split("T").first}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w300),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          "Status",
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                fontWeight: FontWeight.w300,
                                                color: AppColors.grey1,
                                              ),
                                        ),
                                        Text(
                                          "${data?.status}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                fontWeight: FontWeight.w300,
                                                color: data?.status ==
                                                        "ordered"
                                                    ? AppColors.indigo
                                                    : data?.status ==
                                                            "delivered"
                                                        ? AppColors.green
                                                        : data
                                                                    ?.status ==
                                                                "accepted"
                                                            ? AppColors.orange
                                                            : AppColors
                                                                .redColor,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            if (data?.status == "ordered") ...{
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      await controller
                                          .orderAcceptByVandarDetails(
                                              (data.id ?? '').toString());
                                      await controller.getOrderListData((data?.orderId??'').toString());
                                      //     Get.to(() => EditProductView(data));
                                    },
                                    child: Container(
                                      width: width * 0.4,
                                      decoration: BoxDecoration(
                                        // color: AppColors.primaryColor,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: AppColors.primaryColor),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 4),
                                        child: Center(
                                          child: Text(
                                            "Accept Order",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge
                                                ?.copyWith(
                                                    color:
                                                        AppColors.primaryBlack,
                                                    fontWeight: FontWeight.w700,
                                                    letterSpacing: 1.5),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                      child: GestureDetector(
                                    onTap: () async {
                                      await controller
                                          .orderRejectByVandarDetails(
                                              (data.id ?? '').toString());
                                      await controller.getOrderListData((data?.orderId??'').toString());
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        //    color: AppColors.yellowishColor,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 4),
                                        child: Center(
                                          child: Text(
                                            "Reject Order",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.primaryBlack,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                                ],
                              )
                            } else ...{
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Order ${data.status}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: data.status == "accepted"
                                              ? AppColors.primaryColor
                                              : AppColors.redColor,
                                        ),
                                  )
                                ],
                              )
                            }
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
