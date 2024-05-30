import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../common_widgets/app_colors.dart';
import '../../widgets/cache_network_image.dart';
import '../Search/controller/search_controller.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SearchScreenController read = context.read<SearchScreenController>();
    SearchScreenController watch = context.watch<SearchScreenController>();

    return Scaffold(
      appBar: appBar(context),
      body: SafeArea(
          child: Column(
        children: [
          rating(watch, read),
          allNotification()
        ],
      )),
    );
  }

  PreferredSizeWidget appBar(context){
    return AppBar(
        elevation: 0,
        surfaceTintColor: AppColors.white,
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back)),
        title: Text("4.2 (464 reviews)",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w500)),
        centerTitle: false,
        actions: [
          Container(
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(30)),
              child: Icon(Icons.more_horiz)),
          SizedBox(
            width: 15,
          )
        ]);
  }

  Widget rating(SearchScreenController watch, SearchScreenController read){
    return Container(
      height: 50,
      child: ListView.builder(
        itemCount: watch.rate.length + 1,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          // var data = watch.rate[index];
          bool isSelected = watch.ratingIndex == index;
          return index == 0
              ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                read.setRatingIndex(0);
              },
              child: Container(
                height: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border:
                    Border.all(color: AppColors.primaryColor),
                    color: isSelected == true
                        ? AppColors.primaryColor
                        : AppColors.white),
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Center(
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: isSelected == true
                              ? AppColors.white
                              : AppColors.primaryColor,
                          size: 15,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "All",
                          style: isSelected == true
                              ? Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: AppColors.white)
                              : Theme.of(context)
                              .textTheme
                              .bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
              : Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                read.setRatingIndex(index);
              },
              child: Container(
                height: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border:
                    Border.all(color: AppColors.primaryColor),
                    color: isSelected == true
                        ? AppColors.primaryColor
                        : AppColors.white),
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Center(
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: isSelected == true
                              ? AppColors.white
                              : AppColors.primaryColor,
                          size: 15,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          watch.rate[index - 1],
                          style: isSelected == true
                              ? Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: AppColors.white)
                              : Theme.of(context)
                              .textTheme
                              .bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget allNotification(){
    return  Expanded(
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 10, right: 8),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                color: AppColors.textFieldColor),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ListTile(
                    // tileColor: AppColors.textFieldColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.primaryColor,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(1.0),
                        child: MyCacheNetworkImages(
                          imageUrl: "",
                          radius: 10,
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ),
                    title: Text(
                      "Reviewer Name",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    trailing: Container(
                      height: 20,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: AppColors.primaryColor),
                          color: AppColors.white),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Center(
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: AppColors.primaryColor,
                                size: 15,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "5",
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Icon(Icons.favorite_border),
                        SizedBox(width: 10,),
                        Text(
                          "568",
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        SizedBox(width: 15,),
                        Text(
                          "5 days ago",
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
