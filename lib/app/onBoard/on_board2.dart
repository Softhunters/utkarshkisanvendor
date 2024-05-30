import 'package:e_commerce/common_widgets/app_colors.dart';
import 'package:e_commerce/widgets/app_button_widget.dart';
import 'package:flutter/material.dart';

import '../Auth/view/welcome_screen.dart';

class Onboard2 extends StatefulWidget {
  const Onboard2({super.key});

  @override
  State<Onboard2> createState() => _Onboard2State();
}

class _Onboard2State extends State<Onboard2> {
  int screen = 1;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          screen == 1
              ? ListView(
                  children: [
                    Image.asset(
                      "assets/images/splash2.png",
                      height: height * .58,
                      width: width,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      height: height * .3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: height * .03,
                            ),
                            Text(
                              "We provide high quality products just for you",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: height * .02,
                            ),
                            Image.asset(
                              "assets/images/Rectangle 4.png",
                              height: 10,
                            ),
                            // SizedBox(
                            //   height: height * .02,
                            // ),
                            Spacer(),
                            AppButton(
                              title: "Next",
                              textColor: AppColors.white,
                              radius: 30,
                              onTap: () {
                                setState(() {
                                  screen = 2;
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
              : ListView(
                  children: [
                    Image.asset(
                      "assets/images/spalsh3.png",
                      // "assets/images/2_1.jpg",

                      height: height * .58,
                      width: width,
                      fit: BoxFit.fitWidth,
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: height * .02,
                            ),
                            Text(
                              "Your satisfaction is our number one priority",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: height * .025,
                            ),
                            Image.asset(
                              "assets/images/Rectangle 4.png",
                              height: 10,
                            ),
                            SizedBox(
                              height: height * .025,
                            ),
                            AppButton(
                              title: "Next",
                              textColor: AppColors.white,
                              radius: 30,
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WelcomeScreen(),
                                    ));
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
          if (screen == 1)
            Positioned(
                top: 20,
                right: 40,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WelcomeScreen(),
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Skip",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ))
        ],
      )),
    );
  }
}
