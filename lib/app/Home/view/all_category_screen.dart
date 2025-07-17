import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/app_colors.dart';
import '../../../common_widgets/urls.dart';
import '../../../constant/cons.dart';
import '../../../widgets/cache_network_image.dart';
import '../../CategoryProduct/category_product_screen.dart';
import '../controller/home_controller.dart';

class AllCategoryListScreen extends StatelessWidget {
  const AllCategoryListScreen({super.key});

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
          title: Text("All Category",
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
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Visibility(
            visible: controller.categoryList.isNotEmpty,
            replacement: Center(
              child: Text(
                "Category Not available",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            child: GridView.builder(
              itemCount: controller.categoryList.length,
              physics: const AlwaysScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: switch (layoutInfo) {
                    (_, Orientation.landscape) => 5,
                    _ => 4
                  },
                  childAspectRatio: .6,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4),
              itemBuilder: (context, index) {
                var data = controller.categoryList[index];

                return GestureDetector(
                  onTap: () {
                    var catId = data.categoryId;

                    var slug = catId == null ? data.cname : data.slug;

                    if (catId == "null") {
                      controller.getCategoryData(slug, 0);
                    } else {
                      controller.getSubCategoryData(
                          controller.categorySlug, slug,0);
                    }
                    Get.to(()=>CategoryProduct(
                     // categoryName: data.name ?? "",
                      cateSlug: slug ??"",
                    ));
                  },
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: MyCacheNetworkImages(
                              imageUrl: "$cateImageURL${data.icon}",
                              height: switch (layoutInfo) {
                                (
                                  ScreenSize.large || ScreenSize.extraLarge,
                                  _
                                ) =>
                                  height * .22,
                                (_, Orientation.landscape) => height * .24,
                                _ => height * .065
                              },
                              width: width,
                              radius: 20,
                              fit: BoxFit.contain,
                              // color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 2,
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
                                        data.name ?? "",
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                                color: AppColors.primaryBlack),
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
              },
            ),
          ),
        )),
      ),
    );
  }
}
