import 'package:utkrashvendor/widgets/cache_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common_widgets/app_colors.dart';
import '../../../common_widgets/urls.dart';
import '../../Search/search_screen.dart';
import '../Controller/profile_controller.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  Future<void> launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    return Consumer<ProfileController>(
      builder: (context, controller, child) => Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                // controller.setFavIndex(null);
                // controller.filterCateProduct(null);
                Get.back();
              },
              child: const Icon(Icons.arrow_back)),
          title: Text("Contact Us",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w500)),
          centerTitle: false,
          actions: [
            GestureDetector(
                onTap: () {
                  Get.to(()=>const SearchScreen());
                },
                child: const Icon(Icons.search)),
            const SizedBox(
              width: 15,
            )
          ],
          elevation: 0,
          surfaceTintColor: AppColors.white,
        ),
        body: Visibility(
          visible: !controller.contactLoading,
          replacement: const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          child: Visibility(
            visible: controller.contactData != null,
            replacement: Center(
                child: Text(
              "Contact details are not fetch",
              style: Theme.of(context).textTheme.bodyLarge,
            )),
            child: SafeArea(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Image.asset("assets/images/app_logo_small.png",width: 100,height: 100,),
                      )

                    ],
                  ),

                 /* Image.asset( "assets/images/contact.jpeg", fit: BoxFit.cover,
                    width: width *.88,
                    height: width * .32,),*/

                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(child: GestureDetector(
                        onTap: () {
                          final Uri launchUri = Uri(
                            scheme: 'tel',
                            path: controller.contactData?.phone,
                          );
                          controller.makePhoneCall(launchUri);
                        },
                        child: Card(
                          child: Container(
                            // width: 110,
                            height: 60,
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.phone,color: AppColors.green,),
                                  SizedBox(width: 12,),
                                  Text(
                                    "Call Us",
                                    style:
                                    Theme.of(context).textTheme.bodySmall,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )),
                      Expanded(child: GestureDetector(
                        onTap: () {
                          final Uri launchUri = Uri(
                              scheme: 'mailto',
                              path: controller.contactData?.email,
                              query: 'subject= &body=');
                          controller.makePhoneCall(launchUri);
                        },
                        child: Card(
                          child: Container(
                            // width: 110,
                            height: 60,
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.mail,color: AppColors.blue,),
                                  SizedBox(width: 12,),
                                  Text(
                                    "Email Us",
                                    style:
                                    Theme.of(context).textTheme.bodySmall,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )),

                    ],
                  ),
                  /*  Card(
                    child: Container(
                      width: 200,
                      // height: 80,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.phone),
                            Column(
                              children: [
                                Text(
                                  "${controller.contactData?.phone}",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                SizedBox(height: 15,),
                                Text(
                                  "${controller.contactData?.phone2}",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Card(
                      child: Container(
                        width: 215,
                        // height: 80,
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.mail),
                              SizedBox(width: 15,),
                              Column(
                                children: [
                                  Text(
                                    "${controller.contactData?.email}",
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                  SizedBox(height: 15,),

                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: Container(
                      width: 200,
                      // height: 80,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.map),
                            Column(
                              children: [
                                Text(
                                  "${controller.contactData?.phone}",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                SizedBox(height: 15,),
                                Text(
                                  "${controller.contactData?.phone2}",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),*/
                  const SizedBox(
                    height: 15,
                  ),

                  SizedBox(
                    width: width,
                    // height: 60,
                    // decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.phone),
                              SizedBox(width: 12,),
                              Text("${controller.contactData?.phone}",style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.primaryBlack,fontSize: 16),)
                            ],
                          ),
                          SizedBox(height: 12,),
                          Row(
                            children: [
                              Icon(Icons.email),
                              SizedBox(width: 12,),
                              Text("${controller.contactData?.email}",style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.primaryBlack,fontSize: 16),)
                            ],
                          ),
                          SizedBox(height: 12,),
                          Row(
                            children: [
                              Icon(Icons.location_on),
                              SizedBox(width: 12,),
                              Expanded(child: Text("${controller.contactData?.address}",style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.primaryBlack,fontSize: 16),)
                              )
                            ],
                          ),
                          SizedBox(height: 12,),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 25,
                  ),
                  const Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      GestureDetector(
                        onTap:(){
                          launchURL("https://utkarshkisan.com/privacy-policy");
                        },child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Privacy Policies",style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.primaryDarkColor,fontSize: 16),),
                        ],
                      ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      GestureDetector(
                        onTap: (){
                          launchURL("https://utkarshkisan.com/return-refund-policy");
                        },
                        child:             Text("Return & Refund Policy",style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.primaryDarkColor,fontSize: 16),),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      GestureDetector(
                        onTap: (){
                          launchURL("https://utkarshkisan.com/terms-conditions");
                        },
                        child:   Text("Terms & Conditions",style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.primaryDarkColor,fontSize: 16),),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      GestureDetector(
                        onTap: (){
                          launchURL("https://utkarshkisan.com/shipping-policy");
                        },
                        child:    Text("Shipping & Delivery Policy",style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.primaryDarkColor,fontSize: 16),),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      GestureDetector(
                        onTap: (){
                          launchURL("https://utkarshkisan.com/vendor-terms-conditions");
                        },
                        child:    Text("Vendor Terms & Conditions",style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.primaryDarkColor,fontSize: 16),),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.makePhoneCall(Uri.parse(
                                controller.contactData?.facebook ?? ""));
                          },
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: Image.asset(
                                "assets/images/fba.png",
                                width: 35,
                                height: 35,
                                fit: BoxFit.cover,
                              )),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.makePhoneCall(Uri.parse(
                                controller.contactData?.instagram ?? ""));
                          },
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: Image.asset(
                                "assets/images/instaa.png",
                                width: 32,
                                height: 32,
                              )),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.makePhoneCall(
                                Uri.parse(controller.contactData?.twiter ?? ""));
                          },
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: Image.asset(
                                "assets/images/xa.png",
                                width: 32,
                                height: 32,
                              )),
                        ),

                        const SizedBox(
                          width: 20,
                        ),
                        // GestureDetector(
                        //   onTap: () {
                        //     controller.makePhoneCall(Uri.parse(
                        //         controller.contactData?.pinterest ?? ""));
                        //   },
                        //   child: ClipRRect(
                        //       borderRadius: BorderRadius.circular(100.0),
                        //       child: Image.asset(
                        //         "assets/images/pinta.png",
                        //         width: 32,
                        //         height: 32,
                        //       )),
                        // ),
                        // const SizedBox(
                        //   width: 15,
                        // ),
                        GestureDetector(
                          onTap: () {
                            controller.makePhoneCall(
                                Uri.parse(controller.contactData?.youtube ?? ""));
                          },
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: Image.asset(
                                "assets/images/youtubea.png",
                                width: 30,
                                height: 30,
                              )),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }
}
