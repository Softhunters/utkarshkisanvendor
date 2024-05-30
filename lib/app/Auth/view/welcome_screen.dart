import 'package:e_commerce/app/Auth/view/register_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../common_widgets/app_colors.dart';
import '../../../widgets/app_button_widget.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      // appBar: AppBar(
      //
      // ),

      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: ListView(
          children: [
            SizedBox(
              height: height * .06,
            ),
            Image.asset(
              "assets/images/welcome.png",
              height: height * .35,
              width: width,
            ),
            SizedBox(
              height: height * .1,
            ),
            Text(
              "Let’s You in",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontSize: 40, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: height * .03,
            ),
            // Container(
            //   width: width,
            //   height: 55,
            //   decoration: BoxDecoration(
            //       border: Border.all(color: AppColors.primaryColor),
            //       borderRadius: BorderRadius.circular(15)),
            //   child: Center(child: Text(data),),
            // ),

            AppButton(
              height: 55,
                title: "Sign In ",
                textColor: AppColors.white,
                onTap: () {

                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                },
              ),
            SizedBox(
              height: height * .03,
            ),
            AppButton(
              height: 55,
                title: "Sign Up",
                textColor: AppColors.white,
                onTap: () {

                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen(),));
                },
              ),
            SizedBox(
              height: height * .04,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Expanded(
            //         child: const Divider(
            //       color: AppColors.divideColor,
            //       endIndent: 5,
            //       indent: 5,
            //     )),
            //     Text(
            //       "OR",
            //       style: Theme.of(context).textTheme.bodyLarge,
            //     ),
            //     Expanded(
            //         child: const Divider(
            //       color: AppColors.divideColor,
            //       endIndent: 5,
            //       indent: 5,
            //     )),
            //   ],
            // ),
            // SizedBox(
            //   height: height * .04,
            // ),
            // AppButton(
            //   title: "Sign in with Password",
            //   textColor: AppColors.white,
            //   onTap: () {
            //
            //     Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
            //   },
            // ),
            // Spacer(),
            // RichText(
            //     text: TextSpan(
            //         text: "Don’t have an account? ",
            //         style: Theme.of(context)
            //             .textTheme
            //             .labelSmall
            //             ?.copyWith(color: AppColors.divideColor),
            //         children: [
            //       TextSpan(
            //         recognizer: TapGestureRecognizer()..onTap = () {
            //           Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupScreen(),));
            //         },
            //         text: " Sign Up",
            //         style: Theme.of(context)
            //             .textTheme
            //             .labelSmall
            //             ?.copyWith(color: AppColors.primaryColor, fontSize: 14),
            //       )
            //     ]))
          ],
        ),
      )),
    );
  }
}
