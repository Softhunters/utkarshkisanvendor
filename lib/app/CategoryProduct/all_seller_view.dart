import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:utkrashvendor/app/kisan%20Dashboard/controller/dashboard_controller.dart';
import '../../common_widgets/app_colors.dart';
import '../../widgets/app_button_widget.dart';
import '../CartSection/Controller/cart_controller.dart';
import '../Home/controller/home_controller.dart';
import '../bottom_bar/bottom_bar_screen.dart';
import '../kisan Dashboard/view/seller_product_list_view.dart';
class AllSellerView extends StatefulWidget {
  const AllSellerView({super.key});

  @override
  State<AllSellerView> createState() => _AllSellerViewState();
}

class _AllSellerViewState extends State<AllSellerView> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
   return Consumer<HomeController>(
        builder: (context, controller, child) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back)),
        title: Row(
          children: [
            Image.asset(
              "assets/images/app_icon.png",
              height: 30,
              width: 30,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              controller.productDetail != null
                  ? controller.productDetail?.brands?.brandName ?? ""
                  : "",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: AppColors.green,
                  // fontSize: 14,
                  fontWeight: FontWeight.w800),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: Padding(padding: EdgeInsets.all(16),
      child:   ListView.builder(
          shrinkWrap: false,
          physics:
          const NeverScrollableScrollPhysics(),
          itemCount: controller.sellerList.length,
          itemBuilder: (context, index) {
            var data = controller.sellerList[index];
            int vendorId = data.vendorId ?? 0;
            return Consumer<HomeController>(
                builder: (context, homeCtrl, _) {
                  final qty = homeCtrl.getQty(vendorId);


                  return Consumer<DashboardController>(
                     builder: (context, dashboardController, _) {
                  return GestureDetector(
                    onTap: ()async{
                      await dashboardController.getVendorProductDetails((data?.vendorId??'').toString());
                      Get.to(()=>SellerProductListView());
                    },
                    child:  Container(
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color:
                            AppColors.primaryColor),
                        borderRadius:
                        BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Name:",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                    color: Color(
                                        0xFF262626),
                                    fontSize: 14,
                                    fontWeight:
                                    FontWeight
                                        .w700),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                  child: Text(
                                    "${data.sellerName ?? ''}" ,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                        color: AppColors
                                            .primaryDarkColor,
                                        fontSize: 14,
                                        fontWeight:
                                        FontWeight
                                            .w700),
                                    maxLines: 2,
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              Text(
                                "Price:",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                    color: Color(
                                        0xFF262626),
                                    fontSize: 14,
                                    fontWeight:
                                    FontWeight
                                        .w700),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                        text:
                                        '\u20B9${data.price} ',
                                        style: Theme.of(
                                            context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                            color: AppColors
                                                .primaryBlack,
                                            fontSize:
                                            14,
                                            fontWeight:
                                            FontWeight
                                                .w700)),
                                    TextSpan(
                                        text:
                                        '\u20B9${controller.productDetail?.salePrice ?? " "} ',
                                        style: Theme.of(
                                            context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                            color: AppColors
                                                .brown,
                                            fontSize:
                                            14,
                                            decoration:
                                            TextDecoration
                                                .lineThrough,
                                            fontWeight:
                                            FontWeight
                                                .w400)),
                                    TextSpan(
                                      text: (() {
                                        final salePrice =
                                        num.tryParse(
                                            controller
                                                .productDetail
                                                ?.salePrice ??
                                                '');
                                        final price =
                                            data.price;

                                        if (salePrice !=
                                            null &&
                                            price !=
                                                null &&
                                            salePrice >
                                                0) {
                                          final discountPercent =
                                              ((salePrice -
                                                  price) /
                                                  salePrice) *
                                                  100;
                                          return '${discountPercent.toStringAsFixed(0)}% off';
                                        } else {
                                          return '';
                                        }
                                      })(),
                                      style: Theme.of(
                                          context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                        color:
                                        AppColors
                                            .green,
                                        fontSize: 14,
                                        fontWeight:
                                        FontWeight
                                            .w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              Text(
                                "Available Quantity:",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                    color: Color(
                                        0xFF262626),
                                    fontSize: 14,
                                    fontWeight:
                                    FontWeight
                                        .w700),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                "${data.quantity}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                    color: AppColors
                                        .primaryBlack,
                                    fontSize: 15,
                                    fontWeight:
                                    FontWeight
                                        .w700),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          if(data.stockStatus=='instock')...{
                            Row(
                              children: [
                                Container(
                                  width: width * .45,
                                  child:  !controller.sellerCartIds.contains(vendorId)
                                      ? Row(
                                    children: [
                                      Text("Qty:",
                                          style: Theme.of(
                                              context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                              color:
                                              AppColors.primaryColor)),
                                      const SizedBox(
                                          width: 12),
                                      Container(
                                        height: 30,
                                        decoration:
                                        BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(
                                              25),
                                          color: AppColors
                                              .textFieldColor,
                                        ),
                                        child: Row(
                                          children: [
                                            IconButton(
                                              icon: Icon(
                                                  Icons
                                                      .remove,
                                                  size:
                                                  18),
                                              onPressed:
                                                  () {
                                                controller
                                                    .decrementQty(vendorId);
                                                setState(
                                                        () {});
                                              },
                                            ),
                                            Text(qty.toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(color: AppColors.primaryColor)),
                                            IconButton(
                                                icon: Icon(
                                                    Icons.add,
                                                    size: 18),
                                                onPressed: () {
                                                  controller.incrementQty(vendorId);
                                                  setState(() {});
                                                }),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                      : Text(
                                      "This product is already in your cart.",
                                      style: Theme.of(
                                          context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                          color: AppColors
                                              .primaryBlack)),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Row(
                              children: [
                                if (controller.productDetail
                                    ?.stockStatus ==
                                    "instock")
                                  Expanded(
                                    child: Consumer<CartController>(
                                      builder: (context,
                                          value,
                                          child) =>
                                      !controller.sellerCartIds.contains(vendorId)
                                          ? GestureDetector(
                                        onTap:
                                            () {
                                          setState(
                                                  () {
                                                value
                                                    .addCartDAta(
                                                  controller.productDetail?.id,
                                                  // controller.count,
                                                  qty,
                                                      (value) {
                                                    if (value) {
                                                      controller.count = 1;
                                                      controller.getProductDetail(controller.dSlug, 1);
                                                    }
                                                  },
                                                  (data.vendorId ?? '').toString(),
                                                );
                                              });
                                        },
                                        child:
                                        Container(
                                          height:
                                          30,
                                          decoration: BoxDecoration(
                                              color:
                                              AppColors.primaryColor,
                                              borderRadius: BorderRadius.circular(20)),
                                          child:
                                          const Padding(
                                            padding:
                                            EdgeInsets.symmetric(horizontal: 20),
                                            child:
                                            Center(child: Text("Add to Cart")),
                                          ),
                                        ),
                                      )
                                          : GestureDetector(
                                        onTap:
                                            () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => const BottomBarScreen(
                                                  index: 1,
                                                  type: 1,
                                                ),
                                              ));
                                        },
                                        child:
                                        Container(
                                          height:
                                          30,
                                          decoration: BoxDecoration(
                                              color:
                                              AppColors.primaryColor,
                                              borderRadius: BorderRadius.circular(20)),
                                          child:
                                          const Padding(
                                            padding:
                                            EdgeInsets.symmetric(horizontal: 14.0),
                                            child:
                                            Center(child: Text("View Cart")),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                  child: AppButton(
                                    title: "Buy Now",
                                    onTap: () {},
                                    bgColor: AppColors
                                        .yellowishColor,
                                    height: 30,
                                  ),
                                )
                              ],
                            )
                          }else...{
                            Text("Out of stock ",style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                color: AppColors
                                    .primaryBlack,
                                fontSize: 15,
                                fontWeight:
                                FontWeight
                                    .w700),)
                          }
                        ],
                      ),
                    ),
                  );
          },
          );
                });
          }),),
    );
        });
  }
}
