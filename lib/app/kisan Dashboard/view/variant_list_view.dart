import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/app_colors.dart';
import '../../../common_widgets/urls.dart';
import '../../../constant/cons.dart';
import '../../../widgets/cache_network_image.dart';
import '../controller/dashboard_controller.dart';
import 'edit_product_view.dart';

class VariantListView extends StatefulWidget {
  const VariantListView({super.key});

  @override
  State<VariantListView> createState() => _VariantListViewState();
}

class _VariantListViewState extends State<VariantListView> {
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
          title: const Text("My Product Listing"),
          centerTitle: false,
        ),
        body: controller.variant?.variantList == null ||
                controller.variant!.variantList!.isEmpty
            ? const Center(
                child: Text(
                  "No Product yet",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryBlack,
                  ),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.variant?.variantList?.length ?? 0,
                itemBuilder: (context, index) {
                  var data = controller.variant?.variantList![index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4.0, vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: width * 0.2,
                            child: MyCacheNetworkImages(
                              imageUrl: "$imageURL${data?.productApi?.image}",
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data?.productApi?.name ?? "",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "MRP: ${data?.productApi?.regularPrice ?? ''}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Your Selling Price: ₹${data?.price ?? ''}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  children: [
                                    // 🟦 EDIT BUTTON
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(() => EditProductView(data));
                                      },
                                      child: Container(
                                        width: width * 0.2,
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: AppColors.primaryColor),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 4),
                                          child: Center(
                                            child: Text(
                                              "Edit",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge
                                                  ?.copyWith(
                                                    color: AppColors.white,
                                                    fontWeight: FontWeight.w700,
                                                    letterSpacing: 1.5,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 12),

                                    Expanded(
                                      child: Consumer<DashboardController>(
                                        builder: (context, controller, child) {
                                          final itemId =
                                              (data?.id ?? '').toString();
                                          final isLoading =
                                              controller.isItemLoading(itemId);
                                          final isInStock =
                                              data?.stockStatus == "instock";

                                          return AbsorbPointer(
                                            absorbing: isLoading,
                                            child: GestureDetector(
                                              onTap: () async {
                                                if (isLoading) return;

                                                controller.setItemLoading(
                                                    itemId, true);
                                                try {
                                                  await controller
                                                      .stockStatusToggle(
                                                          itemId);
                                                  await controller
                                                      .getVariantData();
                                                } finally {
                                                  controller.setItemLoading(
                                                      itemId, false);
                                                }
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: isInStock
                                                      ? AppColors.redColor
                                                      : AppColors
                                                          .yellowishColor,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                    color: isInStock
                                                        ? AppColors.redColor
                                                        : AppColors
                                                            .yellowishColor,
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 8.0,
                                                    vertical: 4,
                                                  ),
                                                  child: Center(
                                                    child: isLoading
                                                        ? const SizedBox(
                                                            width: 16,
                                                            height: 16,
                                                            child:
                                                                CircularProgressIndicator(
                                                              strokeWidth: 2,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          )
                                                        : Text(
                                                            isInStock
                                                                ? "Set Out of stock"
                                                                : "Set Instock",
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .labelLarge
                                                                ?.copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color:
                                                                      AppColors
                                                                          .white,
                                                                ),
                                                          ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                )

                                // Row(
                                //   children: [
                                //     GestureDetector(
                                //       onTap: () {
                                //         Get.to(() => EditProductView(data));
                                //       },
                                //       child: Container(
                                //         width: width * 0.2,
                                //         decoration: BoxDecoration(
                                //           color: AppColors.primaryColor,
                                //           borderRadius:
                                //               BorderRadius.circular(5),
                                //           border: Border.all(
                                //               color: AppColors.primaryColor),
                                //         ),
                                //         child: Padding(
                                //           padding: const EdgeInsets.symmetric(
                                //               horizontal: 8.0, vertical: 4),
                                //           child: Center(
                                //             child: Text(
                                //               "Edit",
                                //               maxLines: 1,
                                //               overflow: TextOverflow.ellipsis,
                                //               style: Theme.of(context)
                                //                   .textTheme
                                //                   .labelLarge
                                //                   ?.copyWith(
                                //                       color: AppColors.white,
                                //                       fontWeight:
                                //                           FontWeight.w700,
                                //                       letterSpacing: 1.5),
                                //             ),
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //     const SizedBox(width: 12),
                                //     Expanded(
                                //       child: AbsorbPointer(
                                //         absorbing: controller.isLoading,
                                //         child: GestureDetector(
                                //           onTap: () async {
                                //             if (controller.isLoading) return;
                                //
                                //             controller.setLoading(true);
                                //             try {
                                //               await controller
                                //                   .stockStatusToggle(
                                //                       (data?.id ?? '')
                                //                           .toString());
                                //               await controller.getVariantData();
                                //             } finally {
                                //               controller.setLoading(false);
                                //             }
                                //           },
                                //           child: Container(
                                //             decoration: BoxDecoration(
                                //               color: data?.stockStatus ==
                                //                       "instock"
                                //                   ? AppColors.redColor
                                //                   : AppColors.yellowishColor,
                                //               borderRadius:
                                //                   BorderRadius.circular(5),
                                //               border: Border.all(
                                //                 color: data?.stockStatus ==
                                //                         "instock"
                                //                     ? AppColors.redColor
                                //                     : AppColors.yellowishColor,
                                //               ),
                                //             ),
                                //             child: Padding(
                                //               padding:
                                //                   const EdgeInsets.symmetric(
                                //                       horizontal: 8.0,
                                //                       vertical: 4),
                                //               child: Center(
                                //                 child: controller.isLoading
                                //                     ? const SizedBox(
                                //                         width: 16,
                                //                         height: 16,
                                //                         child:
                                //                             CircularProgressIndicator(
                                //                           strokeWidth: 2,
                                //                           color: Colors.white,
                                //                         ),
                                //                       )
                                //                     : Text(
                                //                         data?.stockStatus ==
                                //                                 "instock"
                                //                             ? "Set Out of stock"
                                //                             : "Set Instock",
                                //                         maxLines: 1,
                                //                         overflow: TextOverflow
                                //                             .ellipsis,
                                //                         style: Theme.of(context)
                                //                             .textTheme
                                //                             .labelLarge
                                //                             ?.copyWith(
                                //                               fontWeight:
                                //                                   FontWeight
                                //                                       .w700,
                                //                               color: AppColors
                                //                                   .white,
                                //                             ),
                                //                       ),
                                //               ),
                                //             ),
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
