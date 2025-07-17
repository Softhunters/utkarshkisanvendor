import 'package:utkrashvendor/common_widgets/app_colors.dart';
import 'package:utkrashvendor/widgets/cache_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          surfaceTintColor:  AppColors.white,
        leading: GestureDetector(

          onTap: () {
            Get.back();
          },
            child: Icon(Icons.arrow_back)),

        title: Text("Notification",style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500)),
      centerTitle: false,
      actions: [
        Container(
          decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(30)),
            child: Icon(Icons.more_horiz)),
        SizedBox(width: 15,)
     ]
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) =>  Padding(
            padding: const EdgeInsets.only(left: 8.0,bottom: 10,right: 8),
            child: ListTile(
              tileColor: AppColors.textFieldColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.primaryColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: const MyCacheNetworkImages(
                  imageUrl: "",
                  radius: 10,
                  fit: BoxFit.cover,
                  width: 50,
                  height: 50,
                ),
              ),
            ),
            title: Text(
              "Notification Title",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            subtitle: Text(
              "Notification Demo subtitle ",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: AppColors.divideColor),
            ),
                    ),
          ),),
      ),
    );
  }
}
