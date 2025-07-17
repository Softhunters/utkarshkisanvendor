import 'package:utkrashvendor/app/Home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/app_colors.dart';
import '../../../widgets/app_button_widget.dart';
import '../../../widgets/text_fields.dart';

class ReferralScreen extends StatelessWidget {
  const ReferralScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    return Consumer<HomeController>(
        builder: (context, controller, child) => Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                leading: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(Icons.arrow_back)),
                title: Text("Refer",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w500)),
                centerTitle: false,
                elevation: 0,
                surfaceTintColor: AppColors.white,
              ),
              body: SafeArea(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: width*.05,
                    ),
                    Image.asset("assets/images/ref.png",),
                    SizedBox(
                      height: width*.1,
                    ),
                    Text(
                      "Refer & Earn",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Refer a friend and earn 50 coin \n when  they purchase first \n product.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: AppColors.primaryBlack),
                    ),
                    SizedBox(
                      height: width*.2,
                    ),
                    Container(
                      height: 50,
                      width: width * .9,
                      decoration: BoxDecoration(border: Border.all(),
                      borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        children: [
                          Container(
                            width: width * .590,
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10))),
                            child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      controller.myReferralCode,
                                      style: Theme.of(context).textTheme.titleLarge,
                                    ),
                                    GestureDetector(
                                                                  onTap: () async {
                                    Clipboard.setData(ClipboardData(
                                            text: controller.myReferralCode))
                                        .then((_) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                              content:
                                                  Text(controller.myReferralCode)));
                                    });

                                                                  },
                                                                  child:Icon(Icons.copy)
                                                                ),
                                  ],
                                )),
                          ),
                          Expanded(child: GestureDetector(
                            onTap: () {
                              controller.shareApp(controller.myReferralCode);
                            },
                            child: Container(
                              // width: width * .3,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)),
                                  color: AppColors.primaryColor),
                              child: Center(
                                  child: Text(
                                    "Share",
                                    style: Theme.of(context).textTheme.titleSmall,
                                  )),
                            ),
                          )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    if (controller.referBy == "null")
                      GestureDetector(
                        onTap: () {
                          openDialog(context, controller);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "You have referral code?",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.blue),
                          ),
                        ),
                      ),
                  ],
                ),
              )),
            ));
  }

  openDialog(BuildContext context, HomeController controller) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              backgroundColor: AppColors.white,
              surfaceTintColor: AppColors.white,
              title: Text(
                "Referral",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    color: AppColors.divideColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppTextFormWidget(
                      hintText: "Enter Referral code",
                      controller: controller.referralCodeController,
                      hintStyle: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: AppColors.divideColor),
                      maxLines: 5,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
                          title: "Cancel",
                          onTap: () {
                            Get.back();
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
                          title: "Submit",
                          onTap: () {
                            if (controller
                                .referralCodeController.text.isNotEmpty) {
                              Get.back();
                              controller.applyReferral();
                            } else {}
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
