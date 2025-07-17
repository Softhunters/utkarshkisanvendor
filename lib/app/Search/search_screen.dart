import 'package:utkrashvendor/common_widgets/urls.dart';
import 'package:utkrashvendor/widgets/app_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../common_widgets/app_colors.dart';
import '../../constant/cons.dart';
import '../../widgets/cache_network_image.dart';
import '../../widgets/grid_widget.dart';
import '../../widgets/text_fields.dart';
import '../CategoryProduct/product_detail_screen.dart';
import '../Home/controller/home_controller.dart';
import 'controller/search_controller.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    var provider = Provider.of<HomeController>(context, listen: false);

    return Consumer<SearchScreenController>(
      builder: (context, controller, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          surfaceTintColor: AppColors.white,
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                controller.back();
              },
              child: const Icon(Icons.arrow_back)),
          title: Text("",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w500)),
          centerTitle: false,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                AppTextFormWidget(
                  enable: true,
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
                  // sufixIcon: GestureDetector(
                  //     onTap: () {
                  //       _modalBottomSheetMenu(context, controller);
                  //     },
                  //     child: const Icon(FontAwesomeIcons.sliders)),
                    onChanged: (value) {
                      controller.pageNo1 = 1; // 🔥 REQUIRED for new search
                      final data = ApplyFilterModel(
                        filterBrand: [],
                        filterMinPrice: "",
                        filterMaxPrice: "",
                        filterSortBy: "",
                        filterDiscount: "",
                      );
                      controller.saveController(value);
                      controller.searchedProduct(searchType, value, data, (values) {});
                    },

                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: width * .7,
                      child: Text(
                        controller.searchController.text.isEmpty
                            ? "Recent"
                            : 'Result "${controller.searchController.text}"',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                    ),
                    // Text("See All",
                    //     style: Theme.of(context)
                    //         .textTheme
                    //         .bodySmall
                    //         ?.copyWith(color: AppColors.primaryColor)),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                // if (controller.searchController.text == "Bag")
                _searchItem(controller, height, width, provider),
                if (controller.searchProductLoading)
                  Center(
                    child: CupertinoActivityIndicator(),
                  ),
                SizedBox(
                  height: 5,
                )
              ],
            ),
          )),
        ),
      ),
    );
  }

  bool isShow = false;

  void _modalBottomSheetMenu(
    context,
    SearchScreenController controller,
  ) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (builder) {
          return StatefulBuilder(
            builder: (context, setState) => SizedBox(
              // height: 550.0,
              // color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Center(
                            child: Text(
                          "Sort & Filter",
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
                        Text(
                          "Brands",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 50,
                          child: ListView.builder(
                            itemCount: cate.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var data = cate[index];
                              bool isSelected =
                                  controller.favoriteIndex.contains(index);
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (isSelected) {
                                        controller.favoriteIndex.remove(index);
                                        controller.selectedBrands
                                            .remove(data.id);
                                      } else {
                                        controller.favoriteIndex.add(index);
                                        controller.selectedBrands.add(data.id!);
                                      }
                                    });
                                  },
                                  child: Container(
                                    height: 20,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                          color: AppColors.primaryColor),
                                      color: isSelected
                                          ? AppColors.primaryColor
                                          : AppColors.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: Center(
                                        child: Text(
                                          data.brandName ?? "",
                                          style: isSelected
                                              ? Theme.of(context)
                                                  .textTheme
                                                  .labelSmall
                                                  ?.copyWith(
                                                    color: AppColors.white,
                                                  )
                                              : Theme.of(context)
                                                  .textTheme
                                                  .labelSmall,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Price Range",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        RangeSlider(
                          values: controller.values,
                          min: 0,
                          max: 5000,
                          divisions: 500,
                          activeColor: AppColors.primaryColor,
                          inactiveColor: AppColors.divideColor,
                          labels: RangeLabels(
                            controller.values.start.round().toString(),
                            controller.values.end.round().toString(),
                          ),
                          onChanged: (RangeValues values) {
                            setState(() {
                              controller.priceLow =
                                  values.start.round().toString();
                              controller.priceHigh =
                                  values.end.round().toString();

                              if (values.end - values.start >= 20) {
                                controller.values = values;
                              } else {
                                if (controller.values.start == values.start) {
                                  controller.values = RangeValues(
                                      controller.values.start,
                                      controller.values.start + 20);
                                } else {
                                  controller.values = RangeValues(
                                      controller.values.end - 20,
                                      controller.values.end);
                                }
                              }
                            });
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        /*  Text(
                          "Sort By",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 50,
                          child: ListView.builder(
                            itemCount: controller.sort.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var data = controller.sort[index];
                              bool isSelected = controller.sortIndex == index;
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      controller.sortby = data;
                                      controller.setSortIndex(index);
                                    });
                                  },
                                  child: Container(
                                    height: 20,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                            color: AppColors.primaryColor),
                                        color: isSelected == true
                                            ? AppColors.primaryColor
                                            : AppColors.white),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: Center(
                                        child: Text(
                                          data,
                                          style: isSelected == true
                                              ? Theme.of(context)
                                                  .textTheme
                                                  .labelSmall
                                                  ?.copyWith(
                                                      color: AppColors.white)
                                              : Theme.of(context)
                                                  .textTheme
                                                  .labelSmall,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),*/
                        Text(
                          "Discounts",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 50,
                          child: ListView.builder(
                            itemCount: controller.rate.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var data = controller.rate[index];
                              bool isSelected = controller.ratingIndex == index;
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      controller.discounts = data;
                                      controller.setRatingIndex(index);
                                    });
                                  },
                                  child: Container(
                                    height: 20,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                            color: AppColors.primaryColor),
                                        color: isSelected == true
                                            ? AppColors.primaryColor
                                            : AppColors.white),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: Center(
                                        child: Row(
                                          children: [
                                            Text(
                                              "$data %",
                                              style: isSelected == true
                                                  ? Theme.of(context)
                                                      .textTheme
                                                      .labelLarge
                                                      ?.copyWith(
                                                          color:
                                                              AppColors.white)
                                                  : Theme.of(context)
                                                      .textTheme
                                                      .labelSmall,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
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
                                title: "Reset",
                                onTap: () {
                                  searchType = 0;
                                  final data = ApplyFilterModel(
                                      filterBrand: [],
                                      filterMinPrice: "",
                                      filterMaxPrice: "",
                                      filterSortBy: "",
                                      filterDiscount: "");
                                  Get.back();
                                  controller.searchedProduct(
                                      searchType,
                                      controller.searchController.text,
                                      data,
                                      (value) {});
                                  controller.favoriteIndex.clear();
                                  controller.selectedBrands.clear();
                                  controller.values =
                                      const RangeValues(0, 5000);
                                  controller.setSortIndex(null);
                                  controller.setRatingIndex(null);
                                  controller.selectedBrands = [];
                                  controller.priceLow = 0.toString();
                                  controller.priceHigh = "5000";
                                  controller.sortby = "";
                                  controller.discounts = "";
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
                                title: "Apply",
                                onTap: () {
                                  searchType = 1;
                                  final data = ApplyFilterModel(
                                      filterBrand: controller.selectedBrands,
                                      filterMinPrice: controller.priceLow,
                                      filterMaxPrice: controller.priceHigh,
                                      filterSortBy: controller.sortby,
                                      filterDiscount: controller.discounts);

                                  Navigator.pop(context);
                                  controller.searchedProduct(
                                    searchType,
                                    controller.searchController.text,
                                    data,
                                    (value) {
                                      if (value == true) {
                                        searchType = 0;
                                        controller.favoriteIndex.clear();
                                        controller.selectedBrands.clear();
                                        controller.values =
                                            const RangeValues(0, 5000);
                                        controller.setSortIndex(null);
                                        controller.setRatingIndex(null);
                                        controller.selectedBrands = [];
                                        controller.priceLow = 0.toString();
                                        controller.priceHigh = "10000";
                                        controller.sortby = "default";
                                        controller.discounts = "";
                                      }
                                    },
                                  );
                                  // controller.searchProduct.where((element) => element[]);
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    )),
              ),
            ),
          );
        });
  }

  int searchType = 0;

  _searchItem(SearchScreenController controller, double height, double width,
      HomeController provider) {
    final screenSize = ScreenUtils.getScreenSize(context);
    final orientation = MediaQuery.orientationOf(context);
    final layoutInfo = (screenSize, orientation);
    var isBigDevice = ScreenUtils.isBigDevice(screenSize);
    if (isBigDevice) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      });
    }
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels ==
            notification.metrics.maxScrollExtent) {
          if (!controller.isFetching) {
            controller.setValue(true, true);
            if (controller.totalShopProduct! >
                controller.searchProduct.length) {
              controller.setPage();
            }
            final data = ApplyFilterModel(
                filterBrand: controller.selectedBrands,
                filterMinPrice: controller.priceLow,
                filterMaxPrice: controller.priceHigh,
                filterSortBy: controller.sortby,
                filterDiscount: controller.discounts);

            controller.searchedProduct(
              1,
              controller.searchController.text,
              data,
              (value) {},
            );
            Future.delayed(const Duration(seconds: 1))
                .then((value) => controller.setValue(false, false));
          }
        }
        return false;
      },
      child: Expanded(
          // height: height * .54,
          child: Visibility(
        visible: controller.searchProduct.isNotEmpty,
        replacement: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 35,
            ),
            Image.asset(
              "assets/images/search1.png",
              width: width * .6,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Not Found",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Start typing to explore thousands of quality agricultural products tailored to your needs.",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: AppColors.divideColor),
            )
          ],
        ),
        child: GridView.builder(
          itemCount: controller.searchProduct.length,
          physics: const AlwaysScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: switch (layoutInfo) {
                (_, Orientation.landscape) => 3,
                _ => 2
              },
              childAspectRatio: _calculateAspectRatio(context),
              crossAxisSpacing: 0,
              mainAxisSpacing: 0),
          itemBuilder: (context, index) {
            var data = controller.searchProduct[index];
            return Consumer<HomeController>(
              builder: (context, homeController, child) => GestureDetector(
                onTap: () {
                  homeController.changePriceWithIndex(data.id);
                  homeController.saveProductDetailslug(data.slug);
                  homeController.getProductDetail(data.slug, 0);

                  Get.to(() => ProductDetailScreen(
                        productSlug: data.slug!,
                        id: data.id ?? 0,
                      ));
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            MyCacheNetworkImages(
                              imageUrl: "$imageURL${data.image}",
                              // imageUrl: "https://5.imimg.com/data5/SELLER/Default/2022/4/CR/WD/AE/47199006/pedigree-normal-500x500.jpg",
                              height: switch (layoutInfo) {
                                (
                                  ScreenSize.large || ScreenSize.extraLarge,
                                  _
                                ) =>
                                  height * .25,
                                (_, Orientation.landscape) => width * .86,
                                _ => width * .43
                              },
                              width: width,
                              radius: 15,
                              fit: BoxFit.cover,
                              // color: AppColors.primaryColor,
                            ),
                            data.wishlistAvgUserId == "null"
                                ? Positioned(
                                    top: 5,
                                    right: 5,
                                    child: GestureDetector(
                                        onTap: () {
                                          controller.addWishlistProduct1(
                                            data.id,
                                            (value) {
                                              if (value == true) {
                                                homeController
                                                    .getWishlistProduct(0);
                                              }
                                            },
                                          );
                                        },
                                        child: const Icon(
                                          Icons.favorite_border,
                                          color: AppColors.yellowishColor,
                                        )))
                                : Positioned(
                                    top: 5,
                                    right: 5,
                                    child: GestureDetector(
                                        onTap: () {
                                          controller.addWishlistProduct1(
                                            data.id,
                                            (value) {
                                              if (value == true) {
                                                homeController
                                                    .getWishlistProduct(0);
                                              }
                                            },
                                          );
                                        },
                                        child: const Icon(
                                          Icons.favorite,
                                          color: AppColors.yellowishColor,
                                        ))),
                            Positioned(
                                bottom: 8,
                                left: 10,
                                child: GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      height: 22,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: AppColors.transparentColor),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: IntrinsicHeight(
                                          child: Row(
                                            children: [
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    3.toString(),
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
                                              if ("soldItem" != "0")
                                                Text(
                                                  provider.formatValue(678598),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelSmall
                                                      ?.copyWith(fontSize: 11),
                                                ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ))),
                          ],
                        ),
                        // const SizedBox(
                        //   height: 5,
                        // ),
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
                                    .bodyMedium
                                    ?.copyWith(color: AppColors.primaryBlack),
                              ),
                              // const SizedBox(
                              //   height: 4,
                              // ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "₹${data.salePrice ?? ""}",
                                    maxLines: 1,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "₹${data.regularPrice ?? " "}",
                                    maxLines: 1,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                            fontSize: 8,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            color: AppColors.redColor),
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    "${data.discountValue}% off",
                                    maxLines: 1,
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 4,
                              ),
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
                                            : AppColors.redColor),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      )),
    );
  }

  double _calculateAspectRatio(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    double screenWidth = MediaQuery.of(context).size.width;

    double childAspectRatio1 = screenHeight / screenWidth * .27;

    return childAspectRatio1;
  }
}

class ApplyFilterModel {
  List<int>? filterBrand;
  String? filterMinPrice;
  String? filterMaxPrice;
  String? filterSortBy;
  String? filterDiscount;

  ApplyFilterModel(
      {this.filterBrand,
      this.filterMinPrice,
      this.filterMaxPrice,
      this.filterSortBy,
      this.filterDiscount});
}
