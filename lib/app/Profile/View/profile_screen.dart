import 'package:e_commerce/app/Auth/view/login_screen.dart';
import 'package:e_commerce/app/Order/Controller/order_controller.dart';
import 'package:e_commerce/app/Order/View/order_history.dart';
import 'package:e_commerce/app/Profile/View/contact_screen.dart';
import 'package:e_commerce/app/Profile/View/referral_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/app_colors.dart';
import '../../../common_widgets/app_strings.dart';
import '../../../config/shared_prif.dart';
import '../Controller/profile_controller.dart';
import 'address_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var provider = Provider.of<ProfileController>(context, listen: false);
    provider.getAllAddress();
    // provider.defaultAddress;

    return Consumer<ProfileController>(
      builder: (context, controller, child) => Scaffold(
        body: SafeArea(
            child: Visibility(
              visible: !loading,
              replacement: const Center(
                child: CircularProgressIndicator.adaptive(),),
              child: ListView(
                children: [
                  ListTile(
                contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                leading: Container(
                  width: 50,
                  height: 50,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        "assets/images/splash2.png",
                        width: 50,
                        height: 100,
                        fit: BoxFit.cover,
                      )),
                ),
                title: Text(
                  SharedStorage.instance.userName ?? "",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                subtitle: Text(
                  SharedStorage.instance.userEmail ?? "",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: [
                        Consumer<OrderController>(
                      builder: (context, value, child) => ListTile(
                        onTap: () {
                          var provider = Provider.of<OrderController>(context,
                              listen: false);
                          provider.getOrders();
                          Get.to(const OrderScreen());
                        },
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 10, 10, 10),
                        title: const Text("My Order"),
                        subtitle: Text(
                          "Already ${value.order.length} order",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(color: AppColors.divideColor),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                        ListTile(
                      onTap: () {
                        Get.to(const AddressesScreen());
                      },
                      contentPadding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                      title: const Text("Saved Address"),
                      subtitle: Text(
                        "${controller.addressLength} Address",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(color: AppColors.divideColor),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                        ListTile(
                      onTap: () {
                        controller.getContactDetail();
                        Get.to(ContactScreen());
                      },
                      contentPadding: EdgeInsets.fromLTRB(20, 10, 10, 10),

                      title: Text("Contact Us"),
                      // subtitle: Text("Visa **34",style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.divideColor),),
                      trailing: Icon(Icons.arrow_forward_ios), ),
                        ListTile(
                      onTap: () {
                        Get.to(ReferralScreen());
                      },
                      contentPadding: EdgeInsets.fromLTRB(20, 10, 10, 10),

                      title: const Text("Refer"),
                      // subtitle: Text("Visa **34",style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.divideColor),),
                      trailing: Icon(Icons.arrow_forward_ios), ),
                        ListTile(
                      onTap: () {
                        openDialog(context, controller);
                        // logoutApp
                      },
                      contentPadding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                      title: const Text("Log Out"),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  openDialog(BuildContext context, ProfileController controller) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              backgroundColor: AppColors.white,
              surfaceTintColor: AppColors.white,
              title: Text(
                "Confirm logout?",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              content: Text(
                "Are You Sure !, You want to logout ?",
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
                      controller.logoutApp();

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
