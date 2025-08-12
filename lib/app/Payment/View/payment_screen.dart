import 'package:utkrashvendor/app/CartSection/Controller/cart_controller.dart';
import 'package:utkrashvendor/app/Wallet/Controller/wallets_controller.dart';
import 'package:utkrashvendor/app/bottom_bar/bottom_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/app_colors.dart';
import '../../../common_widgets/snack_bar.dart';
import '../../../constant/cons.dart';
import '../../../widgets/app_button_widget.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';




class PaymentOptionScreen extends StatefulWidget {
  const PaymentOptionScreen({super.key});

  @override
  State<PaymentOptionScreen> createState() => _PaymentOptionScreenState();
}

class _PaymentOptionScreenState extends State<PaymentOptionScreen> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    // _razorpay = Razorpay('rzp_test_29aiezLXka3rYI');     //demo key
    _razorpay = Razorpay('rzp_live_6jOXQXTAPpkkID');        // live key
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async{
    final controller = Provider.of<CartController>(context, listen: false);


    final data = PaymentModel(
      paymentType:
      controller.selectedPaymentMethod?['name'] != 'Cash on delivery'
          ? "razorpay"
          : "cod",
      addressId: controller.checkOutAddress?.id.toString(),
      subtotal: controller.totalCheckOutValue.toString(),
      discount: controller.appliedCouponValue,
      tax: controller.taxvalue,
      shippingCharge: controller.shippingcost,
      total: controller.subtotal,
    );
   await controller.makePayment(data, (value) {
      if (value) {
        openDialog(context, controller,
            (ScreenUtils.getScreenSize(context), MediaQuery.orientationOf(context)));
      }
    });
      print("oooooooooo ${ controller.orderID }     ${response.paymentId}" );
    final paymentCompleteData = PaymentCompleteModel(
      orderId: controller.orderID, // Make sure this is set earlier
      transactionId: response.paymentId,
      status: 'success',
    );

    controller.paymentComplete(paymentCompleteData, (value) {
      if (value) {
        if(value==true){
          print("successful ho gya");
        }
      }});

  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("bnbnbnbnbnbnbnbn ${response.message}");

    showSnackBar(
        snackPosition: SnackPosition.TOP,
        title: "Payment Failed",
        description: "Payment was not completed. Please try again.",
      );




  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    final controller = Provider.of<CartController>(context, listen: false);

    final paymentCompleteData = PaymentCompleteModel(
      orderId: controller.orderNumber,
      transactionId: response.walletName,
      status: 'external_wallet',
    );

    controller.paymentComplete(paymentCompleteData, (value) {
      showSnackBar(
        snackPosition: SnackPosition.TOP,
        title: "External Wallet",
        description: "You selected ${response.walletName}",
      );
    });
  }

  void startRazorPayCheckout(CartController controller) {
    print("qqqqqqqqqq amount ${controller.subtotal}");
    final amount = controller.subtotal;
    var options = {
      // 'key': 'rzp_test_29aiezLXka3rYI', // demo
      'key': 'rzp_live_6jOXQXTAPpkkID', // Replace with your Razorpay Key
      'amount': int.parse(amount) * 100, // in paise
      'name': 'Utkrash Store',
      'description': 'Payment for your order',
      'prefill': {
        'contact': '9999999999',
        'email': 'test@example.com',
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Razorpay open error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = ScreenUtils.getScreenSize(context);
    final orientation = MediaQuery.orientationOf(context);
    final layoutInfo = (screenSize, orientation);

    if (ScreenUtils.isBigDevice(screenSize)) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      });
    }

    var walletProvider = Provider.of<WalletsController>(context, listen: false);

    return Consumer<CartController>(
      builder: (context, controller, child) => Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                controller.selectedPaymentMethod = null;
                for (int i = 0; i < controller.paymentMethod.length; i++) {
                  controller.paymentMethod[i]["isSelected"] = false;
                }
                Get.back();
              },
              child: const Icon(Icons.arrow_back)),
          title: Text("Payment Method",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w500)),
          centerTitle: false,
        ),
        bottomNavigationBar: SafeArea(
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (controller.loadingPayment)
                  Text("Please Wait....", style: Theme.of(context).textTheme.labelSmall),
                Padding(
                  padding: layoutInfo.$2 == Orientation.landscape
                      ? const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10)
                      : const EdgeInsets.only(left: 10.0, right: 10, top: 5, bottom: 10),
                  child: AppButton(
                    title: "Confirm Payment",
                    onTap: () {

                      print("qwqwqwqwqwqwqwqwqw ${controller.selectedPaymentMethod?['name']}");
                      final method = controller.selectedPaymentMethod?['name']?.toLowerCase();

                      if (method != null) {
                        final isRazorpay = method.contains("pay now");
                        final isCOD = method.contains("cash on delivery");

                        final data = PaymentModel(
                            paymentType:
                            controller.selectedPaymentMethod?['name'] != 'Cash on delivery'
                                ? "razorpay"
                                : "cod",
                          addressId: controller.checkOutAddress?.id.toString(),
                          subtotal: controller.totalCheckOutValue.toString(),
                          discount: controller.appliedCouponValue,
                          tax: controller.taxvalue,
                          shippingCharge: controller.shippingcost,
                          total: controller.subtotal,
                        );

                        if (isRazorpay) {
                          startRazorPayCheckout(controller);
                        } else if (isCOD) {
                          controller.makePayment(data, (value) {
                            if (value) {
                              openDialog(context, controller, layoutInfo);
                            }
                          });
                        } else {
                          showSnackBar(
                            snackPosition: SnackPosition.TOP,
                            title: "Warning",
                            description: "Unknown payment method selected.",
                          );
                        }
                      } else {
                        showSnackBar(
                          snackPosition: SnackPosition.TOP,
                          title: "Warning",
                          description: "Please choose a payment method.",
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: layoutInfo.$2 == Orientation.landscape
                ? const EdgeInsets.symmetric(horizontal: 40.0)
                : const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  "Select the payment method you want to use.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: AppColors.divideColor),
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.paymentMethod.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: ListTile(
                          leading: Container(
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Image.asset(
                                controller.paymentMethod[index]["image"],
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          title: Text(
                            controller.paymentMethod[index]["name"],
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          trailing: GestureDetector(
                            onTap: () {
                              controller.setIndex(index);
                              if (controller.paymentMethod[index]["type"] != 0) {
                                for (int i = 0; i < controller.paymentMethod.length; i++) {
                                  controller.paymentMethod[i]["isSelected"] = (i == index);
                                }
                                controller.updatePaymentMethodValue(controller.paymentMethod[index]);
                              } else {
                                showSnackBar(
                                  snackPosition: SnackPosition.TOP,
                                  title: "Warning",
                                  description:
                                  "${controller.paymentMethod[index]["name"]} is not active",
                                );
                              }
                            },
                            child: Icon(
                              controller.paymentMethod[index]["isSelected"] == false
                                  ? Icons.circle_outlined
                                  : Icons.circle,
                              color: AppColors.primaryColor,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  openDialog(context, CartController controller, layoutInfo) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              Image.asset("assets/images/order_sucess.png", height: 150),
              const SizedBox(height: 10),
              Text("Order Confirmed!",
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text("Your order has been successfully placed."),
              Text("Your order number is ${controller.orderNumber}"),
              const SizedBox(height: 30),
              AppButton(
                title: "Continue Shopping",
                onTap: () {
                  controller.selectedPaymentMethod = null;
                  Get.offAll(const BottomBarScreen(index: 0, type: 1));
                },
              ),
              const SizedBox(height: 15),
            ],
          ),
        );
      },
    );
  }
}

class PaymentModel {
  String? paymentType;//cod
  String? addressId;//6
  String? subtotal;//789
  String? discount;
  String? tax;
  String? shippingCharge;
  String? total;

  PaymentModel({
    this.paymentType,
    this.addressId,
    this.subtotal,
    this.discount,
    this.tax,
    this.shippingCharge,
    this.total,
  });
}


class PaymentCompleteModel {
  String? orderId;
  String? transactionId;
  String? status;


  PaymentCompleteModel({
    this.orderId,
    this.transactionId,
    this.status,

  });
}

