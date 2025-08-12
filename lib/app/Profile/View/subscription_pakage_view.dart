import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_table/flutter_html_table.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:utkrashvendor/app/Auth/view_model/auth_controller.dart';
import 'package:utkrashvendor/common_widgets/app_colors.dart';
import 'package:html/dom.dart' as dom;
import 'package:utkrashvendor/widgets/app_button_widget.dart';

import '../../../common_widgets/snack_bar.dart';
import '../../../common_widgets/urls.dart';
import '../../bottom_bar/bottom_bar_screen.dart';
import '../Controller/profile_controller.dart';

class SubscriptionPakageView extends StatefulWidget {
  const SubscriptionPakageView({super.key});

  @override
  State<SubscriptionPakageView> createState() => _SubscriptionPakageViewState();
}

class _SubscriptionPakageViewState extends State<SubscriptionPakageView> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    // _razorpay = Razorpay('rzp_test_29aiezLXka3rYI'); //demo key
     _razorpay = Razorpay('rzp_live_6jOXQXTAPpkkID');        // live key
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  }


  String? dateFormat(String date) {
    try {

      DateTime parsedDate = DateTime.parse(date);

      String formattedDate = DateFormat("dd MMM yyyy").format(parsedDate);

      print(formattedDate); // e.g. 11 Aug 2026
      return formattedDate;
    } catch (e) {
      print("Invalid date format: $e");
    }
  }


  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    final controller = Provider.of<ProfileController>(context, listen: false);
    final authcontroller = Provider.of<AuthController>(context, listen: false);


    print("yuyuyuyuyuyuyuyu ${response.paymentId}");

    final paymentCompleteData = PaymentCompleteModelForpackageSubscription(
      package_id: authcontroller.mypackage.result?.id.toString(),
      transactionId: response.paymentId,
    );

    controller.paymentCompleteForSubscriptionPlan(paymentCompleteData, (value) {
      if (value) {
        if (value == true) {
          print("successful ho gya");
        }
      }
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    showSnackBar(
      snackPosition: SnackPosition.TOP,
      title: "Payment Failed",
      description: "Payment was not completed. Please try again.",
    );

  }

  void startRazorPayCheckout(AuthController controller) {
    final amount = controller.mypackage.result?.price ?? '';
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
    return Consumer<AuthController>(
        builder: (context, authController, _) => Scaffold(
              appBar: AppBar(
                title: Text("My Package"),
                centerTitle: false,
              ),
              body: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    IntrinsicHeight(
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text(
                                authController.mypackage.result?.pname ?? "",
                                style: TextTheme.of(context)
                                    .bodyMedium
                                    ?.copyWith(
                                        color: AppColors.primaryBlack,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Price - ",
                                    style: TextTheme.of(context)
                                        .bodyMedium
                                        ?.copyWith(
                                            color: AppColors.blue,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "₹${authController.mypackage.result?.price ?? ""}/${authController.mypackage.result?.validity} days",
                                    style: TextTheme.of(context)
                                        .bodyMedium
                                        ?.copyWith(
                                            color: AppColors.blue,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Html(
                                data: authController
                                        .mypackage.result?.description ??
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
                                    backgroundColor: Colors.grey.shade100,
                                    border: Border.all(color: Colors.black12),
                                  ),
                                  "tr": Style(
                                    alignment: Alignment.topLeft,
                                  ),
                                  "th": Style(
                                    padding: HtmlPaddings.all(6),
                                    backgroundColor: Colors.grey.shade300,
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
                                      print("❌ Could not launch $url");
                                    }
                                  }
                                },
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              authController.mypackage.result?.status == "1"
                                  ? Text(
                                      "Your subscription is active until ${dateFormat(authController.mypackage.result?.upToDate??'')}",
                                      style: TextTheme.of(context)
                                          .titleMedium
                                          ?.copyWith(color: AppColors.blue,fontSize: 13),
                                    )
                                  : AppButton(
                                      title: "Buy Now",
                                      onTap: () {
                                        final authcontroller =
                                            Provider.of<AuthController>(context,
                                                listen: false);
                                        startRazorPayCheckout(authcontroller);
                                      })
                            ],
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    SafeArea(
                        child: AppButton(
                            title: "Go to dashboard",
                            onTap: () {
                              Get.offAll(
                                const BottomBarScreen(
                                  index: 0,
                                  type: 0,
                                ),
                              );
                            }))
                  ],
                ),
              ),
            ));
  }
}

class PaymentCompleteModelForpackageSubscription {
  String? package_id;
  String? transactionId;

  PaymentCompleteModelForpackageSubscription({
    this.package_id,
    this.transactionId,
  });
}
