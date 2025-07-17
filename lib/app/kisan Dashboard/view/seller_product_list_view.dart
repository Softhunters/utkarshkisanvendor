import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:utkrashvendor/app/Home/controller/home_controller.dart';
import 'package:utkrashvendor/app/kisan%20Dashboard/controller/dashboard_controller.dart';

import '../../../common_widgets/app_colors.dart';
import '../../../common_widgets/urls.dart';
import '../../../constant/cons.dart';
import '../../../widgets/cache_network_image.dart';
import '../../CategoryProduct/product_detail_screen.dart';

class SellerProductListView extends StatefulWidget {
  const SellerProductListView({super.key});

  @override
  State<SellerProductListView> createState() => _SellerProductListViewState();
}

class _SellerProductListViewState extends State<SellerProductListView> {
  double _calculateAspectRatio(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    double screenWidth = MediaQuery.of(context).size.width;

    double childAspectRatio1 = screenHeight / screenWidth * .28;

    return childAspectRatio1;
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
    return Consumer<DashboardController>(builder: (context, controller, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Product List"),
        ),
        body: Padding(
            padding: EdgeInsets.all(16),
            child: GridView.builder(
              itemCount: controller.vendorProductDetail?.products?.data?.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: switch (layoutInfo) {
                  (_, Orientation.landscape) => 3,
                  _ => 2,
                },
                childAspectRatio: _calculateAspectRatio(context),
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
              ),
              itemBuilder: (context, index) {
                var data =
                    controller.vendorProductDetail?.products?.data![index];

                return Consumer<HomeController>(
                    builder: (context, homeController, _) {
                  return GestureDetector(
                    onTap: () {
                      homeController.changePriceWithIndex(data?.id);
                      homeController.saveProductDetailslug(data?.slug);
                      homeController.getProductDetail(data?.slug, 0);
                      Get.to(() => ProductDetailScreen(
                            productSlug: data?.slug ?? "",
                            id: data?.id ?? 0,
                          ));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                MyCacheNetworkImages(
                                  imageUrl: "$imageURL${data?.image}",
                                  height: switch (layoutInfo) {
                                    (
                                      ScreenSize.large || ScreenSize.extraLarge,
                                      _
                                    ) =>
                                      height * .25,
                                    (_, Orientation.landscape) => width * .86,
                                    _ => width * .43,
                                  },
                                  width: width,
                                  radius: 5,
                                  fit: BoxFit.cover,
                                ),
                                data?.wishlistAvgUserId == "null"
                                    ? Positioned(
                                        top: 5,
                                        right: 5,
                                        child: Consumer<HomeController>(builder:
                                            (context, homeController, _) {
                                          return GestureDetector(
                                            onTap: () {
                                              homeController.addWishlistProduct(
                                                  data?.id,
                                                  1,
                                                  data?.seller?.vendorId
                                                          .toString() ??
                                                      '');
                                            },
                                            child: const Icon(
                                              Icons.favorite_border,
                                              color: AppColors.yellowishColor,
                                            ),
                                          );
                                        }),
                                      )
                                    : Positioned(
                                        top: 5,
                                        right: 5,
                                        child: Consumer<HomeController>(builder:
                                            (context, homeController, _) {
                                          return GestureDetector(
                                            onTap: () {
                                              homeController.addWishlistProduct(
                                                  data?.id,
                                                  1,
                                                  data?.seller?.vendorId
                                                          .toString() ??
                                                      '');
                                            },
                                            child: const Icon(
                                              Icons.favorite,
                                              color: AppColors.yellowishColor,
                                            ),
                                          );
                                        }),
                                      ),
                                if (data?.reviewsCount != 0)
                                  Positioned(
                                    bottom: 8,
                                    left: 10,
                                    child: Container(
                                      height: 22,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: AppColors.transparentColor,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: IntrinsicHeight(
                                          child: Row(
                                            children: [
                                              const SizedBox(width: 4),
                                              Row(
                                                children: [
                                                  Text(
                                                    double.parse(
                                                            data?.reviewsAvgRating !=
                                                                    "null"
                                                                ? data?.reviewsAvgRating ??
                                                                    "0.0"
                                                                : "0.0")
                                                        .toStringAsFixed(1),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelSmall,
                                                  ),
                                                  const Icon(
                                                    Icons.star,
                                                    size: 12,
                                                    color: AppColors.green,
                                                  ),
                                                ],
                                              ),
                                              const VerticalDivider(
                                                color: AppColors.grey1,
                                                thickness: 2,
                                              ),
                                              const SizedBox(width: 4),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                if (data?.discountValue != "0" &&
                                    data?.discountValue != "null")
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.indigo,
                                            Colors.purple.shade300,
                                          ],
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          bottomRight:
                                              Radius.elliptical(15, 20),
                                          topLeft: Radius.circular(10),
                                        ),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 4),
                                          child: Text(
                                            "${data?.discountValue}% ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall
                                                ?.copyWith(
                                                    color: AppColors.white,
                                                    fontSize: 9),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data?.brands?.brandName ?? "",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(color: AppColors.green),
                                  ),
                                  Text(
                                    data?.name ?? "",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            color: AppColors.primaryBlack),
                                  ),
                                  const SizedBox(height: 2),
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "₹${double.tryParse((data?.salePrice ?? " "))}",
                                            maxLines: 1,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall
                                                ?.copyWith(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ],
                                      ),
                                      if ((double.tryParse(
                                              data?.salePrice ?? " ")) !=
                                          double.tryParse(
                                              data?.regularPrice ?? " "))
                                        Row(
                                          children: [
                                            Text(
                                              "₹${data?.regularPrice ?? " "}",
                                              maxLines: 1,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall
                                                  ?.copyWith(
                                                    fontSize: 7,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    color: AppColors.redColor,
                                                  ),
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              "${data?.discountValue}% off",
                                              maxLines: 1,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall,
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    data?.stockStatus == "instock"
                                        ? "In Stock"
                                        : "Out Of Stock",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                          fontSize: 10,
                                          color: data?.stockStatus == "instock"
                                              ? AppColors.green
                                              : AppColors.redColor,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
              },
            )),
      );
    });
  }
}
