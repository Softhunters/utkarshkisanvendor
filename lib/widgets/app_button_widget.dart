import 'package:flutter/material.dart';

import '../common_widgets/app_colors.dart';

class AppButton extends StatelessWidget {
  final String title;
  final TextStyle? style;
  final VoidCallback onTap;
  final double? width;
  final double? height;
  final double? radius;
  final EdgeInsetsGeometry? padding;
  final Color? textColor;
  final Color? bgColor;

  const AppButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.style,
    this.width,
    this.height,
    this.padding,
    this.textColor,
    this.bgColor, this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.sizeOf(context).width,
      height: height ?? 50,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            alignment: Alignment.center,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular( radius ?? 30))
        ),
        child: Text(title,style:  style ?? const TextStyle(fontWeight: FontWeight.w500, fontSize: 16,color: AppColors.white),
      ),
      ),
    );
  }
}
