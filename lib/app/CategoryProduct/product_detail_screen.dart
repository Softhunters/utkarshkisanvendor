import 'package:card_swiper/card_swiper.dart';
import 'package:currency_converter/currency.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:utkrashvendor/app/CartSection/Controller/cart_controller.dart';
import 'package:utkrashvendor/app/kisan%20Dashboard/view/edit_product_view.dart';
import 'package:utkrashvendor/common_widgets/urls.dart';
import 'package:utkrashvendor/widgets/app_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html_table/flutter_html_table.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';

import '../../common_widgets/app_colors.dart';
import '../../widgets/cache_network_image.dart';
import '../../widgets/read_more_html.dart';
import '../Home/controller/home_controller.dart';
import '../Review/rating_screen.dart';
import '../bottom_bar/bottom_bar_screen.dart';
import 'package:flutter_html/flutter_html.dart';

import '../kisan Dashboard/controller/dashboard_controller.dart';
import '../kisan Dashboard/view/add_product_view.dart';
import '../kisan Dashboard/view/seller_product_list_view.dart';
import '../kisan Dashboard/viewModal/edit_response.dart';
import '../kisan Dashboard/viewModal/variant_response.dart';
import 'all_seller_view.dart';
import 'package:html/dom.dart' as dom;

class ProductDetailScreen extends StatefulWidget {
  final String productSlug;
  final int id;

  // final type;

  const ProductDetailScreen({
    Key? key,
    required this.productSlug,
    required this.id,
    /*required this.type*/
  }) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool isDescExpanded = true;
  bool isAdditonalInfoExpanded = false;
  bool isManufectureInfoExpanded = false;
  int qty = 1;

  void initState() {
    super.initState();
    isManufectureInfoExpanded = false;
    isAdditonalInfoExpanded = false;
    isDescExpanded = true;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final controller = Provider.of<HomeController>(context, listen: false);
      await controller.getProductDetail(widget.productSlug, widget.id);
      await controller.getProfile();

      // Now initialize seller quantities
      controller.initSellerQuantities(controller.sellerList);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return Consumer<HomeController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: AppBar(
            // automaticallyImplyLeading: true,
            leading: GestureDetector(
                onTap: () {
                  controller.changePriceWithIndex(0);
                  controller.count = 1;
                  controller.indexx = null;
                  controller.productDetail = null;
                  // currencyProvider.convertedPrice = null;
                  // currencyProvider.salePrice = null;
                  controller.variant.clear();
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
          body: SafeArea(
            child: RefreshIndicator(
                color: AppColors.primaryColor,
                backgroundColor: AppColors.white,
                child: Visibility(
                  visible: !controller.productLoading,
                  replacement: const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                  child: Visibility(
                    visible: controller.productDetail != null,
                    replacement: const Center(
                      child: Text("Product detail not available"),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * .85,
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// image
                            Container(
                                height: 400,
                                child: GestureDetector(
                                  onTap: () {
                                    // viewImageInZoom(context, controller.singleProductImages);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            FullScreenImageGallery(
                                                imageUrls: controller
                                                        .singleProductImages ??
                                                    []),
                                      ),
                                    );
                                  },
                                  child: PhotoViewGallery.builder(
                                    scrollPhysics:
                                        const BouncingScrollPhysics(),
                                    itemCount:
                                        controller.singleProductImages.length,
                                    loadingBuilder: (context, event) => Center(
                                      child: Container(
                                        width: 20.0,
                                        height: 20.0,
                                        child: CircularProgressIndicator(
                                          value: event == null ? 0 : 2,
                                        ), /**/
                                      ),
                                    ),
                                    builder: (BuildContext context, int index) {
                                      return PhotoViewGalleryPageOptions(
                                        imageProvider: NetworkImage(index != 0
                                            ? "$productListImageURL${controller.singleProductImages[index]}"
                                            : "$imageURL${controller.singleProductImages[index]}"),
                                        initialScale:
                                            PhotoViewComputedScale.contained *
                                                1,
                                        minScale:
                                            PhotoViewComputedScale.covered * .5,
                                        maxScale:
                                            PhotoViewComputedScale.covered * 2,
                                        // heroAttributes: PhotoViewHeroAttributes(tag: galleryItems[index].id),
                                      );
                                    },

                                    // backgroundDecoration: widget.backgroundDecoration,
                                    // pageController: widget.pageController,
                                    onPageChanged: (index) {
                                      controller.updateImageIndex(index);
                                    },
                                  ),
                                )),

                            const SizedBox(height: 15),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: 10,
                                // width: 100,
                                child: Center(
                                  child: ListView.builder(
                                    itemCount: controller
                                                .singleProductImages.length >
                                            5
                                        ? 5
                                        : controller.singleProductImages.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) => Padding(
                                      padding:
                                          const EdgeInsets.only(right: 6.0),
                                      child: Center(
                                          child: index == controller.itemIndex
                                              ? Container(
                                                  width: 12,
                                                  height: 3,
                                                  decoration: BoxDecoration(
                                                      color: AppColors
                                                          .primaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                )
                                              : Container(
                                                  width: 12,
                                                  height: 3,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          AppColors.gery1Color,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),

                            /// Detail
                            Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFFFCF7EB),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: width * .74,
                                          child: Text(
                                            controller.productDetail != null
                                                ? controller.productDetail
                                                        ?.brands?.brandName ??
                                                    ""
                                                : "",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                    color: AppColors.green,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                        ),
                                        Consumer<CartController>(
                                          builder: (context, cartController,
                                                  child) =>
                                              Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: controller.productDetail
                                                        ?.wishlistAvgUserId ==
                                                    "null"
                                                ? GestureDetector(
                                                    onTap: () {
                                                      controller.addWishlistProductForProductPage(
                                                          controller
                                                              .productDetail
                                                              ?.id,
                                                          4,
                                                          (controller
                                                                      .productDetail
                                                                      ?.seller
                                                                      ?.venderId ??
                                                                  '1')
                                                              .toString());

                                                      controller
                                                          .getProductDetail(
                                                              controller.dSlug,
                                                              1);
                                                      setState(() {});
                                                    },
                                                    child: const Icon(
                                                      Icons.favorite_border,
                                                      color: AppColors
                                                          .yellowishColor,
                                                      size: 22,
                                                    ))
                                                : GestureDetector(
                                                    onTap: () {
                                                      controller.addWishlistProductForProductPage(
                                                          controller
                                                              .productDetail
                                                              ?.id,
                                                          4,
                                                          (controller
                                                                      .productDetail
                                                                      ?.seller
                                                                      ?.venderId ??
                                                                  '1')
                                                              .toString());
                                                      controller
                                                          .getProductDetail(
                                                              controller.dSlug,
                                                              1);
                                                      setState(() {});
                                                    },
                                                    child: const Icon(
                                                      Icons.favorite,
                                                      color: AppColors
                                                          .yellowishColor,
                                                      size: 22,
                                                    )),
                                          ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: GestureDetector(
                                                onTap: () {
                                                  final String appLink =
                                                      '$shareProductURL${controller.productDetail!.slug!}';
                                                  controller.shareProduct(
                                                      appLink,
                                                      "Check out new product:");
                                                },
                                                child: const Icon(
                                                  Icons.share,
                                                  size: 22,
                                                  color: AppColors.primaryColor,
                                                ))),
                                        SizedBox(
                                          width: 5,
                                        )
                                      ],
                                    ),

                                    Text(
                                      controller.productDetail != null
                                          ? "${controller.productDetail?.name}" ??
                                              ""
                                          : "",
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              color: const Color(0xff000000),
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                    ),
                                    if (controller
                                            .productDetail?.reviewsAvgRating !=
                                        'null')
                                      IntrinsicHeight(
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              size: 18,
                                              color: AppColors.ratingBGColor,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              double.parse(controller
                                                              .productDetail
                                                              ?.reviewsAvgRating !=
                                                          'null'
                                                      ? controller.productDetail
                                                              ?.reviewsAvgRating ??
                                                          "0.0"
                                                      : "0.0")
                                                  .toStringAsFixed(1),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge
                                                  ?.copyWith(
                                                      color: AppColors
                                                          .primaryColor),
                                            ),
                                            const VerticalDivider(
                                              color: AppColors.divideColor,
                                              thickness: 2,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: AppColors.divideColor,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0,
                                                        vertical: 2),
                                                child: Text(
                                                  controller.formatValue(
                                                      (controller.reviews)
                                                          .length),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelSmall,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    const SizedBox(
                                      height: 10,
                                    ),

                                    Consumer<CurrencyProvider>(
                                      builder:
                                          (context, currencyProvider, child) =>
                                              FutureBuilder<double>(
                                        future: currencyProvider
                                                    .selectedCurrency ==
                                                Currency.usd
                                            ? currencyProvider.convertToUSD(
                                                double.parse(controller
                                                        .productDetail
                                                        ?.salePrice ??
                                                    "0.0"))
                                            : Future.value(double.parse(
                                                controller.productDetail
                                                        ?.salePrice ??
                                                    "0.0")),
                                        builder: (context, salePriceSnapshot) {
                                          if (!salePriceSnapshot.hasData) {
                                            return const Text("Loading..+");
                                          }
                                          double salePrice =
                                              salePriceSnapshot.data ?? 0.0;
                                          return FutureBuilder<double>(
                                            future: currencyProvider
                                                        .selectedCurrency ==
                                                    Currency.usd
                                                ? currencyProvider.convertToUSD(
                                                    double.parse(controller
                                                            .productDetail
                                                            ?.regularPrice ??
                                                        "0.0"))
                                                : Future.value(double.parse(
                                                    controller.productDetail
                                                            ?.regularPrice ??
                                                        "0.0")),
                                            builder: (context,
                                                regularPriceSnapshot) {
                                              if (!regularPriceSnapshot
                                                  .hasData) {
                                                return const Text("Loading..-");
                                              }
                                              double regularPrice =
                                                  regularPriceSnapshot.data ??
                                                      0.0;
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "₹${double.tryParse(controller.productDetail?.salePrice ?? " ")?.toStringAsFixed(2)}",
                                                    maxLines: 1,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelSmall
                                                        ?.copyWith(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                  ),
                                                  const SizedBox(width: 2),
                                                  if (salePrice != regularPrice)
                                                    Text(
                                                      "₹${double.tryParse(controller.productDetail?.regularPrice ?? " ")?.toStringAsFixed(2)}",
                                                      maxLines: 1,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelSmall
                                                          ?.copyWith(
                                                              fontSize: 12,
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                              color: AppColors
                                                                  .redColor),
                                                    ),
                                                  const SizedBox(width: 2),
                                                  if (salePrice != regularPrice)
                                                    Text(
                                                      "${controller.productDetail?.discountValue}% off",
                                                      maxLines: 1,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelSmall
                                                          ?.copyWith(
                                                              fontSize: 12),
                                                    ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    // if(controller.productDetail?.stockStatus != "instock")
                                    Text(
                                      "Inclusive of all taxes",
                                      maxLines: 1,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(fontSize: 12),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        controller.productDetail?.stockStatus ==
                                                "instock"
                                            ? "In Stock"
                                            : "Out Of Stock",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                                color: controller.productDetail
                                                            ?.stockStatus ==
                                                        "instock"
                                                    ? AppColors.green
                                                    : AppColors.redColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Padding(
                                padding: EdgeInsets.all(12),
                                child: controller.editButtonYesOrNo == "no"
                                    ? Consumer<DashboardController>(
                                        builder:
                                            (context, dashboardcontroller, _) =>
                                                AppButton(
                                                    title: "Add Seller",
                                                    onTap: () async {
                                                      Get.to(() => AddProductView(
                                                          controller
                                                              .productDetail));
                                                    }))
                                    : Consumer<DashboardController>(
                                        builder:
                                            (context, dashboardcontroller, _) =>
                                                AppButton(
                                                    title: "Edit Seller",
                                                    onTap: () async {
                                                      await dashboardcontroller
                                                          .getEditVarientData(
                                                              (controller
                                                                      .productDetail
                                                                      ?.id)
                                                                  .toString());
                                                      final editResult =
                                                          dashboardcontroller
                                                              .variantEdit;
                                                      if (editResult != null) {
                                                        VariantList converted =
                                                            dashboardcontroller
                                                                .convertEditResultToVariant(
                                                                    editResult);
                                                        Get.to(() =>
                                                            EditProductView(
                                                                converted));
                                                      }
                                                    }),
                                      )),
                            const SizedBox(height: 4),

                            /// Variant Details
                            Container(
                              decoration:
                                  const BoxDecoration(color: AppColors.white),
                              child: Card(
                                color: AppColors.white,
                                surfaceTintColor: AppColors.white,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 12),
                                  child: Column(
                                    children: [
                                      if (controller.variant.length > 1)
                                        Container(
                                          width: width * .9,
                                          constraints: BoxConstraints.loose(
                                              Size(width, 71)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Size",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                        color: AppColors
                                                            .primaryColor),
                                              ),
                                              Container(
                                                height: 50,
                                                child: ListView.builder(
                                                  itemCount:
                                                      controller.variant.length,
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemBuilder:
                                                      (context, index) {
                                                    var data = controller
                                                        .variant[index];

                                                    bool selectedColor =
                                                        data.id ==
                                                            controller.indexx;
                                                    return GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          controller
                                                              .changePriceWithIndex(
                                                                  data.id);
                                                          controller
                                                              .saveProductDetailslug(
                                                                  data.slug);
                                                          controller
                                                              .getProductDetail(
                                                                  controller
                                                                      .dSlug,
                                                                  1);
                                                        });
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2.0),
                                                        child: Container(
                                                            // width: 21,
                                                            // height: 55,
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border.all(
                                                                  color: AppColors
                                                                      .primaryBlack),
                                                              color: selectedColor
                                                                  ? AppColors
                                                                      .primaryBlack
                                                                  : AppColors
                                                                      .white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          12.0,
                                                                      vertical:
                                                                          2),
                                                              child: Center(
                                                                  child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  Text(
                                                                    data.varaintDetail ??
                                                                        "",
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .labelMedium
                                                                        ?.copyWith(
                                                                            color: selectedColor
                                                                                ? AppColors.white
                                                                                : AppColors.primaryBlack,
                                                                            fontSize: selectedColor ? 12 : 10),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 2,
                                                                  ),
                                                                  Text(
                                                                    "₹${data.salePrice}",
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .labelSmall
                                                                        ?.copyWith(
                                                                            color: selectedColor
                                                                                ? AppColors.white
                                                                                : AppColors.primaryBlack,
                                                                            fontSize: selectedColor ? 12 : 10),
                                                                  ),
                                                                ],
                                                              )),
                                                            )),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: width * .45,
                                            child: !controller.sellerCartIds
                                                    .contains(controller
                                                        .productDetail
                                                        ?.seller
                                                        ?.venderId)
                                                ? Row(
                                                    children: [
                                                      Text(
                                                        "Qty. :",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge
                                                            ?.copyWith(
                                                                color: AppColors
                                                                    .primaryColor),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Container(
                                                        // width: 100,
                                                        height: 30,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25),
                                                            color: AppColors
                                                                .textFieldColor),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            controller.count > 1
                                                                ? GestureDetector(
                                                                    onTap: () {
                                                                      controller.updateCount(controller.count == 1
                                                                          ? controller.count -
                                                                              0
                                                                          : controller.count -
                                                                              1);
                                                                    },
                                                                    child:
                                                                        const Icon(
                                                                      Icons
                                                                          .remove,
                                                                      size: 18,
                                                                    ))
                                                                : SizedBox(),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              controller.count
                                                                  .toString(),
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall
                                                                  ?.copyWith(
                                                                      color: AppColors
                                                                          .primaryColor),
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            GestureDetector(
                                                                onTap: () {
                                                                  controller.updateCount(
                                                                      controller
                                                                              .count +
                                                                          1);
                                                                },
                                                                child:
                                                                    const Icon(
                                                                  Icons.add,
                                                                  size: 18,
                                                                )),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : Text(
                                                    "This product is already in your cart.",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall
                                                        ?.copyWith(
                                                            color: AppColors
                                                                .primaryBlack)),
                                          ),
                                          if (controller
                                                  .productDetail?.stockStatus ==
                                              "instock")
                                            Consumer<CartController>(
                                              builder: (context, value,
                                                      child) =>
                                                  !controller.sellerCartIds
                                                          .contains(controller
                                                                  .productDetail
                                                                  ?.seller
                                                                  ?.venderId ??
                                                              1)
                                                      ? GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              value.addCartDAta(
                                                                controller
                                                                    .productDetail
                                                                    ?.id,
                                                                controller
                                                                    .count,
                                                                (value) {
                                                                  if (value) {
                                                                    controller
                                                                        .count = 1;
                                                                    controller.getProductDetail(
                                                                        controller
                                                                            .dSlug,
                                                                        1);
                                                                  }
                                                                },
                                                                (controller
                                                                            .productDetail
                                                                            ?.seller
                                                                            ?.venderId ??
                                                                        '1')
                                                                    .toString(),
                                                              );
                                                            });
                                                          },
                                                          child: Container(
                                                            height: 30,
                                                            decoration: BoxDecoration(
                                                                color: AppColors
                                                                    .primaryColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20)),
                                                            child:
                                                                const Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          20),
                                                              child: Center(
                                                                  child: Text(
                                                                      "Add to Cart")),
                                                            ),
                                                          ),
                                                        )
                                                      : GestureDetector(
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const BottomBarScreen(
                                                                    index: 1,
                                                                    type: 1,
                                                                  ),
                                                                ));
                                                          },
                                                          child: Container(
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                color: AppColors
                                                                    .primaryColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20)),
                                                            child:
                                                                const Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          14.0),
                                                              child: Center(
                                                                  child: Text(
                                                                      "View Cart")),
                                                            ),
                                                          ),
                                                        ),
                                            )
                                        ],
                                      ),
                                      // const SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // const SizedBox(height: 12),
                            if (controller.sellerList.isNotEmpty)
                              Card(
                                color: AppColors.white,
                                child: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "All Sellers",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                    color:
                                                        AppColors.primaryColor,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w700),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AllSellerView()));
                                            },
                                            child: Text(
                                              "View More",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                      color: AppColors.green,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w700),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      if (controller.sellerList.isNotEmpty) ...{
                                        ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount:
                                                controller.sellerList.length > 2
                                                    ? 2
                                                    : controller
                                                        .sellerList.length,
                                            itemBuilder: (context, index) {
                                              var data =
                                                  controller.sellerList[index];
                                              int vendorId = data.vendorId ?? 0;
                                              return Consumer<HomeController>(
                                                  builder:
                                                      (context, homeCtrl, _) {
                                                final qty =
                                                    homeCtrl.getQty(vendorId);

                                                return Container(
                                                  padding: EdgeInsets.all(12),
                                                  margin: EdgeInsets.only(
                                                      bottom: 12),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: AppColors
                                                            .primaryColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Consumer<
                                                          DashboardController>(
                                                        builder: (context,
                                                            dashboardController,
                                                            _) {
                                                          return GestureDetector(
                                                            onTap: () async {
                                                              await dashboardController
                                                                  .getVendorProductDetails(
                                                                      (data?.vendorId ??
                                                                              '')
                                                                          .toString());
                                                              Get.to(() =>
                                                                  SellerProductListView());
                                                            },
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  "Name:",
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyMedium
                                                                      ?.copyWith(
                                                                          color: Color(
                                                                              0xFF262626),
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w700),
                                                                ),
                                                                SizedBox(
                                                                  width: 12,
                                                                ),
                                                                Expanded(
                                                                    child: Text(
                                                                  "${data.sellerName ?? ''}",
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyMedium
                                                                      ?.copyWith(
                                                                          color: AppColors
                                                                              .primaryDarkColor,
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w700),
                                                                  maxLines: 2,
                                                                ))
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                      SizedBox(
                                                        height: 6,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Price:",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium
                                                                ?.copyWith(
                                                                    color: Color(
                                                                        0xFF262626),
                                                                    fontSize:
                                                                        14,
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
                                                                                FontWeight.w700)),
                                                                TextSpan(
                                                                    text:
                                                                        '\u20B9${controller.productDetail?.salePrice ?? " "} ',
                                                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                                        color: AppColors
                                                                            .brown,
                                                                        fontSize:
                                                                            14,
                                                                        decoration:
                                                                            TextDecoration
                                                                                .lineThrough,
                                                                        fontWeight:
                                                                            FontWeight.w400)),
                                                                TextSpan(
                                                                  text: (() {
                                                                    final salePrice =
                                                                        num.tryParse(controller.productDetail?.salePrice ??
                                                                            '');
                                                                    final price =
                                                                        data.price;

                                                                    if (salePrice != null &&
                                                                        price !=
                                                                            null &&
                                                                        salePrice >
                                                                            0) {
                                                                      final discountPercent =
                                                                          ((salePrice - price) / salePrice) *
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
                                                                        color: AppColors
                                                                            .green,
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w700,
                                                                      ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Inclusive of all taxes",
                                                            maxLines: 1,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .labelSmall
                                                                ?.copyWith(
                                                                    fontSize:
                                                                        12),
                                                            textAlign:
                                                                TextAlign.start,
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
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium
                                                                ?.copyWith(
                                                                    color: Color(
                                                                        0xFF262626),
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                          ),
                                                          SizedBox(
                                                            width: 12,
                                                          ),
                                                          Text(
                                                            "${data.quantity}",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium
                                                                ?.copyWith(
                                                                    color: AppColors
                                                                        .primaryBlack,
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 6,
                                                      ),
                                                      if (data.stockStatus ==
                                                          "instock") ...{
                                                        Row(
                                                          children: [
                                                            Container(
                                                              width:
                                                                  width * .45,
                                                              child: !controller
                                                                      .sellerCartIds
                                                                      .contains(
                                                                          vendorId)
                                                                  ? Row(
                                                                      children: [
                                                                        Text(
                                                                            "Qty:",
                                                                            style:
                                                                                Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.primaryColor)),
                                                                        const SizedBox(
                                                                            width:
                                                                                12),
                                                                        Container(
                                                                          height:
                                                                              30,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(25),
                                                                            color:
                                                                                AppColors.textFieldColor,
                                                                          ),
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              IconButton(
                                                                                icon: Icon(Icons.remove, size: 18),
                                                                                onPressed: () {
                                                                                  controller.decrementQty(vendorId);
                                                                                  setState(() {});
                                                                                },
                                                                              ),
                                                                              Text(qty.toString(), style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.primaryColor)),
                                                                              IconButton(
                                                                                  icon: Icon(Icons.add, size: 18),
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
                                                                              color: AppColors.primaryBlack)),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 6,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Consumer<
                                                                  CartController>(
                                                                builder: (context,
                                                                        value,
                                                                        child) =>
                                                                    !controller
                                                                            .sellerCartIds
                                                                            .contains(vendorId)
                                                                        ? GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              setState(() {
                                                                                value.addCartDAta(
                                                                                  controller.productDetail?.id,
                                                                                  // controller.count,
                                                                                  qty,
                                                                                  (value) {
                                                                                    if (value) {
                                                                                      controller.count = 1;
                                                                                      controller.getProductDetail(controller.dSlug, 1);
                                                                                    }
                                                                                  },
                                                                                  (data.vendorId ?? '1').toString(),
                                                                                );
                                                                              });
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              height: 30,
                                                                              decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(20)),
                                                                              child: const Padding(
                                                                                padding: EdgeInsets.symmetric(horizontal: 20),
                                                                                child: Center(child: Text("Add to Cart")),
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
                                                                              height: 30,
                                                                              decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(20)),
                                                                              child: const Padding(
                                                                                padding: EdgeInsets.symmetric(horizontal: 14.0),
                                                                                child: Center(child: Text("View Cart")),
                                                                              ),
                                                                            ),
                                                                          ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 12,
                                                            ),
                                                            Expanded(
                                                              child: Consumer<
                                                                  CartController>(
                                                                builder: (context,
                                                                        value,
                                                                        child) =>
                                                                    AppButton(
                                                                  title:
                                                                      "Buy Now",
                                                                  onTap: () {
                                                                    !controller
                                                                            .sellerCartIds
                                                                            .contains(
                                                                                vendorId)
                                                                        ? () {
                                                                            setState(() {
                                                                              value.addCartDAta(
                                                                                controller.productDetail?.id,
                                                                                qty,
                                                                                (value) {
                                                                                  if (value) {
                                                                                    controller.count = 1;
                                                                                    controller.getProductDetail(controller.dSlug, 1);
                                                                                  }
                                                                                },
                                                                                (data.vendorId ?? '1').toString(),
                                                                              );
                                                                            });
                                                                            Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                builder: (context) => const BottomBarScreen(
                                                                                  index: 1,
                                                                                  type: 1,
                                                                                ),
                                                                              ),
                                                                            );
                                                                          }()
                                                                        : Navigator
                                                                            .push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                              builder: (context) => const BottomBarScreen(
                                                                                index: 1,
                                                                                type: 1,
                                                                              ),
                                                                            ),
                                                                          );
                                                                  },
                                                                  bgColor: AppColors
                                                                      .yellowishColor,
                                                                  height: 30,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      } else ...{
                                                        Text(
                                                          "Out of stock ",
                                                          style: Theme.of(
                                                                  context)
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
                                                      }
                                                    ],
                                                  ),
                                                );
                                              });
                                            }),
                                      }
                                    ],
                                  ),
                                ),
                              ),
                            const SizedBox(height: 20),

                            /// Product Description
                            if (controller.productDetail?.description != null)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Description",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                      color: AppColors
                                                          .primaryColor,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w700),
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                isDescExpanded
                                                    ? Icons.keyboard_arrow_up
                                                    : Icons.keyboard_arrow_down,
                                                color: AppColors.primaryColor,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  isDescExpanded =
                                                      !isDescExpanded;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 3),
                                        if (isDescExpanded) ...{
                                          Html(
                                            data: controller.productDetail
                                                    ?.description ??
                                                "",
                                            extensions: const [
                                              TableHtmlExtension(),
                                              // Required for rendering <table>
                                            ],
                                            style: {
                                              "body": Style(
                                                margin: Margins.zero,
                                                padding: HtmlPaddings.zero,
                                                fontSize: FontSize(12.0),
                                                color: AppColors.primaryBlack,
                                              ),
                                              "table": Style(
                                                alignment: Alignment.topLeft,
                                                margin: Margins.zero,
                                                padding: HtmlPaddings.zero,
                                                backgroundColor:
                                                    Colors.grey.shade100,
                                                border: Border.all(
                                                    color: Colors.black12),
                                              ),
                                              "tr": Style(
                                                alignment: Alignment.topLeft,
                                              ),
                                              "th": Style(
                                                padding: HtmlPaddings.all(6),
                                                backgroundColor:
                                                    Colors.grey.shade300,
                                                textAlign: TextAlign.left,
                                              ),
                                              "td": Style(
                                                padding: HtmlPaddings.all(6),
                                                textAlign: TextAlign.left,
                                              ),
                                            },
                                            onLinkTap: (String? url,
                                                Map<String, String> attributes,
                                                dom.Element? element) async {
                                              if (url != null) {
                                                final uri = Uri.parse(url);
                                                if (await canLaunchUrl(uri)) {
                                                  await launchUrl(uri,
                                                      mode: LaunchMode
                                                          .externalApplication); // Opens in browser
                                                } else {
                                                  print(
                                                      "❌ Could not launch $url");
                                                }
                                              }
                                            },
                                          ),
                                        }
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            const SizedBox(height: 20),
                            // product Additional Info
                            if (controller.productDetail?.shortDescription !=
                                null)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Additional Info",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                      color: AppColors
                                                          .primaryColor,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w700),
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                isAdditonalInfoExpanded
                                                    ? Icons.keyboard_arrow_up
                                                    : Icons.keyboard_arrow_down,
                                                color: AppColors.primaryColor,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  isAdditonalInfoExpanded =
                                                      !isAdditonalInfoExpanded;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 3),
                                        if (isAdditonalInfoExpanded) ...{
                                          // ReadMoreHtml(
                                          //   data: controller.productDetail != null
                                          //       ? controller.productDetail?.shortDescription
                                          //       : "",
                                          //   maxLines: 6,
                                          //   // Set the maximum number of lines before showing "Read More"
                                          //   textStyle: const TextStyle(
                                          //     color: AppColors.primaryBlack,
                                          //     fontSize: 12.0,
                                          //   ),
                                          //   textAlign: TextAlign.justify,
                                          // ),
                                          Html(
                                            data: controller.productDetail
                                                    ?.shortDescription ??
                                                "",
                                            extensions: const [
                                              TableHtmlExtension(),
                                              // Required for rendering <table>
                                            ],
                                            style: {
                                              "body": Style(
                                                margin: Margins.zero,
                                                padding: HtmlPaddings.zero,
                                                fontSize: FontSize(12.0),
                                                color: AppColors.primaryBlack,
                                              ),
                                              "table": Style(
                                                alignment: Alignment.topLeft,
                                                margin: Margins.zero,
                                                padding: HtmlPaddings.zero,
                                                backgroundColor:
                                                    Colors.grey.shade100,
                                                border: Border.all(
                                                    color: Colors.black12),
                                              ),
                                              "tr": Style(
                                                alignment: Alignment.topLeft,
                                              ),
                                              "th": Style(
                                                padding: HtmlPaddings.all(6),
                                                backgroundColor:
                                                    Colors.grey.shade300,
                                                textAlign: TextAlign.left,
                                              ),
                                              "td": Style(
                                                padding: HtmlPaddings.all(6),
                                                textAlign: TextAlign.left,
                                              ),
                                            },
                                            onLinkTap: (String? url,
                                                Map<String, String> attributes,
                                                dom.Element? element) async {
                                              if (url != null) {
                                                final uri = Uri.parse(url);
                                                if (await canLaunchUrl(uri)) {
                                                  await launchUrl(uri,
                                                      mode: LaunchMode
                                                          .externalApplication); // Opens in browser
                                                } else {
                                                  print(
                                                      "❌ Could not launch $url");
                                                }
                                              }
                                            },
                                          ),
                                        }
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            const SizedBox(height: 20),
                            // Product Manufacturer Info
                            if (controller.productDetail?.manufacturerDetails !=
                                null)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Manufacturer Info",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                      color: AppColors
                                                          .primaryColor,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w700),
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                isManufectureInfoExpanded
                                                    ? Icons.keyboard_arrow_up
                                                    : Icons.keyboard_arrow_down,
                                                color: AppColors.primaryColor,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  isManufectureInfoExpanded =
                                                      !isManufectureInfoExpanded;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 3),
                                        if (isManufectureInfoExpanded) ...{
                                          Html(
                                            data: controller.productDetail
                                                    ?.manufacturerDetails ??
                                                "",
                                            extensions: const [
                                              TableHtmlExtension(),
                                              // Required for rendering <table>
                                            ],
                                            style: {
                                              "body": Style(
                                                margin: Margins.zero,
                                                padding: HtmlPaddings.zero,
                                                fontSize: FontSize(12.0),
                                                color: AppColors.primaryBlack,
                                              ),
                                              "table": Style(
                                                alignment: Alignment.topLeft,
                                                margin: Margins.zero,
                                                padding: HtmlPaddings.zero,
                                                backgroundColor:
                                                    Colors.grey.shade100,
                                                border: Border.all(
                                                    color: Colors.black12),
                                              ),
                                              "tr": Style(
                                                alignment: Alignment.topLeft,
                                              ),
                                              "th": Style(
                                                padding: HtmlPaddings.all(6),
                                                backgroundColor:
                                                    Colors.grey.shade300,
                                                textAlign: TextAlign.left,
                                              ),
                                              "td": Style(
                                                padding: HtmlPaddings.all(6),
                                                textAlign: TextAlign.left,
                                              ),
                                            },
                                            onLinkTap: (String? url,
                                                Map<String, String> attributes,
                                                dom.Element? element) async {
                                              if (url != null) {
                                                final uri = Uri.parse(url);
                                                if (await canLaunchUrl(uri)) {
                                                  await launchUrl(uri,
                                                      mode: LaunchMode
                                                          .externalApplication); // Opens in browser
                                                } else {
                                                  print(
                                                      "❌ Could not launch $url");
                                                }
                                              }
                                            },
                                          ),
                                        }
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            const SizedBox(height: 20),

                            /// Reviews On Product
                            if (controller.reviews.isNotEmpty)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Divider(
                                      color: AppColors.divideColor,
                                    ),
                                    Text("Review ",
                                        maxLines: 3,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.primaryBlack)),
                                    const SizedBox(height: 20),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        child: ListView.separated(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          separatorBuilder: (context, index) =>
                                              const Divider(
                                                  color: AppColors.divideColor),
                                          shrinkWrap: true,
                                          itemCount: controller.reviews.length,
                                          itemBuilder: (context, index) {
                                            var review =
                                                controller.reviews[index];
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: Container(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      RatingBar(
                                                        itemSize: 20,
                                                        initialRating:
                                                            (review.rating ?? 0)
                                                                .toDouble(),
                                                        direction:
                                                            Axis.horizontal,
                                                        allowHalfRating: false,
                                                        tapOnlyMode: false,
                                                        ignoreGestures: true,
                                                        itemCount: 5,
                                                        ratingWidget:
                                                            RatingWidget(
                                                          full: const Icon(
                                                            Icons.star,
                                                            color: AppColors
                                                                .primaryBlack,
                                                            size: 18,
                                                          ),
                                                          half: const Icon(
                                                            Icons.star_half,
                                                            color: AppColors
                                                                .primaryBlack,
                                                            size: 18,
                                                          ),
                                                          empty: const Icon(
                                                            Icons.star_outline,
                                                            color: Colors.grey,
                                                            size: 18,
                                                          ),
                                                        ),
                                                        onRatingUpdate:
                                                            (value) {
                                                          // setState(() {
                                                          //   read.tutorRating = value;
                                                          // });
                                                        },
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    8.0),
                                                        child: Text(
                                                          review.message ?? "",
                                                          // maxLines: 3,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyLarge
                                                              ?.copyWith(
                                                                  color: AppColors
                                                                      .grey1),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),

                                                      // if ((review.images ??"" ).split(",").last.split(",").isNotEmpty)

                                                      Visibility(
                                                        visible:
                                                            (review.images ??
                                                                    "")
                                                                .split(",")
                                                                .isNotEmpty,
                                                        replacement:
                                                            const SizedBox(),
                                                        child: Container(
                                                          height: 40,
                                                          // Adjust the height as needed
                                                          child: ListView(
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            children: review
                                                                    .images
                                                                    ?.split(",")
                                                                    .map(
                                                                        (image) {
                                                                  if (image
                                                                      .isNotEmpty) {
                                                                    return Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              8.0),
                                                                      child:
                                                                          GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          _modalBottomSheetMenu(
                                                                              context,
                                                                              "$reviewImageURL$image");
                                                                        },
                                                                        child: Image
                                                                            .network(
                                                                          "$reviewImageURL$image",
                                                                          height:
                                                                              35,
                                                                          // Adjust the height as needed
                                                                          width:
                                                                              55,
                                                                          // Adjust the width as needed
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  } else {
                                                                    return const SizedBox(); // Or any placeholder widget if needed
                                                                  }
                                                                }).toList() ??
                                                                [],
                                                          ),
                                                        ),
                                                      ),
                                                      if (review.images != "")
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                      Text(
                                                        "Reviewed by: ${review.user?.name}",
                                                        maxLines: 3,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge
                                                            ?.copyWith(
                                                                color: AppColors
                                                                    .primaryBlack),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                onRefresh: () =>
                    controller.getProductDetail(widget.productSlug, widget.id)),
          ),
        );
      },
    );
  }

  _modalBottomSheetMenu(
    context,
    imageUrl,
  ) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              backgroundColor: AppColors.white,
              surfaceTintColor: AppColors.white,
              content: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.sizeOf(context).width * .8,
                  child: Image.network(
                    imageUrl,
                    height: MediaQuery.sizeOf(context).height *
                        .4, // Adjust the height as needed
                    width: MediaQuery.sizeOf(context).width *
                        .7, // Adjust the width as needed
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  viewImageInZoom(
    context,
    image,
  ) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              backgroundColor: AppColors.white,
              surfaceTintColor: AppColors.white,
              content: SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(
                        height: MediaQuery.sizeOf(context).height * .9,
                        child: PhotoViewGallery.builder(
                          scrollPhysics: const BouncingScrollPhysics(),
                          builder: (BuildContext context, int index) {
                            return PhotoViewGalleryPageOptions(
                              imageProvider: NetworkImage(
                                  "$productListImageURL${image[index]}"),
                              initialScale:
                                  PhotoViewComputedScale.contained * 1,
                              minScale: PhotoViewComputedScale.covered * .5,
                              maxScale: PhotoViewComputedScale.covered * 2,
                              // heroAttributes: PhotoViewHeroAttributes(tag: galleryItems[index].id),
                            );
                          },
                          itemCount: image.length,
                          loadingBuilder: (context, event) => Center(
                            child: Container(
                              width: 20.0,
                              height: 20.0,
                              child: CircularProgressIndicator(
                                value: event == null ? 0 : 2,
                              ), /**/
                            ),
                          ),
                          // backgroundDecoration: widget.backgroundDecoration,
                          // pageController: widget.pageController,
                          // onPageChanged: onPageChanged,
                        )),
                    const Positioned(
                        top: 50,
                        right: 50,
                        child: Icon(
                          Icons.close,
                          size: 25,
                          color: Colors.red,
                        ))
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class FullScreenImageGallery extends StatelessWidget {
  final List<dynamic> imageUrls; // List of image URLs for the product

  const FullScreenImageGallery({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.close)),
      ),
      body: Container(
        child: PhotoViewGallery.builder(
          itemCount: imageUrls.length,
          builder: (context, index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(index == 0
                  ? "$imageURL${imageUrls[index]}"
                  : "$productListImageURL${imageUrls[index]}"),
              initialScale: PhotoViewComputedScale.contained * 1,
              minScale: PhotoViewComputedScale.contained * .5,
              maxScale: PhotoViewComputedScale.covered * 3,
            );
          },
          scrollPhysics: const BouncingScrollPhysics(),
          backgroundDecoration: const BoxDecoration(
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
