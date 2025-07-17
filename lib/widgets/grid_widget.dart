import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import '../common_widgets/app_colors.dart';
import '../constant/cons.dart';
import 'cache_network_image.dart';

class AppGridWidget extends StatelessWidget {

  final String imageUrl;
  final String productTitle;
  final String soldItem;
  final String? regularPricw;
  final String? salePrice;
  final double height;
  final double width;
  final double tutorRating;
  final IconData? positionIcon;
  final VoidCallback onTap;
  final VoidCallback wishListOnTap;
  const AppGridWidget({super.key, required this.imageUrl, required this.productTitle, required this.height, required this.width, this.positionIcon, required this.tutorRating, required this.soldItem, required this.onTap, this.regularPricw, this.salePrice, required this.wishListOnTap});

  @override
  Widget build(BuildContext context) {
    final screenSize = ScreenUtils.getScreenSize(context);
    final orientation = MediaQuery.orientationOf(context);
    final layoutInfo = (screenSize, orientation);
    var isBigDevice = ScreenUtils.isBigDevice(screenSize);
    if (isBigDevice) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      });
    }
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 1,
        child: Container(

          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
          color: AppColors.textFieldColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  MyCacheNetworkImages(
                    imageUrl:imageUrl,
                    height:  switch (layoutInfo) {
                      (ScreenSize.large || ScreenSize.extraLarge, _)=> height*.25,(_, Orientation.landscape) => height*.86,_=>height*.14 },
                    width: width,
                    radius: 20,
                    fit: BoxFit.cover,
                    // color: AppColors.primaryColor,
                  ),
                  if(positionIcon != null)
                    Positioned(
                        top: 5,
                        right: 5,
                        child: GestureDetector(
                            onTap: wishListOnTap,
                            child: Icon(positionIcon)))
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.only(left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(productTitle,maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              regularPricw ??"",
                              maxLines: 1,

                              style: Theme.of(context).textTheme.labelSmall?.copyWith( decoration: TextDecoration.lineThrough,color: AppColors.redColor),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              salePrice ??"",
                              maxLines: 1,
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Icon(Icons.star,size: 12, color: AppColors.ratingBGColor,),
                          Text(tutorRating.toString(),style: Theme.of(context).textTheme.labelSmall,),
                          const VerticalDivider(
                            color: AppColors.divideColor,
                            thickness: 2,
                          ),

                          if(soldItem != "")
                          Container(
                          decoration: BoxDecoration(
                            color: AppColors.divideColor,
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 2),
                            child: Text("${soldItem} Sold",style: Theme.of(context).textTheme.labelSmall,),
                          ),)
                        ],
                      ),
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
