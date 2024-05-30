import 'package:e_commerce/app/Order/View/order_detail_screen.dart';
import 'package:e_commerce/widgets/app_button_widget.dart';
import 'package:e_commerce/widgets/text_fields.dart';
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
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back)),
          title: Text("Order History",
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
            child: Column(
              children: [
                // Center(
                //     child: Padding(
                //       padding: const EdgeInsets.only(
                //           top: 25, left: 10, right: 10,bottom: 10),
                //       child: Container(
                //         width: double.infinity,
                //         decoration: BoxDecoration(
                //             border: Border.all(width: 0.4, color: Colors.grey),
                //             borderRadius: const BorderRadius.all(
                //               Radius.circular(40),
                //             )),
                //         child: ClipRRect(
                //           borderRadius: const BorderRadius.all(
                //             Radius.circular(40),
                //           ),
                //           child: CupertinoSlidingSegmentedControl<int>(
                //               backgroundColor: Theme.of(context).highlightColor,
                //               thumbColor: Theme.of(context).primaryColor,
                //               padding: EdgeInsets.zero,
                //               groupValue: watch.segmentedControlGroupValue,
                //               onValueChanged: (value) {
                //                 read.setsegmentValu(value);
                //               },
                //               children: {
                //                 0: Container(
                //                   margin: const EdgeInsets.symmetric(vertical: 8),
                //                   child: Text(
                //                     "Active",
                //                     style: Theme.of(context)
                //                         .textTheme
                //                         .titleSmall
                //                         ?.copyWith(
                //                         color: watch.segmentedControlGroupValue == 0
                //                             ? AppColors.white
                //                             : AppColors.primaryBlack),
                //                   ),
                //                 ),
                //                 1: Container(
                //                   margin: const EdgeInsets.symmetric(vertical: 8),
                //                   child: Text(
                //                     "Complete",
                //                     style: Theme.of(context)
                //                         .textTheme
                //                         .titleSmall
                //                         ?.copyWith(
                //                         color: watch.segmentedControlGroupValue == 1
                //                             ? AppColors.white
                //                             : AppColors.primaryBlack),
                //                   ),
                //                 )
                //               }),
                //         ),
                //       ),
                //     )),
                //
                //  Row(
                //    mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     Expanded(child: Text("Id",style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600))),
                //     Expanded(child: Text("Payment",style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600))),
                //     Expanded(child: Text("Status",style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600))),
                //     Expanded(child: Text("Action",style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600))),
                //
                //   ],
                // ),
                Expanded(
                  child: Visibility(
                    visible: !controller.isLoading,
                    replacement: const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                    child: ListView.builder(
                      itemCount: controller.order.length,
                      itemBuilder: (context, index) {
                        var datas = controller.order[index];
                        return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: GestureDetector(
                              onTap: () {
                                controller.getOrdersDetail(datas.id.toString());
                                Get.to(OrderDetailScreen());
                              },
                              child: Card(
                                child: SizedBox(
                                  width: width,
                                  // height: 50,
                                  /* child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          flex:1,child: MyCacheNetworkImages(imageUrl: datas['image'], radius: 10, fit: BoxFit.cover,width: 70,height: 80,)),
                                      const SizedBox(width: 5,),
                                      Expanded(
                                        flex:4,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              datas.name ??"",
                                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                  color:  AppColors.primaryColor),
                                            ) ,
                                            Text(
                                              datas.,
                                              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                                  color:  AppColors.divideColor),
                                            ) ,
                                            IntrinsicHeight(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Color :",
                                                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                                        color:  AppColors.primaryColor),
                                                  ) ,
                                                  const SizedBox(width: 10,),
                                                  Icon(Icons.circle,size: 15,color: Color(datas["color"]),),
                                                  const VerticalDivider(
                                                    color: AppColors.divideColor,
                                                    thickness: 2,
                                                  ),
                                                  Text(
                                                    "Size :",
                                                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                                        color:  AppColors.primaryColor),
                                                  ) ,
                                                  const SizedBox(width: 10,),

                                                  Text(
                                                    datas["size"],
                                                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                                        color:  AppColors.primaryColor),
                                                  ) ,


                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Price :${datas["price"]}",
                                                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                                      color:  AppColors.primaryColor),
                                                ),
                                                datas["status"]=="Completed" ?
                                                AppButton(
                                                  width: 120,
                                                  height: 30,
                                                  style: Theme.of(context).textTheme.labelLarge,
                                                  bgColor: AppColors.primaryColor,
                                                  title: "Review", onTap: () {

                                                  controller.increaseProgress(datas['activeStep']);
                                                  _modalBottomSheetMenu(context, controller, controller,width,datas);
                                                    // Get.to(OrderDetailScreen(datas: datas));

                                                },):
                                                AppButton(
                                                  width: 120,
                                                  height: 30,
                                                  style: Theme.of(context).textTheme.labelLarge,
                                                  bgColor: AppColors.primaryColor,
                                                  title: "Track Order", onTap: () {

                                                  controller.increaseProgress(datas['activeStep']);
                                                    Get.to(OrderDetailScreen(datas: datas));

                                                },),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),


                                    ],),*/
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
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("Order No.",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall
                                                          ?.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              color: AppColors
                                                                  .grey1)),
                                                  Text("${datas.orderNumber}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: Theme.of(context)
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
                                                          TextOverflow.ellipsis,
                                                      style: Theme.of(context)
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
                                                      style: Theme.of(context)
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
                                                          TextOverflow.ellipsis,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall
                                                          ?.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              color: AppColors
                                                                  .grey1)),
                                                  Text("${datas.status}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge
                                                          ?.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              color: datas.status == "ordered"
                                                                  ? AppColors.indigo
                                                                  : datas.status == "delivered"
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
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("Price",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall
                                                          ?.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              color: AppColors
                                                                  .grey1)),
                                                  Text("${datas.subtotal}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: Theme.of(context)
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
                                                          TextOverflow.ellipsis,
                                                      style: Theme.of(context)
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
                                                      style: Theme.of(context)
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
                                                          TextOverflow.ellipsis,
                                                      style: Theme.of(context)
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
                                                      style: Theme.of(context)
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
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                  "Your Order delivered on ${datas.deliveredDate}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          color: AppColors
                                                              .green))),
                                        if (datas.status == "canceled")
                                          Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                  "Your Order Cancel on ${datas.canceledDate}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w300,
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
