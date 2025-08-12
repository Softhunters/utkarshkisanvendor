import 'package:currency_converter/currency.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:utkrashvendor/app/CartSection/Controller/cart_controller.dart';
import 'package:utkrashvendor/app/Notification/notification_screen.dart';
import 'package:utkrashvendor/app/Order/Controller/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../common_widgets/app_colors.dart';
import '../../widgets/app_button_widget.dart';
import '../CartSection/View/Cart/cart_screen.dart';
import '../CartSection/View/CheckOut/check_out_screen.dart';
import '../CartSection/View/CheckOut/shipping_address.dart';
import '../Home/controller/home_controller.dart';
import '../Home/view/home_screen.dart';
import '../Order/View/order_history.dart';
import '../Profile/Controller/profile_controller.dart';
import '../Profile/View/profile_screen.dart';
import '../Wallet/Controller/wallets_controller.dart';
import '../Wallet/views/wallet_screen.dart';
import '../WalletSection/View/wallet_screen.dart';
import '../Wishlist/wishlist_screen.dart';

import 'package:badges/badges.dart' as badges;

class BottomBarScreen extends StatefulWidget {
  final int? index;
  final int type;

  const BottomBarScreen({super.key, this.index, required this.type});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedIndex = 0;

  final List _widgets = [
     HomeScreen(),
    const CartScreen(),
    const OrderScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    _selectedIndex = widget.index ?? 0;
    a();
    super.initState();
  }

  HomeController homeController = HomeController();

  a() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeController = Provider.of<HomeController>(context, listen: false);
      var wProvider = Provider.of<WalletsController>(context, listen: false);
      var profileProvider =
          Provider.of<ProfileController>(context, listen: false);

      homeController.getHomeData(1);
      homeController.setApiType(widget.type);
      wProvider.getWalletData(0);
      profileProvider.getContactDetail();
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  String _getGreeting() {
    var currentHour = DateTime.now().hour;

    if (currentHour < 12) {
      return 'Good Morning';
    } else if (currentHour >= 12 && currentHour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  @override
  Widget build(BuildContext context) {
    Object? categoryId = ModalRoute.of(context)!.settings.arguments;
    var provider = Provider.of<OrderController>(context, listen: false);
    var provider1 = Provider.of<CurrencyProvider>(context, listen: false);
    provider.getOrders();
    provider1.getCurrency();

// provider1.getExchangeRate();
    return Consumer<CartController>(
      builder: (context, controller, child) => Scaffold(
        key: _scaffoldkey,
        appBar: _selectedIndex == 0
            ? AppBar(
                automaticallyImplyLeading: false,
                title: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (_scaffoldkey.currentState!.isDrawerOpen) {
                          _scaffoldkey.currentState?.closeDrawer();
                        } else {
                          _scaffoldkey.currentState?.openDrawer();
                        }
                        // Get.to(DrawerScreen());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            border: Border.all(color: AppColors.primaryColor),
                            borderRadius: BorderRadius.circular(50)),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(
                                "assets/images/app_icon.png",
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
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
                          builder: (context, home, child) => Text(
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
                  // Consumer<HomeController>(builder: (context, hValue, child) =>  Text(hValue.selectedCurrency,style: Theme.of(context).textTheme.titleMedium,)),

                  // Consumer<CurrencyProvider>(
                  //   builder: (context, hValue, child) =>
                  //       DropdownButtonHideUnderline(
                  //     child: DropdownButton2<Currency>(
                  //       value: hValue.selectedCurrency,
                  //       style: const TextStyle(
                  //           fontSize: 14, fontWeight: FontWeight.normal),
                  //       iconStyleData: const IconStyleData(
                  //           icon: Icon(
                  //             Icons.keyboard_arrow_down_outlined,
                  //           ),
                  //           iconSize: 30,
                  //           iconEnabledColor: AppColors.primaryColor),
                  //       isExpanded: true,
                  //       // hint: const Text(
                  //       //   "inr",
                  //       //   style: TextStyle(
                  //       //       fontSize: 14, fontWeight: FontWeight.normal),
                  //       // ),
                  //       items: [
                  //         ...hValue.currencyList
                  //             .map((e) => DropdownMenuItem(
                  //                 value: e,
                  //                 child: SizedBox(
                  //                   height:
                  //                       MediaQuery.sizeOf(context).width * .05,
                  //                   width:
                  //                       MediaQuery.sizeOf(context).width * .65,
                  //                   child: Text(e.name.capitalize ?? '',
                  //                       style: TextStyle(
                  //                           fontSize: 14,
                  //                           fontWeight: FontWeight.w600,
                  //                           color: Theme.of(context)
                  //                               .primaryColor)),
                  //                 )))
                  //             .toList(),
                  //       ],
                  //       onChanged: (Currency? value) {
                  //         hValue.updateCurrency(
                  //           value!,
                  //           (value) {
                  //             if (value == true) {
                  //               setState(() {
                  //                 homeController.getHomeData(0);
                  //               });
                  //             }
                  //           },
                  //         );
                  //       },
                  //       menuItemStyleData: const MenuItemStyleData(
                  //         height: 45,
                  //       ),
                  //       buttonStyleData: ButtonStyleData(
                  //         height: 40,
                  //         width: 73,
                  //         padding: const EdgeInsets.only(left: 4, right: 4),
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(14),
                  //         ),
                  //         elevation: 0,
                  //       ),
                  //       dropdownStyleData: DropdownStyleData(
                  //         maxHeight: MediaQuery.sizeOf(context).height * .8,
                  //         width: MediaQuery.sizeOf(context).width * .6,
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(14),
                  //           color: Colors.white,
                  //         ),
                  //         offset: const Offset(-20, 0),
                  //         scrollbarTheme: ScrollbarThemeData(
                  //           radius: const Radius.circular(40),
                  //           thickness: MaterialStateProperty.all(6),
                  //           thumbVisibility: MaterialStateProperty.all(true),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(
                    width: 10,
                  ),
                  Consumer<HomeController>(
                    builder: (context, provider, child) => GestureDetector(
                        onTap: () {
                          Get.to(()=>const WishlistScreen());
                        },
                        child: badges.Badge(
                          onTap: () {
                            Get.to(()=>const WishlistScreen());
                          },
                          badgeContent: Text(
                              provider.allWishListProducts.isNotEmpty
                                  ? "${provider.allWishListProducts.length}"
                                  : "0"),
                          child: const Icon(Icons.favorite_border),
                        )),
                  ),
                  const SizedBox(
                    width: 25,
                  )
                ],
              )
            : AppBar(
                automaticallyImplyLeading: false,
                title: Row(
                  children: [
                    Image.asset(
                      "assets/images/app_icon.png",
                      height: 30,
                      width: 30,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(_selectedIndex == 1
                        ? "My Cart"
                        : _selectedIndex == 2
                            ? "Orders"
                            : "Menu"),
                  ],
                ),
                centerTitle: false,
                actions: [
                  if (_selectedIndex == 1 && controller.cartData.isNotEmpty)
                    GestureDetector(
                        onTap: () {
                          openDialog(controller);
                        },
                        child: Icon(Icons.delete_sweep_outlined)),
                  const SizedBox(
                    width: 15,
                  )
                ],
              ),
        // drawer: const DrawerScreen(),

        body: _widgets[_selectedIndex],
        bottomNavigationBar: Card(
          elevation: 20,
          semanticContainer: true,
          shadowColor: AppColors.textFieldColor,
          surfaceTintColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _selectedIndex == 1 && controller.cartData.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 200,
                            child: AppButton(
                              title: "Check Out",
                              width: 300,
                              height: 40,
                              onTap: () {
                                var provider = Provider.of<ProfileController>(
                                    context,
                                    listen: false);
                                if (provider.defaultAddress.isNotEmpty) {
                                  controller.getCheckOutData();

                                } else {
                                  Get.to(()=>const ShippingAddressScreen());
                                }
                              },
                            ),
                          ),
                         Consumer<CartController>(builder: (context,cartController, _){
                           return  Column(
                             mainAxisSize: MainAxisSize.min,
                             children: [
                              GestureDetector(
                                onTap:(){

                                },
                                child:  Text(
                                  "Total Price",
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                               Text(
                                 "₹ ${cartController.cartTotal} ",
                                 style: Theme.of(context)
                                     .textTheme
                                     .titleMedium
                                     ?.copyWith(fontWeight: FontWeight.w600),
                               ),
                             ],
                           );
                         }),
                        ],
                      ),
                    )
                  : const SizedBox(),
              BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                currentIndex: _selectedIndex,
                // backgroundColor: Colors.amber,
                selectedItemColor: AppColors.primaryColor,
                unselectedItemColor: AppColors.divideColor,

                selectedLabelStyle: const TextStyle(
                    color: AppColors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
                unselectedLabelStyle: const TextStyle(
                    fontSize: 10, fontWeight: FontWeight.normal),
                onTap: _onItemTapped,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      "assets/images/home.png",
                      width: _selectedIndex == 0 ? 25 : 20,
                      color: _selectedIndex == 0
                          ? AppColors.primaryColor
                          : AppColors.divideColor,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: badges.Badge(
                      position: badges.BadgePosition.topEnd(top: -10, end: -15),
                      showBadge: true,
                      ignorePointer: false,
                      onTap: () {
                        setState(() {
                          _selectedIndex = 1;
                        });
                      },
                      badgeContent: Text(controller.cartData.isNotEmpty
                          ? "${controller.cartData.length}"
                          : "0"),
                      badgeAnimation: const badges.BadgeAnimation.rotation(
                        animationDuration: Duration(seconds: 1),
                        colorChangeAnimationDuration: Duration(seconds: 1),
                        loopAnimation: false,
                        curve: Curves.fastOutSlowIn,
                        colorChangeAnimationCurve: Curves.easeInCubic,
                      ),
                      child: Image.asset(
                        "assets/images/cart.png",
                        width: _selectedIndex == 1 ? 25 : 20,
                        color: _selectedIndex == 1
                            ? AppColors.primaryColor
                            : AppColors.divideColor,
                      ),
                    ),
                    label: 'Cart',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      "assets/images/wallet.png",
                      color: _selectedIndex == 2
                          ? AppColors.primaryColor
                          : AppColors.divideColor,
                      width: _selectedIndex == 2 ? 25 : 20,
                    ),
                    label: 'Orders',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      "assets/images/progile.png",
                      color: _selectedIndex == 3
                          ? AppColors.primaryColor
                          : AppColors.divideColor,
                      width: _selectedIndex == 3 ? 25 : 20,
                    ),
                    label: 'Profile',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  openDialog(CartController controller) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              backgroundColor: AppColors.white,
              surfaceTintColor: AppColors.white,
              title: Text(
                "Clear All Cart Item ?",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              content: Text(
                "Are You Sure, you want to clear product from cart.",
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
                      setState(() {
                        Navigator.pop(context);
                        controller.clearCartDAta();
                      });
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
