import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/app_colors.dart';
import '../../../common_widgets/urls.dart';
import '../../../constant/cons.dart';
import '../../../widgets/cache_network_image.dart';
import '../../Brand/controller/brand_controller.dart';
import '../../Brand/view/brand_product.dart';
import '../controller/home_controller.dart';

class AllBrand extends StatelessWidget {
  const AllBrand({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    final screenSize = ScreenUtils.getScreenSize(context);
    final orientation = MediaQuery.orientationOf(context);
    final layoutInfo = (screenSize, orientation);
    var isBigDevice = ScreenUtils.isBigDevice(screenSize);
    if (isBigDevice) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      });
    }
    var provider = Provider.of<HomeController>(context, listen: false);
    var brandController = Provider.of<BrandController>(context, listen: false);


    return Consumer<HomeController>(
      builder: (context, controller, child) => Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                // controller.setFavIndex(null);
                // controller.filterCateProduct(null);
                Get.back();
              },
              child: const Icon(Icons.arrow_back)),
          title: Text("All Brand",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w500)),
          centerTitle: false,
          elevation: 0,
          surfaceTintColor: AppColors.white,
        ),
        body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Visibility(
                visible: controller.brands.isNotEmpty,
                replacement: Center(
                  child: Text(
                    "Brand Not available",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                child: Container(
                  // height: height * .54,
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: controller.brands.length,
                      physics: const AlwaysScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: .70,
                          crossAxisSpacing: 23,
                          mainAxisSpacing:10),
                      itemBuilder: (context, index) {
                        var data = controller.brands[index];

                        return GestureDetector(
                          onTap: () {
                            controller.setFavIndex(index);
                            brandController.getBrandDAta(data.brandSlug ?? "");
                            Get.to(()=>const BrandProductScreen());

                            // Get.to( ProductDetailScreen(productSlug:  data.slug ??"",));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              // color: AppColors.textFieldColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20)),
                                      child: MyCacheNetworkImages(
                                        imageUrl: "$brandURL${data.brandImage}",
                                        height: switch (layoutInfo) {
                                          (ScreenSize.large || ScreenSize.extraLarge, _) => height * .25,
                                          (_, Orientation.landscape) => height * .9, _ => height * .1
                                        },
                                        width: width,
                                        radius: 20,
                                        fit: BoxFit.cover,
                                        // color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                        const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                data.brandName ?? "",
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall?.copyWith(color: AppColors.primaryBlack,fontSize: 13),
                                              ),
                                            ),
                                            // Expanded(
                                            //   flex: 1,
                                            //   child: Text(
                                            //     data["regular_price"],
                                            //     maxLines: 1,
                                            //     style: Theme.of(context)
                                            //         .textTheme
                                            //         .labelSmall
                                            //         ?.copyWith(
                                            //             decoration:
                                            //                 TextDecoration.lineThrough,
                                            //             color: AppColors.redColor),
                                            //   ),
                                            // ),
                                            // Expanded(
                                            //   flex: 1,
                                            //   child: Text(
                                            //     data.salePrice ??"",
                                            //     maxLines: 1,
                                            //     style: Theme.of(context)
                                            //         .textTheme
                                            //         .labelSmall,
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                      // IntrinsicHeight(
                                      //   child: Row(
                                      //     children: [
                                      //       const Icon(
                                      //         Icons.star,
                                      //         size: 12,
                                      //         color: AppColors.ratingBGColor,
                                      //       ),
                                      //       Text(
                                      //         3.toString(),
                                      //         style:
                                      //         Theme.of(context).textTheme.labelSmall,
                                      //       ),
                                      //       const VerticalDivider(
                                      //         color: AppColors.divideColor,
                                      //         thickness: 2,
                                      //       ),
                                      //       if ("soldItem" == "b")
                                      //         Container(
                                      //           decoration: BoxDecoration(
                                      //               color: AppColors.divideColor,
                                      //               borderRadius:
                                      //               BorderRadius.circular(5)),
                                      //           child: Padding(
                                      //             padding: const EdgeInsets.symmetric(
                                      //                 horizontal: 8.0, vertical: 2),
                                      //             child: Text(
                                      //               "${"soldItem"} Sold",
                                      //               style: Theme.of(context)
                                      //                   .textTheme
                                      //                   .labelSmall,
                                      //             ),
                                      //           ),
                                      //         )
                                      //     ],
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );

                        /*AppGridWidget(
                        onTap: () {
                          Get.to(ProductDetailScreen());
                        },
                        imageUrl: "$baseURL${data["image"]}",
                        productTitle: data['name'],
                        tutorRating: 3.5,
                        soldItem: "123",
                        height: height, width: width

                        );*/
                      },
                    )),
              ),
            )),
      ),
    );
  }
}
