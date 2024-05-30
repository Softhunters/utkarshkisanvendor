import 'package:e_commerce/widgets/cache_network_image.dart';
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
                  Get.to(const SearchScreen());
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyCacheNetworkImages(
                        imageUrl:
                            "$adminLogoURL${controller.contactData?.mobileLogo ?? " "}",
                        radius: 10,
                        fit: BoxFit.cover,
                        width: width * .15,
                        height: width * .16,
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Text(
                        "${controller.contactData?.siteName}",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: AppColors.primaryBlack),
                      ),

                      // SizedBox(height: 15,),
                    ],
                  ),

                  Image.asset( "assets/images/contact.jpeg", fit: BoxFit.cover,
                    width: width *.88,
                    height: width * .32,),

                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          final Uri launchUri = Uri(
                            scheme: 'tel',
                            path: controller.contactData?.phone,
                          );
                          controller.makePhoneCall(launchUri);
                        },
                        child: Card(
                          child: Container(
                            width: 110,
                            height: 60,
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  const Icon(Icons.phone,color: AppColors.green,),
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
                      ),
                      GestureDetector(
                        onTap: () {
                          final Uri launchUri = Uri(
                              scheme: 'mailto',
                              path: controller.contactData?.phone,
                              query: 'subject= &body=');
                          controller.makePhoneCall(launchUri);
                        },
                        child: Card(
                          child: Container(
                            width: 110,
                            height: 60,
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  const Icon(Icons.mail,color: AppColors.blue,),
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
                      ),
                      GestureDetector(
                        onTap: () {
                          final Uri launchUri = Uri(
                            // scheme: 'mailto',
                            path: controller.contactData?.map,
                            // query: 'subject= &body='
                          );
                          controller.makePhoneCall(launchUri);

                          // controller.launchInstagramURL(controller.contactData?.map ??"");
                        },
                        child: Card(
                          child: Container(
                            width: 110,
                            height: 60,
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  const Icon(Icons.map),
                                  Text(
                                    "Direction",
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
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
                  Text(
                    "Address",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    width: 220,
                    // height: 60,
                    // decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${controller.contactData?.address}  \n\n${controller.contactData?.email}\n${controller.contactData?.phone}, \n${controller.contactData?.phone2} ",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 25,
                  ),
                  const Spacer(),
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
                                "assets/images/fb.webp",
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
                                "assets/images/insta.png",
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
                                "assets/images/twitter.webp",
                                width: 45,
                                height: 45,
                              )),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.makePhoneCall(Uri.parse(
                                controller.contactData?.pinterest ?? ""));
                          },
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: Image.asset(
                                "assets/images/pint.png",
                                width: 32,
                                height: 32,
                              )),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.makePhoneCall(
                                Uri.parse(controller.contactData?.youtube ?? ""));
                          },
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: Image.asset(
                                "assets/images/youtube.png",
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
