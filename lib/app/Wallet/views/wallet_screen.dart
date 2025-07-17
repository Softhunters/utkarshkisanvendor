import 'package:utkrashvendor/common_widgets/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Controller/wallets_controller.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<WalletsController>(context, listen: false);
    // provider.getWalletData(1);
    return Consumer<WalletsController>(
      builder: (context, controller, child) => Scaffold(
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: ListView(
            children: [
              // const SizedBox(
              //   height: 20,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       "My Account",
              //       style: Theme.of(context)
              //           .textTheme
              //           .headlineLarge
              //           ?.copyWith(fontWeight: FontWeight.w700),
              //     ),
              //     Image.asset(
              //       "assets/images/splash_icon.png",
              //       width: 35,
              //     )
              //   ],
              // ),
              Center(
                  child: Padding(
                padding: const EdgeInsets.only(
                    top: 25, left: 10, right: 10, bottom: 10),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.4, color: Colors.grey),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      )),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    child: CupertinoSlidingSegmentedControl<int>(
                        backgroundColor: Theme.of(context).highlightColor,
                        thumbColor: AppColors.primaryColor,
                        padding: EdgeInsets.zero,
                        groupValue: controller.segmentedControlGroupValue,
                        onValueChanged: (value) {
                          controller.setsegmentValu(value);
                        },
                        children: {
                          0: Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              "Wallet",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      color: controller
                                                  .segmentedControlGroupValue ==
                                              0
                                          ? AppColors.white
                                          : AppColors.primaryBlack),
                            ),
                          ),
                          1: Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              "Reward",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      color: controller
                                                  .segmentedControlGroupValue ==
                                              1
                                          ? AppColors.white
                                          : AppColors.primaryBlack),
                            ),
                          )
                        }),
                  ),
                ),
              )),
              const SizedBox(
                height: 30,
              ),
              controller.segmentedControlGroupValue == 0
                  ? Row(
                      children: [
                        Text(
                          "₹ ${controller.totalWallet}/-",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .4,
                        ),
                        Image.asset(
                          "assets/images/rupee.png",
                          height: 70,
                        ),
                        const SizedBox(
                          width: 10,
                        )
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          "assets/images/coin.png",
                          height: 70,
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .4,
                        ),
                        Text(
                          "${controller.totalReward} Coin",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        )
                      ],
                    ),
              const SizedBox(
                height: 30,
              ),
              if (controller.segmentedControlGroupValue == 1
                  ? controller.rewardHistory.isNotEmpty
                  : controller.walletHistory.isNotEmpty)
                Text(
                  "Transaction",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
              controller.segmentedControlGroupValue == 0
                  ? Container(
                      child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.walletHistory.length,
                      itemBuilder: (context, index) {
                        var wallet = controller.walletHistory[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: ListTile(
                            leading: wallet.status == 1
                                ? const Icon(Icons.arrow_upward_outlined,
                                    color: AppColors.green)
                                : const Icon(Icons.arrow_downward_outlined,
                                    color: AppColors.redColor),
                            title: Text.rich(
                              TextSpan(
                                children: [
                                  const TextSpan(text: 'Order no. : '),
                                  TextSpan(
                                    text: '${wallet.orderNumber}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            subtitle: Text(
                              "${wallet.createdAt?.split("T").first}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            trailing: Text(
                              "${wallet.status == 1 ? "+" : "-"} ₹ ${double.parse(wallet.amount ?? "0.0").toStringAsFixed(0)}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: wallet.status == 1
                                          ? AppColors.green
                                          : AppColors.redColor),
                            ),
                          ),
                        );
                      },
                    ))
                  : Container(
                      child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.rewardHistory.length,
                      itemBuilder: (context, index) {
                        var wallet = controller.rewardHistory[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: ListTile(
                            leading: wallet.status == 1
                                ? const Icon(Icons.arrow_upward_outlined,
                                    color: AppColors.green)
                                : const Icon(Icons.arrow_downward_outlined,
                                    color: AppColors.redColor),
                            title: Text.rich(
                              TextSpan(
                                children: [
                                  const TextSpan(text: 'Order no. : '),
                                  TextSpan(
                                    text: '${wallet.orderNumber}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            subtitle: Text(
                              "${wallet.createdAt?.split("T").first}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            trailing: Text(
                              "${wallet.status == 1 ? "+" : "-"}${double.parse(wallet.point ?? "0.0").toStringAsFixed(0)}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: wallet.status == 1
                                          ? AppColors.green
                                          : AppColors.redColor),
                            ),
                          ),
                        );
                      },
                    ))
            ],
          ),
        )),
      ),
    );
  }
}
