import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:utkrashvendor/app/kisan%20Dashboard/controller/dashboard_controller.dart';
import 'package:utkrashvendor/app/kisan%20Dashboard/view/product_inventory_history_view.dart';
import '../../../common_widgets/app_colors.dart';
import '../../../common_widgets/urls.dart';
import '../../../constant/cons.dart';
import '../../../widgets/cache_network_image.dart';
import 'edit_product_view.dart';

class ProductInventoryView extends StatefulWidget {
  const ProductInventoryView({super.key});

  @override
  State<ProductInventoryView> createState() => _ProductInventoryViewState();
}

class _ProductInventoryViewState extends State<ProductInventoryView> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Consumer<DashboardController>(builder: (context, controller, _) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Product Inventory"),
          centerTitle: false,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.orderHistoryByProduct?.length ?? 0,
          itemBuilder: (context, index) {
            var data = controller.orderHistoryByProduct![index];
            return Card(
              child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 4.0, vertical: 10),
                  child: Column(
                    children: [
                      Row(
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
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        await controller
                                            .getProductInventoryHistoryDetails(
                                            data?.productId.toString());
                                        Get.to(() => ProductInventoryHistoryView(data));
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
                                              "View",
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
                                  ],
                                )

                                // Row(
                                //   children: [
                                //     // 🟦 EDIT BUTTON
                                //     GestureDetector(
                                //       onTap: () {
                                //         Get.to(() => EditProductView(data));
                                //       },
                                //       child: Container(
                                //         width: width * 0.2,
                                //         decoration: BoxDecoration(
                                //           color: AppColors.primaryColor,
                                //           borderRadius:
                                //           BorderRadius.circular(5),
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
                                //                 color: AppColors.white,
                                //                 fontWeight: FontWeight.w700,
                                //                 letterSpacing: 1.5,
                                //               ),
                                //             ),
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //
                                //     const SizedBox(width: 12),
                                //
                                //     Expanded(
                                //       child: Consumer<DashboardController>(
                                //         builder: (context, controller, child) {
                                //           final itemId =
                                //           (data?.id ?? '').toString();
                                //           final isLoading =
                                //           controller.isItemLoading(itemId);
                                //           final isInStock =
                                //               data?.stockStatus == "instock";
                                //
                                //           return AbsorbPointer(
                                //             absorbing: isLoading,
                                //             child: GestureDetector(
                                //               onTap: () async {
                                //                 if (isLoading) return;
                                //
                                //                 controller.setItemLoading(
                                //                     itemId, true);
                                //                 try {
                                //                   await controller
                                //                       .stockStatusToggle(
                                //                       itemId);
                                //                   await controller
                                //                       .getVariantData();
                                //                 } finally {
                                //                   controller.setItemLoading(
                                //                       itemId, false);
                                //                 }
                                //               },
                                //               child: Container(
                                //                 decoration: BoxDecoration(
                                //                   color: isInStock
                                //                       ? AppColors.redColor
                                //                       : AppColors
                                //                       .yellowishColor,
                                //                   borderRadius:
                                //                   BorderRadius.circular(5),
                                //                   border: Border.all(
                                //                     color: isInStock
                                //                         ? AppColors.redColor
                                //                         : AppColors
                                //                         .yellowishColor,
                                //                   ),
                                //                 ),
                                //                 child: Padding(
                                //                   padding: const EdgeInsets
                                //                       .symmetric(
                                //                     horizontal: 8.0,
                                //                     vertical: 4,
                                //                   ),
                                //                   child: Center(
                                //                     child: isLoading
                                //                         ? const SizedBox(
                                //                       width: 16,
                                //                       height: 16,
                                //                       child:
                                //                       CircularProgressIndicator(
                                //                         strokeWidth: 2,
                                //                         color:
                                //                         Colors.white,
                                //                       ),
                                //                     )
                                //                         : Text(
                                //                       isInStock
                                //                           ? "Set Out of stock"
                                //                           : "Set Instock",
                                //                       maxLines: 1,
                                //                       overflow:
                                //                       TextOverflow
                                //                           .ellipsis,
                                //                       style: Theme.of(
                                //                           context)
                                //                           .textTheme
                                //                           .labelLarge
                                //                           ?.copyWith(
                                //                         fontWeight:
                                //                         FontWeight
                                //                             .w700,
                                //                         color:
                                //                         AppColors
                                //                             .white,
                                //                       ),
                                //                     ),
                                //                   ),
                                //                 ),
                                //               ),
                                //             ),
                                //           );
                                //         },
                                //       ),
                                //     ),
                                //   ],
                                // )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "Total Spent",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 13),
                                ),
                                Text(
                                  data.totalMinus.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "Total Add",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 13),
                                ),
                                Text(
                                  data.totalAdd.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "Remaining Qty.",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 13),
                                  ),
                                  Text(
                                    data.quantity.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13),
                                  )
                                ],
                              ))
                        ],
                      )
                    ],
                  )),
            );
          },
        )
      );
    });
  }
}
