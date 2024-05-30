import 'dart:io';

import 'package:e_commerce/app/CategoryProduct/product_detail_screen.dart';
import 'package:e_commerce/app/Home/controller/home_controller.dart';
import 'package:e_commerce/widgets/cache_network_image.dart';
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
import '../Controller/order_controller.dart';
import '../model/order_deatil_model.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({
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
    return Consumer<OrderController>(
      builder: (context, controller, child) => Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back)),
          title: Text("Order Detail",
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
        // floatingActionButton: FloatingActionButton(onPressed: read.increaseProgress),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Visibility(
            visible: !controller.orderLoading,
            replacement: const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Row(
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
                              Text("${controller.orderDetail?.orderNumber}",
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(fontWeight: FontWeight.w300)),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                  "${controller.orderDetail?.createdAt?.split('T').first}",
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(fontWeight: FontWeight.w300)),
                            ],
                          ),
                        ),
                        if (controller.orderDetail?.status == "delivered")
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
                                Text("${controller.orderDetail?.deliveredDate}",
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
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
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
                              Text("${controller.orderDetail?.total}",
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(fontWeight: FontWeight.w300)),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              // Text("",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w300)),
                              Text("Payment Mode",
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          fontWeight: FontWeight.w300,
                                          color: AppColors.grey1)),
                              Text(
                                  "${controller.orderDetail?.transaction?.mode}",
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(fontWeight: FontWeight.w300)),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              // Text("",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w300)),
                              Text("Status",
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          fontWeight: FontWeight.w300,
                                          color: AppColors.grey1)),
                              Text("${controller.orderDetail?.status}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          fontWeight: FontWeight.w300,
                                          color:
                                              controller.orderDetail?.status ==
                                                      "ordered"
                                                  ? AppColors.orange
                                                  : controller.orderDetail
                                                              ?.status ==
                                                          "delivered"
                                                      ? AppColors.green
                                                      : AppColors.redColor)),
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
                    const SizedBox(
                      height: 10,
                    ),
                    if (controller.orderDetail?.status != "canceled" ||
                        controller.orderDetail?.status != "rejected")
                      controller.orderDetail?.status != "delivered"
                          ? Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {
                                  var orderId =
                                      controller.orderDetail?.id.toString();
                                  var itemId = "";
                                  print(orderId);

                                  controller.cancelOrder(orderId ?? "", itemId);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all()),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18.0, vertical: 5),
                                    child: Text(
                                      "Cancel Order",
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : DateTime.now().difference(DateFormat('yyyy-MM-dd')
                          .parse(controller.orderDetail?.deliveredDate ?? ""))
                          .inDays > 1
                              ? const SizedBox()
                              : Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      var orderId =
                                          controller.orderDetail?.id.toString();
                                      var itemId = "";
                                      print(orderId);

                                      controller.returnOrder(
                                          orderId ?? "", itemId);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all()),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 18.0, vertical: 5),
                                        child: Text(
                                          "Return Order",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),

                Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.orderedItem.length,
                    itemBuilder: (context, index) {
                      var item = controller.orderedItem[index].product;
                      return Padding(
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              flex: 1,
                                              child: Consumer<HomeController>(
                                                builder: (context,
                                                        homeController,
                                                        child) =>
                                                    GestureDetector(
                                                  onTap: () {
                                                    homeController
                                                        .changePriceWithIndex(
                                                            controller
                                                                .orderedItem[
                                                                    index]
                                                                .product
                                                                ?.id);
                                                    homeController
                                                        .saveProductDetailslug(
                                                            controller
                                                                .orderedItem[
                                                                    index]
                                                                .product
                                                                ?.slug);
                                                    homeController
                                                        .getProductDetail(
                                                            controller
                                                                .orderedItem[
                                                                    index]
                                                                .product
                                                                ?.slug,
                                                            0);
                                                    Get.to(ProductDetailScreen(
                                                      productSlug: controller
                                                              .orderedItem[
                                                                  index]
                                                              .product
                                                              ?.slug ??
                                                          "",
                                                      id: controller
                                                              .orderedItem[
                                                                  index]
                                                              .product
                                                              ?.id ??
                                                          0,
                                                    ));
                                                  },
                                                  child: MyCacheNetworkImages(
                                                    imageUrl:
                                                        "$imageURL${item?.image}",
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
                                                  item?.name ?? "",
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
                                                  "Price: ₹${controller.orderedItem[index].price ?? ""}",
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
                                                      "Qty. :${controller.orderedItem[index].quantity}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelLarge
                                                          ?.copyWith(
                                                              color: AppColors
                                                                  .primaryColor),
                                                    ),
                                                    if (controller
                                                                .orderedItem[
                                                                    index]
                                                                .rstatus !=
                                                            1 &&
                                                        controller
                                                                .orderedItem[
                                                                    index]
                                                                .rstatus !=
                                                            0)
                                                      GestureDetector(
                                                        onTap: () {
                                                          // openDialog(context, controller, layoutInfo);
                                                          _modalBottomSheetMenu(
                                                              context,
                                                              width,
                                                              controller
                                                                      .orderedItem[
                                                                  index]);
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            "Rate Now",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .labelLarge
                                                                ?.copyWith(
                                                                    color: AppColors
                                                                        .blue),
                                                          ),
                                                        ),
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
                                if (controller.orderedItem.length > 1 &&
                                    controller.orderedItem[index].rstatus == 0)
                                  Positioned(
                                    top: 4,
                                    right: 5,
                                    child: PopupMenuButton(
                                      surfaceTintColor: AppColors.white,
                                      icon: const Icon(Icons.more_vert),
                                      constraints: const BoxConstraints(
                                        // maxHeight: size.height(context) * .04,
                                        maxWidth: 100,
                                      ),
                                      itemBuilder: (context) {
                                        return [
                                          PopupMenuItem(
                                            padding: const EdgeInsets.only(
                                                left: 10, bottom: 0),
                                            child: InkWell(
                                              onTap: () {
                                                Get.back();
                                                var orderId = controller
                                                    .orderDetail?.id
                                                    .toString();
                                                var itemId = controller
                                                    .orderedItem[index].id
                                                    .toString();

                                                controller.cancelOrder(
                                                    orderId ?? "",
                                                    itemId ?? "");
                                              },
                                              child: const Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0xFF444444),
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                          // PopupMenuItem(
                                          //   padding:
                                          //   const EdgeInsets
                                          //       .only(
                                          //       left:
                                          //       10,
                                          //       bottom:
                                          //       0),
                                          //   child:
                                          //   InkWell(
                                          //     onTap: () {
                                          //       Get.back();
                                          //
                                          //     },
                                          //     child:
                                          //     const Text(
                                          //       "Return",
                                          //       style: TextStyle(
                                          //           fontSize:
                                          //           14,
                                          //           color: Color(
                                          //               0xFF444444),
                                          //           fontWeight:
                                          //           FontWeight.w500),
                                          //     ),
                                          //   ),
                                          // ),
                                        ];
                                      },
                                    ),
                                  )
                              ],
                            ),
                            if (controller.orderedItem[index].rstatus == 1)
                              Text(
                                "This item has been cancelled on ${controller.orderedItem[index].canceledDate}.",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(color: AppColors.primaryColor),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                Container(
                  width: width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: EasyStepper(
                      activeStep: controller.activeStep,
                      lineStyle: const LineStyle(
                        lineLength: 50,
                      ),
                      stepShape: StepShape.rRectangle,
                      stepBorderRadius: 15,
                      borderThickness: 2,
                      stepRadius: 28,
                      finishedStepBorderColor: Colors.deepOrange,
                      finishedStepTextColor: Colors.deepOrange,
                      finishedStepBackgroundColor: Colors.transparent,
                      activeStepIconColor: Colors.deepOrange,
                      activeStepTextColor: AppColors.greenColor,
                      unreachedStepTextColor: Colors.orange,
                      showLoadingAnimation: false,
                      steps: (controller.orderDetail?.status == "rejected"
                              ? controller.stepReject
                              : controller.orderDetail?.status == "canceled"
                                  ? controller.stepCancel
                                  : controller.step)
                          .map(
                        (e) {
                          var index = controller.step.indexOf(e);
                          return EasyStep(
                            customStep: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Opacity(
                                opacity: controller.activeStep >= 0 ? 1 : 0.3,
                                child: Image.asset('assets/images/1.png'),
                              ),
                            ),
                            // icon: Icon(CupertinoIcons.cart,color: AppColors.primaryColor,),
                            customTitle: Text(
                              e['step'],
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      color: controller.activeStep >= index
                                          ? AppColors.greenColor
                                          : AppColors.primaryBlack),
                            ),

                            // title: e['step'],

                            // topTitle: index%2 ==0 ? true:false,
                            activeIcon: const Icon(
                              Icons.done_all,
                              color: AppColors.primaryColor,
                            ),
                          );
                        },
                      ).toList(),
                      onStepReached: (index) {
                        controller.activeStep = index;
                      },
                    ),
                  ),
                ),
                // Expanded(child: ListView.builder(itemBuilder: (context, index) => ,))
              ],
            ),
          ),
        )),
      ),
    );
  }

  void _modalBottomSheetMenu(context, width, Orderitem product) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (builder) {
          return Consumer<OrderController>(
            builder: (context, read, child) => StatefulBuilder(
              builder: (context, setState) => SingleChildScrollView(
                child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Center(
                              child: Text(
                            "Leave a Review",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.w600),
                          )),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(
                            color: AppColors.divideColor,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
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
                                        child: MyCacheNetworkImages(
                                          imageUrl:
                                              "$imageURL${product.product?.image}",
                                          radius: 10,
                                          fit: BoxFit.cover,
                                          width: 70,
                                          height: 80,
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
                                            product.product?.name ?? "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                    color: AppColors
                                                        .primaryColor),
                                          ),
                                          Text(
                                            product.product?.description ??
                                                "",
                                            maxLines: 2,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge
                                                ?.copyWith(
                                                    color: AppColors
                                                        .divideColor),
                                          ),
                                          // IntrinsicHeight(
                                          //   child: Row(
                                          //     children: [
                                          //       Text(
                                          //         "Color :",
                                          //         style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                          //             color:  AppColors.primaryColor),
                                          //       ) ,
                                          //       const SizedBox(width: 10,),
                                          //       // Icon(Icons.circle,size: 15,color: Color(datas["color"]),),
                                          //       const VerticalDivider(
                                          //         color: AppColors.divideColor,
                                          //         thickness: 2,
                                          //       ),
                                          //       Text(
                                          //         "Size :",
                                          //         style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                          //             color:  AppColors.primaryColor),
                                          //       ) ,
                                          //       const SizedBox(width: 10,),
                                          //
                                          //       Text(
                                          //         datas["size"],
                                          //         style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                          //             color:  AppColors.primaryColor),
                                          //       ) ,
                                          //
                                          //
                                          //     ],
                                          //   ),
                                          // ),
                                          Text(
                                            "Price :${product.product?.salePrice}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge
                                                ?.copyWith(
                                                    color: AppColors
                                                        .primaryColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: InkWell(
                              onTap: () {
                                read.selectImages();
                              },
                              child: Column(
                                children: [
                                  Container(
                                    width: width * .9,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: read.imageFileList!.isNotEmpty
                                        ? GridView.builder(
                                            shrinkWrap: true,
                                            itemCount:
                                                read.imageFileList!.length,
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 3),
                                            itemBuilder:
                                                (BuildContext context,
                                                    int index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Image.file(
                                                  File(read
                                                      .imageFileList![index]
                                                      .path),
                                                  fit: BoxFit.cover,
                                                  width: 70,
                                                  height: 70,
                                                ),
                                              );
                                            })
                                        : Center(
                                            child: Text(
                                              "Select Image",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge,
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                            ),
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
                          Text(
                            "Please give your rating & also your review...",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                    fontWeight: FontWeight.w100,
                                    color: AppColors.primaryBlack),
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          /// Rating
                          RatingBar(
                              itemSize: 30,
                              initialRating: read.tutorRating,
                              direction: Axis.horizontal,
                              allowHalfRating: false,
                              tapOnlyMode: false,
                              ignoreGestures: false,
                              itemCount: 5,
                              ratingWidget: RatingWidget(
                                  full: Icon(
                                    Icons.star,
                                    color: AppColors.primaryBlack,
                                    size: 18,
                                  ),
                                  half: Icon(
                                    Icons.star_half,
                                    color: AppColors.primaryBlack,
                                    size: 18,
                                  ),
                                  empty: const Icon(
                                    Icons.star_outline,
                                    color: Colors.grey,
                                    size: 18,
                                  )),
                              onRatingUpdate: (value) {
                                setState(() {
                                  read.tutorRating = value;
                                });
                              }),
                          const SizedBox(
                            height: 10,
                          ),

                          const Divider(
                            color: AppColors.divideColor,
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          /// Review
                          ///
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: AppTextFormWidget(
                              hintText: "Enter Your Review",
                              controller: read.reviewController,
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(color: AppColors.divideColor),
                              maxLines: 5,
                            ),
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
                            children: [
                              Expanded(
                                child: AppButton(
                                  height: 40,
                                  bgColor: AppColors.divideColor,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: AppColors.primaryColor),
                                  width: 200,
                                  title: "Cancel",
                                  onTap: () {
                                    read.imageFileList!.clear();
                                    read.reviewController.clear();
                                    read.tutorRating = 0.0;
                                    read.filePaths.clear();
                                    Get.back();
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: AppButton(
                                  height: 40,
                                  width: 200,
                                  title: "Submit",
                                  onTap: () {
                                    var data = ReviewCreate(
                                        productId:
                                            product.productId.toString(),
                                        orderId: product.orderId.toString(),
                                        orderListId: product.id.toString(),
                                        rating: read.tutorRating.toString(),
                                        review: read.reviewController.text,
                                        image: read.imageFileList);
                                    Navigator.pop(context);

                                    read.creadteReview(data, (value) {
                                      if (value) {}
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    )),
              ),
            ),
          );
        });
  }
}

class ReviewCreate {
  String? productId;
  String? orderId;
  String? orderListId;
  String? rating;
  String? review;
  List<File>? image;

  ReviewCreate(
      {this.productId,
      this.orderId,
      this.orderListId,
      this.rating,
      this.review,
      this.image});
}
