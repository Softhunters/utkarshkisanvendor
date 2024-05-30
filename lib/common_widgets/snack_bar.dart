import 'package:e_commerce/common_widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


//TODO: Bottom SnackBar
showSnackBar({
  String title = "",
  String description = "",
  int durationSec = 2,
  required SnackPosition snackPosition,
}) {

  Get.showSnackbar(
    GetSnackBar(
      title: title,
      message: description,
      duration: Duration(seconds: durationSec),
      snackPosition: snackPosition,
      backgroundColor: AppColors.primaryColor,
      borderRadius: 20, // Adjust border radius as needed
      margin: const EdgeInsets.all(8), // Adjust margin as needed
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), // Adjust padding as needed
      borderWidth: 2, // Border width
      borderColor: Colors.black, // Border color
      barBlur: 10, // Blur effect
      forwardAnimationCurve: Curves.easeOutCirc, // Animation curve for forward animation
      reverseAnimationCurve: Curves.easeInCirc, // Animation curve for reverse animation
      icon: const Icon(Icons.info), // Icon widget
      shouldIconPulse: true, // Whether the icon should pulse
      isDismissible: true, // Whether the snackbar is dismissible
      showProgressIndicator: false, // Whether to show a progress indicator
      onTap: (bar) {}, // Callback when the snackbar is tapped
      maxWidth: 400, // Maximum width of the snackbar
    ),
  );

}