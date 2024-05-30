

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/common_widgets/urls.dart';
import 'package:e_commerce/widgets/cache_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/app_colors.dart';
import '../../Home/controller/home_controller.dart';
import '../../Search/search_screen.dart';


class AllOfferScreen extends StatelessWidget {
  const AllOfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    return Consumer<HomeController>(
      builder: (context, controller, child) =>Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                // controller.setFavIndex(null);
                // controller.filterCateProduct(null);
                Get.back();
              },
              child: const Icon(Icons.arrow_back)),
          title: Text( "Offer",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w500)),
          centerTitle: false,
          actions:  [
            GestureDetector(
                onTap: () {
                  Get.to(const SearchScreen());
                },
                child: Icon(Icons.search)),
            SizedBox(
              width: 15,
            )
          ],
          elevation: 0,
          surfaceTintColor: AppColors.white,
        ),
        body:
        SafeArea(child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView.builder(
            itemCount: controller.sliders.length,
            itemBuilder: (context, index) {
              var data = controller.sliders[index];
            return  Padding(
              padding: const EdgeInsets.only(bottom:  8.0),
              child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: MyCacheNetworkImages(imageUrl: "$sliderURL$data", radius: 20, fit: BoxFit.contain,height: 120, width: width,)),
            );


            //   CachedNetworkImage(
            //   imageUrl: "",
            //   imageBuilder: (context, imageProvider) => Container(
            //     margin: const EdgeInsets.symmetric(horizontal: 2),
            //     decoration: BoxDecoration(
            //       //  color: Colors.grey.shade100,
            //         border: Border.all(),
            //         image: DecorationImage(
            //           image: imageProvider,
            //           fit: BoxFit.cover,
            //           // colorFilter: const ColorFilter.mode(Colors.red, BlendMode.colorBurn),
            //         ),
            //         borderRadius: BorderRadius.circular(20)),
            //   ),
            //   placeholder: (context, url) =>
            //   const Center(child: CupertinoActivityIndicator()),
            //   errorWidget: (context, url, error) =>
            //   const Center(child: Icon(Icons.image, size: 50)),
            // );
          },),
        )
          ,),
      ),
    );
  }
}
