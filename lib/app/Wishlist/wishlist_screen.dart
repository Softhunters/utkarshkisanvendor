import 'package:currency_converter/currency.dart';
import 'package:e_commerce/app/CartSection/Controller/cart_controller.dart';
import 'package:e_commerce/widgets/app_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../common_widgets/app_colors.dart';
import '../../common_widgets/urls.dart';
import '../../constant/cons.dart';
import '../../widgets/cache_network_image.dart';
import '../CategoryProduct/product_detail_screen.dart';
import '../Home/controller/home_controller.dart';

class WishlistScreen extends StatelessWidget {
  // final int type;

  const WishlistScreen({super.key, });

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

      provider.getWishlistProduct(0);

    return Consumer<HomeController>(
      builder: (context, controller, child) => Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                controller.setFavIndex(null);
                controller.filterCateProduct(null);
                Get.back();
              },
              child: const Icon(Icons.arrow_back)),
          title: Text( "My Wishlist" ,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w500)),
          centerTitle: false,
          actions:  [
            if(controller.allWishListProducts.isNotEmpty)
            GestureDetector(
              onTap: () {
                openDialog(context, controller);

              },
                child: Icon(Icons.delete_forever)),
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
            visible: !controller.wproductLoading1,
            replacement: const Center(child: CupertinoActivityIndicator(),),
            child: Visibility(
              visible:controller.allWishListProducts.isNotEmpty ,
              replacement: Center(child: Text("Wishlist Product Not available",style: Theme.of(context).textTheme.bodyLarge,),),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      // height: height * .54,
                      child: ListView.builder(
                    itemCount: controller.allWishListProducts.length ,
                    physics: const AlwaysScrollableScrollPhysics(),

                    itemBuilder: (context, index) {
                      var data = controller.allWishListProducts[index];

                      return GestureDetector(
                        onTap: () {
                          controller.changePriceWithIndex(data.id);
                          controller.saveProductDetailslug(data.slug);
                          controller.getProductDetail(data.slug, 0);
                          // print(data['id']);
                          Get.to( ProductDetailScreen(productSlug:  data.slug ?? "",id: data.id ?? 0, ));
                        },
                        child:


                          Card(
                            // decoration: BoxDecoration(border: Border.all()),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      MyCacheNetworkImages(
                                        imageUrl: "$imageURL${data.productImage}",
                                        // imageUrl: "https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/71a00703e8c14c76aa8471445a9eaf40_9366/Ultrabounce_Shoes_Blue_HP5783_HM1.jpg",
                                        height: switch (layoutInfo) {
                                          (ScreenSize.large || ScreenSize.extraLarge, _) =>
                                          height * .25,
                                          (_, Orientation.landscape) => height * .86,
                                          _ => height * .16
                                        },
                                        width: width*.28,
                                        radius: 20,
                                        fit: BoxFit.contain,
                                        // color: AppColors.primaryColor,
                                      ),


                                     SizedBox(width: 8,),
                                     Container(
                                       padding: const EdgeInsets.only(left: 5),
                                       width: width*.58,
                                       child: Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Text(
                                             data.productName ?? "",
                                             maxLines: 2,
                                             overflow: TextOverflow.ellipsis,
                                             style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                 color: AppColors.primaryBlack,fontWeight: FontWeight.w600
                                             ),
                                           ),
                                           SizedBox(height: 4,),

                                           Consumer<CurrencyProvider>(
                                             builder: (context, currencyProvider, child) =>
                                                 FutureBuilder<double>(
                                                   future: currencyProvider.selectedCurrency == Currency.usd
                                                       ? currencyProvider.convertToUSD(double.parse(data.price ?? "0.0"))
                                                       : Future.value(double.parse(data.price ?? "0.0")),
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
                                                         return Row(
                                                           mainAxisAlignment:
                                                           MainAxisAlignment.start,
                                                           children: [
                                                             Text(
                                                               currencyProvider.selectedCurrency ==
                                                                   Currency.inr
                                                                   ? "₹${data.price ?? " "}"
                                                                   : "\$${salePrice.toStringAsFixed(2)}",
                                                               maxLines: 1,
                                                               style: Theme.of(context)
                                                                   .textTheme
                                                                   .bodyLarge
                                                                   ?.copyWith(
                                                                   fontWeight:
                                                                   FontWeight.w600),
                                                             ),
                                                             const SizedBox(width: 2),
                                                             if (salePrice != regularPrice)
                                                               Text(
                                                                 currencyProvider
                                                                     .selectedCurrency ==
                                                                     Currency.inr
                                                                     ? "₹${data.regularPrice ?? " "}"
                                                                     : "\$${regularPrice.toStringAsFixed(2)}",
                                                                 maxLines: 1,
                                                                 style: Theme.of(context)
                                                                     .textTheme
                                                                     .bodySmall
                                                                     ?.copyWith(

                                                                     decoration: TextDecoration.lineThrough,
                                                                     color:
                                                                     AppColors.redColor),
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
                                                           ],
                                                         );
                                                       },
                                                     );
                                                   },
                                                 ),
                                           ),

                                           SizedBox(height: 8,),
                                           // if(data.reviewsAvgRating !="null")
                                           IntrinsicHeight(
                                             child: Row(
                                               children: [
                                                 if(data.reviewsAvgRating !="null")
                                                 Container(
                                                   decoration: BoxDecoration(color: AppColors.green,borderRadius: BorderRadius.circular(20)),
                                                   child: Padding(
                                                     padding: const EdgeInsets.symmetric(horizontal: 6.0,vertical: 2),
                                                     child: Row(
                                                       children: [
                                                         Text(
                                                           double.parse(data.reviewsAvgRating != "null" ? data.reviewsAvgRating?? "0.0" :"0.0").toStringAsFixed(1) ,
                                                           style: Theme.of(context).textTheme.labelSmall,
                                                         ),
                                                         const Icon(
                                                           Icons.star,
                                                           size: 12,
                                                           color: AppColors.white,
                                                         ),

                                                       ],
                                                     ),
                                                   ),
                                                 ),

                                                /* if(data.reviewsAvgRating !="null")
                                                const VerticalDivider(
                                                   color: AppColors.divideColor,
                                                   thickness: 2,
                                                 ),
                                                 if ("soldItem" != "")
                                                   Container(
                                                     decoration: BoxDecoration(
                                                         color: AppColors.divideColor,
                                                         borderRadius: BorderRadius.circular(5)),
                                                     child: Padding(
                                                       padding: const EdgeInsets.symmetric(
                                                           horizontal: 8.0, vertical: 2),
                                                       child: Text(
                                                         "${"6754"} Sold",
                                                         style: Theme.of(context)
                                                             .textTheme
                                                             .labelSmall,
                                                       ),
                                                     ),
                                                   )*/
                                               ],
                                             ),
                                           ),
                                           SizedBox(height: 18,),
                                           Consumer<CartController>(
                                             builder: (context, cartController, child) =>  Row(
                                               mainAxisAlignment: MainAxisAlignment.end,
                                               children: [
                                                 GestureDetector(
                                                   onTap: () {
                                                     controller.addWishlistProduct(data.productId,2);
                                                   },
                                                   child: Container(
                                                     width: width*.2,
                                                     // height: 2,
                                                     decoration: BoxDecoration(
                                                       borderRadius: BorderRadius.circular(5),
                                                       border: Border.all(),
                                                       // color: AppColors.primaryBlack
                                                     ),
                                                     child: Padding(
                                                       padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 2),
                                                       child: Center(child: Text("Delete",maxLines: 1,
                                                         overflow: TextOverflow.ellipsis,
                                                         style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.primaryBlack),),),
                                                     ),
                                                   ),
                                                 ),
                                                 SizedBox(width: 30,),
                                                 GestureDetector(
                                                   onTap: () {
                                                     controller.moveToCart(data.productId ??"",(value) {
                                                       if(value==true){
                                                         cartController.getCartDAta();
                                                       }
                                                     },);
                                                   },
                                                   child: Container(
                                                     // width: width*.2,
                                                     // height: 2,
                                                     decoration: BoxDecoration(
                                                       borderRadius: BorderRadius.circular(5),
                                                       border: Border.all(),
                                                       // color: AppColors.primaryBlack
                                                     ),
                                                     child: Padding(
                                                       padding: const EdgeInsets.symmetric(horizontal: 6.0,vertical: 2),
                                                       child: Center(child: Text("Move to Cart",maxLines: 1,
                                                         overflow: TextOverflow.ellipsis,
                                                         style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.primaryBlack),),),
                                                     ),
                                                   ),
                                                 ),

                                                 SizedBox(width: 15,),
                                               ],
                                             ),
                                           ),

                                         ],
                                       ),
                                     )
                                    ],
                                  ),


                                ],
                              ),
                            ),
                          )
                      );


                    },
                  ))
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }


  openDialog(BuildContext context,HomeController controller) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              backgroundColor: AppColors.white,
              surfaceTintColor: AppColors.white,
              title: Text(
                "Delete Item ?",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              content: Text(
                "Are You Sure !, You want to remove all item from wishlist",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                    child: Text(
                      "No",
                      style: Theme.of(context).textTheme.titleSmall,
                    )),
                ElevatedButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      controller.deleteAllWishlistProduct();
                    },
                    child: Text(
                      "Yes",
                      style: Theme.of(context).textTheme.titleSmall,
                    ))
              ],
            );
          },
        );
      },
    );
  }

}
