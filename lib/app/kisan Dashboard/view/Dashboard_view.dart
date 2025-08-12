import 'package:badges/badges.dart' as badges;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:utkrashvendor/app/kisan%20Dashboard/view/vandor_orders_view.dart';
import 'package:utkrashvendor/app/kisan%20Dashboard/view/variant_list_view.dart';
import 'package:utkrashvendor/widgets/app_button_widget.dart';

import '../../../common_widgets/app_colors.dart';
import '../../../common_widgets/urls.dart';
import '../../../constant/cons.dart';
import '../../../widgets/cache_network_image.dart';
import '../../../widgets/text_fields.dart';
import '../../Home/controller/home_controller.dart';
import '../../Search/search_screen.dart';
import '../../Wishlist/wishlist_screen.dart';
import '../../bottom_bar/bottom_bar_screen.dart';
import '../controller/dashboard_controller.dart';
import 'order_list_view.dart';
import '../view/product_inventory_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  void initState() {
    super.initState();
    final controller = Provider.of<DashboardController>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getHomeData();
    }); // Fetch dashboard data
  }

  String _getGreeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return Consumer<DashboardController>(
      builder: (context, controller, _) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border.all(color: AppColors.primaryColor),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        "assets/images/app_icon.png",
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getGreeting(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: AppColors.green),
                  ),
                  Consumer<HomeController>(
                    builder: (context, home, _) => Text(
                      home.userName.capitalize ?? "",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ],
          ),
          centerTitle: false,
          actions: [
            Consumer<HomeController>(
              builder: (context, provider, _) => GestureDetector(
                  onTap: () => Get.to(() => const WishlistScreen()),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 12,
                      ),
                      badges.Badge(
                        badgeContent: Text(
                          provider.allWishListProducts.isNotEmpty
                              ? "${provider.allWishListProducts.length}"
                              : "0",
                        ),
                        child: const Icon(Icons.favorite_border),
                      ),
                    ],
                  )),
            ),
            const SizedBox(width: 25),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Visibility(
              visible: !controller.isLoading,
              replacement: const Center(child: CupertinoActivityIndicator()),
              child: RefreshIndicator(
                onRefresh: () => controller.getHomeData(),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => Get.to(() => const SearchScreen()),
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
                    const SizedBox(height: 20),
                    // Add your actual dashboard widgets here

                    Row(
                      children: [
                        Expanded(
                            child: Card(
                          color: AppColors.primaryColor,
                          elevation: 4,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 30),
                            child: Column(
                              children: [
                                Text(
                                  "Total Products",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                          color: AppColors.white, fontSize: 16),
                                ),
                                Text(
                                  controller.dashboard?.totalProducts
                                          .toString() ??
                                      '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge
                                      ?.copyWith(color: AppColors.white),
                                )
                              ],
                            ),
                          ),
                        )),
                        Expanded(
                            child: Card(
                          color: AppColors.primaryColor,
                          elevation: 4,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 30),
                            child: Column(
                              children: [
                                Text(
                                  "Total Sellers",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                          color: AppColors.white, fontSize: 16),
                                ),
                                Text(
                                  controller.dashboard?.totalSellers
                                          .toString() ??
                                      '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge
                                      ?.copyWith(color: AppColors.white),
                                )
                              ],
                            ),
                          ),
                        ))
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: GestureDetector(
                          onTap: () async {
                            await controller.getVariantData();
                            Get.to(() => VariantListView());
                          },
                          child: Card(
                            color: AppColors.primaryColor,
                            elevation: 4,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 30),
                              child: Column(
                                children: [
                                  Text(
                                    "Your Products",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            color: AppColors.white,
                                            fontSize: 16),
                                  ),
                                  Text(
                                    controller.dashboard?.vendorProducts
                                            .toString() ??
                                        '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge
                                        ?.copyWith(color: AppColors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )),
                        Expanded(
                            child: GestureDetector(
                          onTap: () async {
                            await controller.getVendorOrdersData();
                            Get.to(() => VandorOrdersView());
                          },
                          child: Card(
                            color: AppColors.primaryColor,
                            elevation: 4,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 30),
                              child: Column(
                                children: [
                                  Text(
                                    "Your Orders",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            color: AppColors.white,
                                            fontSize: 16),
                                  ),
                                  Text(
                                    controller.dashboard?.totalVendorOrders
                                            .toString() ??
                                        '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge
                                        ?.copyWith(color: AppColors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: GestureDetector(
                              onTap: ()async{
                                await controller.getOrderHistoryByProductData();
                                Get.to(()=>ProductInventoryView());

                              },
                              child: Card(
                                color: AppColors.primaryColor,
                                elevation: 4,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 30),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Product Inventory",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                            color: AppColors.white, fontSize: 16),
                                      ),
                                      // Text(
                                      //   controller.dashboard?.totalProducts
                                      //       .toString() ??
                                      //       '',
                                      //   style: Theme.of(context)
                                      //       .textTheme
                                      //       .headlineLarge
                                      //       ?.copyWith(color: AppColors.white),
                                      // )
                                    ],
                                  ),
                                ),
                              ),
                            )),

                      ],
                    ),


                    Spacer(),
                    AppButton(title: "Go to Home", onTap: (){
                      Get.offAll(
                        const BottomBarScreen(
                          index: 0,
                          type: 0,
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
