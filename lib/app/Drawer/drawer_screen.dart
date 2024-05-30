import 'package:e_commerce/common_widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../bottom_bar/bottom_bar_screen.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Drawer(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      backgroundColor: AppColors.white,
      child: Column(children: [
        DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/appbar_con.png",
                    cacheHeight: 60,
                    cacheWidth: 60,
                  ),
                  const SizedBox(height: 10,),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                    ],
                  ),
                ],
              ),
            )),
        ListTile(
          onTap: () {
            Get.back();
            // Get.to(const AboutUsScreen());
          },
          leading: const Icon(Icons.home, color: AppColors.primaryColor),
          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
          title: Text(
            "Home",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.black),
          ),
        ),
        ListTile(
          onTap: () {

            Navigator.push(context, MaterialPageRoute(builder: (context) => const BottomBarScreen(index: 1,type: 1,),));


          },
          leading: Image.asset("assets/images/cart.png", color: AppColors.primaryColor,width: 20,),
          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
          title: Text(
            "Cart",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.black),
          ),
        ),
        ListTile(
          onTap: () {
            Get.back();
            // Get.to(const AboutUsScreen());
          },
          leading: Image.asset("assets/images/order_history.png",width: 20,),
          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
          title: Text(
            "Order",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.black),
          ),
        ),
      ],),
    );
  }
}
