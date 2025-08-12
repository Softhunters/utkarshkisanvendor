import 'package:currency_converter/currency.dart';
import 'package:utkrashvendor/app/CartSection/Controller/cart_controller.dart';
import 'package:utkrashvendor/app/Home/controller/home_controller.dart';
import 'package:utkrashvendor/app/Home/widget/home_slider.dart';
import 'package:utkrashvendor/app/Search/search_screen.dart';
import 'package:utkrashvendor/app/Wishlist/wishlist_screen.dart';
import 'package:utkrashvendor/common_widgets/app_colors.dart';
import 'package:utkrashvendor/common_widgets/urls.dart';
import 'package:utkrashvendor/widgets/text_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../constant/cons.dart';
import '../../../widgets/cache_network_image.dart';
import '../../Brand/controller/brand_controller.dart';
import '../../Brand/view/brand_product.dart';
import '../../CategoryProduct/all_featured_screen.dart';
import '../../CategoryProduct/category_product_screen.dart';
import '../../CategoryProduct/latest_product_screen.dart';
import '../../CategoryProduct/product_detail_screen.dart';
import '../../Offer/view/all_offer_screen.dart';
import 'all_brand.dart';
import 'all_category_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
  });

  String firstSagment = '';
  String secondSagment = '';
  String thirdSagment = '';

  void fetchSagmentKeyword(String? urlLink) {
    final url = Uri.parse("${urlLink}");

    // Get all segments between slashes
    List<String> segments = url.pathSegments;

    // Output
    for (var segment in segments) {
      firstSagment = segments.length > 0 ? segments[0] : '';
      secondSagment = segments.length > 1 ? segments[1] : '';
      thirdSagment = segments.length > 2 ? segments[2] : '';
    }
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HomeController>(context, listen: false);
    provider.getHomeData(1);
    var brandController = Provider.of<BrandController>(context, listen: false);
    var cartController = Provider.of<CartController>(context, listen: false);

    cartController.getCartDAta();

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
    double height = MediaQuery.sizeOf(context).height;

    return Consumer<HomeController>(
      builder: (context, controller, child) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Visibility(
              visible: !controller.isLoading,
              replacement: const Center(
                child: CupertinoActivityIndicator(),
              ),
              child: RefreshIndicator(
                onRefresh: () => controller.getHomeData(1),
                child: ListView(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const SearchScreen());
                      },
                      child: AppTextFormWidget(
                        enable: false,
                        hintText: "search",
                        controller: controller.searchController,
                        prifixIcon: const Icon(
                          Icons.search,
                          color: AppColors.divideColor,
                        ),
                        hintStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.divideColor,
                        ),
                        sufixIcon: const Icon(FontAwesomeIcons.sliders),
                      ),
                    ),
                    if (controller.sliders.isNotEmpty)
                      sliderImage(context, controller, layoutInfo),
                    gridItem(context, controller, layoutInfo),
                    mostPopularItem(context, height, width, controller,
                        layoutInfo, brandController)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget sliderImage(context, controller, layoutInfo) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text(
        //       "Special Offer",
        //       style: Theme.of(context)
        //           .textTheme
        //           .bodyLarge
        //           ?.copyWith(fontWeight: FontWeight.w700, fontSize: 16),
        //     ),
        //     GestureDetector(
        //       onTap: () {
        //         Get.to(() => const AllOfferScreen());
        //       },
        //       child: Text("See All",
        //           style: Theme.of(context)
        //               .textTheme
        //               .bodySmall
        //               ?.copyWith(color: AppColors.primaryColor)),
        //     ),
        //   ],
        // ),
        const SizedBox(
          height: 10,
        ),
        HomeSlider(
          banner: controller.sliders,
          height: switch (layoutInfo) {
            (_, Orientation.landscape) => 200,
            _ => 120
          },
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget gridItem(BuildContext context, HomeController controller, layoutInfo) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Category",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => const AllCategoryListScreen());
              },
              child: Text("See All",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColors.primaryColor)),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          width: MediaQuery.sizeOf(context).width,
          height: 90,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: controller.mixedList.length,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              final data = controller.mixedList[index];
              return data.isHome == "1"
                  ? Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          String catId = data.categoryId ?? "null";
                          String? slug =
                              catId != "null" ? data.cname : data.slug;

                          if (catId == "null") {
                            controller.setcatFavIndex("null", slug, "null");
                            controller.getCategoryData(slug, 0);
                            controller.setCategoryBySlug(slug ?? "");
                          } else {
                            controller.setcatFavIndex(
                                data.slug, slug, data.slug);
                            controller.setCategoryBySlug(slug ?? "");
                            controller.getSubCategoryData(slug, data.slug, 0);
                          }

                          Get.to(() => CategoryProduct(
                                //   categoryName: data.name ?? "",
                                cateSlug: slug ?? "",
                              ));
                        },
                        child: Container(
                          width: 87,
                          height: 90,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all()),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: AppColors.textFieldColor,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Image.network(
                                    "$cateImageURL${data.icon}",
                                    height:
                                        MediaQuery.sizeOf(context).width * .11,
                                    // width: MediaQuery.sizeOf(context).width * .1,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  data.name.toString(),
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  : SizedBox();
            },
          ),
        ),
      ],
    );
  }

  Widget mostPopularItem(context, height, width, HomeController controller,
      layoutInfo, BrandController brandController) {
    // var currencyProvider =
    //     Provider.of<CurrencyProvider>(context, listen: false);
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "More Brand to explore",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => const AllBrand());
              },
              child: Text("See All",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColors.primaryColor)),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 30,
          child: ListView.builder(
            itemCount: controller.brands.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              var data = controller.brands[index];
              bool isSelected = controller.favoriteIndex == index;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: GestureDetector(
                  onTap: () {
                    controller.setFavIndex(index);
                    brandController.getBrandDAta(data.brandSlug ?? "");

                    Get.to(() => const BrandProductScreen());
                  },
                  child: Container(
                    height: 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.primaryColor),
                        color: isSelected == true
                            ? AppColors.primaryColor
                            : AppColors.white),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Center(
                        child: Text(
                          data.brandName ?? "",
                          style: isSelected == true
                              ? Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(color: AppColors.white)
                              : Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        featuredProduct(
          context,
          height,
          width,
          controller,
          layoutInfo,
        ),
        const Divider(
          color: AppColors.divideColor,
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: MediaQuery.sizeOf(context).height *
              switch (layoutInfo) {
                (_, Orientation.landscape) => .35,
                _ => .1
              },
          child: ListView.builder(
            itemCount: controller.banner.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              var data = controller.banner[index];
              bool isSelected = controller.favoriteIndex == index;
              return GestureDetector(
                onTap: () async {
                  fetchSagmentKeyword(data.link);

                  if (firstSagment == "category" && thirdSagment == "") {
                    await controller.getCategoryData(secondSagment, 0);
                    controller.setCategoryBySlug(secondSagment ?? "");
                    Get.to(() => CategoryProduct(cateSlug: secondSagment));
                  } else if (firstSagment == "category" && thirdSagment != "") {
                    await controller.getSubCategoryData(
                        secondSagment, thirdSagment, 0);
                    controller.setCategoryBySlug(secondSagment ?? "");
                    Get.to(() => CategoryProduct(cateSlug: secondSagment));
                  } else if (firstSagment == "product-detail" &&
                      thirdSagment == "") {
                    await controller.saveProductDetailslug(secondSagment);
                    await controller.getProductDetail(secondSagment, 0);
                    Get.to(() => ProductDetailScreen(
                          productSlug: secondSagment,
                          id: 0,
                        ));
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: MyCacheNetworkImages(
                    imageUrl: "$bannerURL${data.images}",
                    radius: 20,
                    fit: BoxFit.cover,
                    width: MediaQuery.sizeOf(context).width *
                        switch (layoutInfo) {
                          (_, Orientation.landscape) => .68,
                          _ => .9
                        },
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Latest Product",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            GestureDetector(
              onTap: () {
                controller.getShopProductData(1);
                // controller.getShopProductData(0);
                Get.to(() => const LatestProductScreen());
              },
              child: Text("See All",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColors.primaryColor)),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
            // height: height * .54,
            child: GridView.builder(
          itemCount: controller.featureProducts.length > 8
              ? 8
              : controller.allProducts.length > 6
                  ? 6
                  : controller.allProducts.length,
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
            var data = controller.allProducts[index];

            return GestureDetector(
              onTap: () {
                controller.changePriceWithIndex(data.id);
                controller.saveProductDetailslug(data.slug);
                controller.getProductDetail(data.slug, 0);
                print("aaaaaaa ${data.slug}");
                Get.to(() => ProductDetailScreen(
                      productSlug: data.slug ?? "",
                      id: data.id ?? 0,
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
                            imageUrl: "$imageURL${data.image}",
                            height: switch (layoutInfo) {
                              (ScreenSize.large || ScreenSize.extraLarge, _) =>
                                height * .25,
                              (_, Orientation.landscape) => width * .86,
                              _ => width * .43,
                            },
                            width: width,
                            radius: 5,
                            fit: BoxFit.cover,
                          ),
                        if(data.seller!=null)
                          data.wishlistAvgUserId == "null"
                              ? Positioned(
                            top: 5,
                            right: 5,
                            child: GestureDetector(
                              onTap: () {
                                controller.addWishlistProduct(
                                    data.id,
                                    1,
                                    data.seller?.venderId.toString() ??
                                        '1');
                              },
                              child: const Icon(
                                Icons.favorite_border,
                                color: AppColors.yellowishColor,
                              ),
                            ),
                          )
                              : Positioned(
                            top: 5,
                            right: 5,
                            child: GestureDetector(
                              onTap: () {
                                controller.addWishlistProduct(
                                    data.id,
                                    1,
                                    data.seller?.venderId.toString() ??
                                        '');
                              },
                              child: const Icon(
                                Icons.favorite,
                                color: AppColors.yellowishColor,
                              ),
                            ),
                          ),
                          if (data.reviewsCount != 0)
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
                                              double.parse(data
                                                              .reviewsAvgRating !=
                                                          "null"
                                                      ? data.reviewsAvgRating ??
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
                                        Text(
                                          controller.formatValue(
                                              data.reviewsCount ?? 0),
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall
                                              ?.copyWith(fontSize: 11),
                                        ),
                                        const SizedBox(width: 4),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          if (data.discountValue != "0" &&
                              data.discountValue != "null")
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
                                    bottomRight: Radius.elliptical(15, 20),
                                    topLeft: Radius.circular(10),
                                  ),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    child: Text(
                                      "${data.discountValue}% ",
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
                              data.brands?.brandName ?? "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: AppColors.green),
                            ),
                            Text(
                              data.name ?? "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: AppColors.primaryBlack),
                            ),
                            const SizedBox(height: 2),
                            Consumer<CurrencyProvider>(
                              builder: (context, currencyProvider, child) =>
                                  FutureBuilder<double>(
                                future: currencyProvider.selectedCurrency ==
                                        Currency.usd
                                    ? currencyProvider.convertToUSD(
                                        double.parse(data.salePrice ?? "0.0"))
                                    : Future.value(
                                        double.parse(data.salePrice ?? "0.0")),
                                builder: (context, salePriceSnapshot) {
                                  if (!salePriceSnapshot.hasData) {
                                    return Text("loading");
                                  }
                                  double salePrice =
                                      salePriceSnapshot.data ?? 0.0;
                                  return FutureBuilder<double>(
                                    future: currencyProvider.selectedCurrency ==
                                            Currency.usd
                                        ? currencyProvider.convertToUSD(
                                            double.parse(
                                                data.regularPrice ?? "0.0"))
                                        : Future.value(double.parse(
                                            data.regularPrice ?? "0.0")),
                                    builder: (context, regularPriceSnapshot) {
                                      if (!regularPriceSnapshot.hasData) {
                                        return const CircularProgressIndicator();
                                      }
                                      double regularPrice =
                                          regularPriceSnapshot.data ?? 0.0;
                                      return Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "₹${double.tryParse((data.salePrice ?? " "))?.toStringAsFixed(2)}",
                                                maxLines: 1,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall
                                                    ?.copyWith(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                              ),
                                            ],
                                          ),
                                          if (salePrice != regularPrice)
                                            Row(
                                              children: [
                                                Text(
                                                  "₹${double.tryParse(data.regularPrice ?? " ")?.toStringAsFixed(2)}",
                                                  maxLines: 1,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelSmall
                                                      ?.copyWith(
                                                        fontSize: 7,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        color:
                                                            AppColors.redColor,
                                                      ),
                                                ),
                                                SizedBox(
                                                  width: 2,
                                                ),
                                                Text(
                                                  "${data.discountValue}% off",
                                                  maxLines: 1,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelSmall,
                                                ),
                                              ],
                                            ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              data.stockStatus == "instock"
                                  ? "In Stock"
                                  : "Out Of Stock",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    fontSize: 10,
                                    color: data.stockStatus == "instock"
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
          },
        )),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }

  double _calculateAspectRatio(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    double screenWidth = MediaQuery.of(context).size.width;

    double childAspectRatio1 = screenHeight / screenWidth * .28;

    return childAspectRatio1;
  }

  featuredProduct(
    context,
    height,
    width,
    HomeController controller,
    layoutInfo,
  ) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Feature Product",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            // GestureDetector(
            //   onTap: () {
            //     // Get.to(const LatestProductScreen());
            //   },
            //   child: Text("See All",
            //       style: Theme.of(context)
            //           .textTheme
            //           .bodySmall
            //           ?.copyWith(color: AppColors.primaryColor)),
            // ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        GridView.custom(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverQuiltedGridDelegate(
            crossAxisCount: 4,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            repeatPattern: QuiltedGridRepeatPattern.same,
            pattern: [
              const QuiltedGridTile(2, 2),
              const QuiltedGridTile(1, 1),
              const QuiltedGridTile(1, 1),
              const QuiltedGridTile(1, 1),
              const QuiltedGridTile(1, 1),
            ],
          ),
          childrenDelegate: SliverChildBuilderDelegate(
            childCount: controller.featureProducts.length > 5
                ? 5
                : controller.featureProducts.length,
            (context, index) {
              final data = controller.featureProducts[index];
              return GestureDetector(
                onTap: () {
                  controller.getShopProductData(1);
                  Get.to(() => const AllFeatureProductScreen());
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: MyCacheNetworkImages(
                    imageUrl: "$imageURL${data.image}",
                    height: switch (layoutInfo) {
                      (ScreenSize.large || ScreenSize.extraLarge, _) =>
                        height * .21,
                      (_, Orientation.landscape) => height * .4,
                      _ => height * .24
                    },
                    width: width * .95,
                    radius: 5,
                    fit: BoxFit.fitHeight,
                    // color: AppColors.primaryColor,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
