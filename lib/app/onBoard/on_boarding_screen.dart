import 'package:e_commerce/app/onBoard/on_board2.dart';
import 'package:e_commerce/config/theme.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common_widgets/app_colors.dart';
import '../../common_widgets/app_strings.dart';
import '../../config/shared_prif.dart';
import '../bottom_bar/bottom_bar_screen.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  int screen = 1;

  @override
  void initState() {

    bool isLogin =
        SharedStorage.localStorage?.getBool(AppStrings.isLogin) ?? false;
    Future.delayed(const Duration(seconds: 3), () {
      if (!isLogin) {
        setState(() {
          screen = 2;
        });
      } else {
        return Get.offAll(
          const BottomBarScreen(
            index: 0,type: 0,
          ),
        );
      }
    }).then((value) => Future.delayed(Duration(seconds: 3), () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Onboard2(),
              ));
        }));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: screen == 1
          ? Stack(
              children: [
                Container(
                  height: height,
                  width: width,
                  child: Center(
                      child: Image.asset(
                    "assets/images/splash_icon.png",
                    width: width * .3,
                    fit: BoxFit.cover,
                  )),
                ),
                const Positioned(
                    bottom: 100,
                    right: 0,
                    left: 0,
                    child: Center(
                      child: CircularProgressIndicator.adaptive(
                        backgroundColor: AppColors.primaryColor,
                      ),
                    ))
              ],
            )
          : Stack(
              children: [
                Container(
                  height: height,
                  width: width,
                  child: Image.asset("assets/images/splash1.png",
                      width: width, fit: BoxFit.cover),
                ),
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: height * .5,
                      decoration: BoxDecoration(
                          // color: Colors.transparent,
                          // image: DecorationImage(image: AssetImage("assets/images/splash1.png")),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                            AppColors.splashGradient1Color,
                            AppColors.splashGradient2Color,
                          ])),
                    )),
                Positioned(
                    bottom: 50,
                    right: 0,
                    left: 0,
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome to",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Text(
                            "E-commerce",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(fontSize: 36),
                          ),
                          Text(
                              "Lorem Ipsum has been the industry's standard dummy text",
                              style: Theme.of(context).textTheme.bodyMedium)
                        ],
                      ),
                    )))
              ],
            ),
    );
  }
}
