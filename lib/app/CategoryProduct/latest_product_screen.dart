import 'package:currency_converter/currency.dart';
import 'package:utkrashvendor/app/CategoryProduct/product_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../common_widgets/app_colors.dart';
import '../../common_widgets/urls.dart';
import '../../constant/cons.dart';
import '../../widgets/cache_network_image.dart';
import '../Home/controller/home_controller.dart';
import '../Search/search_screen.dart';

class LatestProductScreen extends StatelessWidget {
  const LatestProductScreen({super.key});

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
    // if(type == 0) {
    //   provider.getWishlistProduct();
    // }
    // var currencyProvider = Provider.of<CurrencyProvider>(context,listen: false);

    return Consumer<HomeController>(
      builder: (context, controller, child) => Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                controller.setFavIndex(null);
                controller.filterProducts.clear();
                controller.filterCateProduct(null);
                Get.back();
              },
              child: const Icon(Icons.arrow_back)),
          title: Text( "Most Popular",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w500)),
          centerTitle: false,
          actions:  [
            GestureDetector(
                onTap: () {
                  Get.to(()=>const SearchScreen());
                },
                child: Icon(Icons.search)),
            SizedBox(
              width: 15,
            )
          ],
          elevation: 0,
          surfaceTintColor: AppColors.white,
        ),
        body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Visibility(
                visible: !controller.shopProductLoading,
                replacement: Center(child: CupertinoActivityIndicator.partiallyRevealed(),),
                child: Visibility(
                  visible:controller.allProducts.isNotEmpty,
                  replacement: Center(child: Text( "No product Added yet. Please check back later!",style: Theme.of(context).textTheme.bodyLarge,),),
                  child: Column(
                    children: [


                      // if (type!=0)
                        SizedBox(
                          height: 50,
                          child: ListView.builder(
                            itemCount:  controller.categoryList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var data = controller.categoryList[index];
                              bool isSelected = controller.favoriteIndex == index;
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {

                                    controller.setFavIndex(index);
                                    controller.filterCateProduct(data.id);
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
                                          data.name??"",
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

                      NotificationListener<ScrollNotification>(
                        onNotification: (notification) {
                          if (notification.metrics.pixels ==
                              notification.metrics.maxScrollExtent) {
                            if (!controller.isFetching) {

                              controller.setValue(true, true);

                              if(controller.favoriteIndex != null ){
                                if(controller.totalShopProduct! > controller.filterProducts.length){
                                  controller.setPage();
                                }else if(controller.totalShopProduct! >  controller.allShopProduct.length) {
                                    controller.setPage();

                                }
                              }

                              controller.getShopProductData(1);
                              Future.delayed(const Duration(seconds: 1)).then(
                                      (value) => controller.setValue(false, false));

                            }
                          }
                          return false;
                        },
                        child: Expanded(
                          // height: height * .54,
                            child: Visibility(
                              visible: controller.favoriteIndex != null ? controller.filterProducts.isNotEmpty: controller.allShopProduct.isNotEmpty,
                              replacement: Center(child: Text("No product Added yet. Please check back later!",style: Theme.of(context).textTheme.bodyLarge,),),
                              child: GridView.builder(
                                itemCount: controller.favoriteIndex != null ? controller.filterProducts.length: controller.allShopProduct.length,
                                physics: const AlwaysScrollableScrollPhysics(),
                                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,

                                    childAspectRatio: _calculateAspectRatio(context),
                                    // childAspectRatio:  Theme.of(context).platform == TargetPlatform.iOS? switch (layoutInfo) {
                                    //   (_, Orientation.landscape) => 1,
                                    //   _ => .73
                                    // }  :switch (layoutInfo) {
                                    //   (_, Orientation.landscape) => 1,
                                    //   _ => .7
                                    // },
                                    crossAxisSpacing: 0,
                                    mainAxisSpacing: 0),
                                itemBuilder: (context, index) {
                                  var data =controller.favoriteIndex  != null ? controller.filterProducts[index] :  controller.allShopProduct[index];
                                  // var convertedSalePrice = currencyProvider.getConvertedPrice(index);
                                  // var convertedRegularPrice = currencyProvider.getConvertedRegularPrice(index);
                                  //
                                  // if (currencyProvider.getConvertedPrice(index) == null) {
                                  //   currencyProvider.convertCurrency(index,"inr",Currency.usd,  double.parse(data.salePrice ?? "0"));
                                  // }
                                  //
                                  // if (currencyProvider.getConvertedRegularPrice(index) == null) {
                                  //   currencyProvider.convertRegularCurrency(index,"inr",Currency.usd,  double.parse(data.regularPrice ?? "0"));
                                  // }
                                  return GestureDetector(
                                    onTap: () {
                                      controller.changePriceWithIndex(data.id);
                                      controller.saveProductDetailslug(data.slug);
                                      controller.getProductDetail(data.slug, 0);

                                      Get.to( ()=>ProductDetailScreen(productSlug:  data.slug ??"", id: data.id??0,));
                                    },
                                    child:Card(
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
                                                    (ScreenSize.large || ScreenSize.extraLarge, _) =>
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
                                                          controller.addWishlistProduct(data.id,3,"");
                                                        },
                                                        child: const Icon(Icons.favorite_border,color: AppColors.primaryColor,)))
                                                    : Positioned(
                                                    top: 5,
                                                    right: 5,
                                                    child: GestureDetector(
                                                        onTap: () {
                                                          controller.addWishlistProduct(data.id,3,"");
                                                        },
                                                        child: const Icon(Icons.favorite,color: AppColors.primaryColor))),


                                                if(data.reviewsCount !=0)
                                                  Positioned(
                                                      bottom: 8,
                                                      left: 10,
                                                      child: Container(
                                                        height: 22,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(5),
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
                                                                      double.parse(data.reviewsAvgRating !="null" ? data.reviewsAvgRating ??"0.0" :"0.0").toStringAsFixed(1) ??"",
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
                                                                    controller.formatValue(data.reviewsCount ?? 0),
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
                                                      )),


                                                if(data.discountValue !="0" && data.discountValue != "null")
                                                  Positioned(
                                                      top: 0,
                                                      left: 0,
                                                      child:  Container(
                                                        // height: 20,
                                                        // width: 90,
                                                        decoration: BoxDecoration(
                                                            gradient: LinearGradient(colors: [
                                                              Colors.indigo,
                                                              Colors.purple.shade300,
                                                            ]),
                                                            borderRadius: const BorderRadius.only(
                                                                bottomRight:
                                                                Radius.elliptical(15, 20),
                                                                topLeft: Radius.circular(10)
                                                            )),
                                                        child: Center(
                                                          child: Padding(
                                                            padding: const EdgeInsets.symmetric(
                                                                horizontal: 10,vertical: 4),
                                                            child: Text(
                                                                "${data.discountValue}% ",
                                                                style: Theme.of(context)
                                                                    .textTheme
                                                                    .labelSmall?.copyWith(color: AppColors.white,fontSize: 9)),
                                                          ),
                                                        ),
                                                      )),

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

                                                  Consumer<CurrencyProvider>(
                                                    builder: (context, currencyProvider, child) =>  FutureBuilder<double>(
                                                      future: currencyProvider.selectedCurrency == Currency.usd
                                                          ? currencyProvider.convertToUSD(double.parse(data.salePrice ?? "0.0"))
                                                          : Future.value(double.parse(data.salePrice ?? "0.0")),
                                                      builder: (context, salePriceSnapshot) {
                                                        if (!salePriceSnapshot.hasData) {
                                                          return const Text("Loading..");
                                                        }
                                                        double salePrice = salePriceSnapshot.data ?? 0.0;
                                                        return FutureBuilder<double>(
                                                          future: currencyProvider.selectedCurrency == Currency.usd
                                                              ? currencyProvider.convertToUSD(double.parse(data.regularPrice ?? "0.0"))
                                                              : Future.value(double.parse(data.regularPrice ?? "0.0")),
                                                          builder: (context, regularPriceSnapshot) {
                                                            if (!regularPriceSnapshot.hasData) {
                                                              return const Text("Loading..");
                                                            }
                                                            double regularPrice = regularPriceSnapshot.data ?? 0.0;
                                                            return Column(
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  children: [
                                                                    Text(

                                                                      "₹${double.tryParse(data.salePrice ?? " ")?.toStringAsFixed(2)}",
                                                                      maxLines: 1,
                                                                      style: Theme.of(context)
                                                                          .textTheme
                                                                          .labelSmall
                                                                          ?.copyWith(
                                                                          fontSize: 9,
                                                                          fontWeight: FontWeight.w600),
                                                                    ),
                                                                    const SizedBox(width: 2),

                                                                  ],
                                                                ),
                                                                Row(
                                                                    children:[
                                                                      if (salePrice != regularPrice)
                                                                        Text(
                                                                          "₹${double.tryParse(data.regularPrice ?? " ")?.toStringAsFixed(2)}",

                                                                          maxLines: 1,
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .labelSmall
                                                                              ?.copyWith(
                                                                              fontSize: 7,
                                                                              decoration: TextDecoration.lineThrough,
                                                                              color: AppColors.redColor),
                                                                        ),
                                                                      const SizedBox(width: 2),
                                                                      if (salePrice != regularPrice)
                                                                        Text(
                                                                          "${data.discountValue}% off",
                                                                          maxLines: 1,
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .labelSmall,
                                                                        ),
                                                                    ]
                                                                )
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(data.stockStatus == "instock" ?"In Stock" :"Out Of Stock" , style: Theme.of(context)
                                                      .textTheme
                                                      .labelSmall
                                                      ?.copyWith(  fontSize: 10, color: data.stockStatus == "instock"? AppColors.green :AppColors.redColor ),)

                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );


                                },
                              ),
                            )),
                      ),
                      if(controller.catLoading)
                      const Center(child: CupertinoActivityIndicator(),),
                      const SizedBox(height: 20,)

                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
  double _calculateAspectRatio(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    double screenWidth = MediaQuery.of(context).size.width;

    double childAspectRatio1 = screenHeight / screenWidth * .27;

    return childAspectRatio1;
  }
}
