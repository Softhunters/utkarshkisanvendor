


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common_widgets/app_colors.dart';
import 'fields_border.dart';


class AppTextFormWidget extends StatelessWidget {
  final String hintText;
  final String? labelText;
  final Widget? sufixIcon;
  final VoidCallback? onTap;
  final VoidCallback? onEditing;
  final Widget? prifixIcon;
  final TextStyle hintStyle;
  final FocusNode? focusNode;

  final TextEditingController controller;
  final bool obscureText;

  final bool enable;

  final int maxLines;

  final int minLine;

  final int? maxLength;

  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onComplete;
  final TextInputType? keyBoardType;
  final double? width;
  final double? height;
  final List<TextInputFormatter>? inputFormatters;

  const AppTextFormWidget(
      {Key? key, required this.hintText, this.maxLength, this.sufixIcon, this.prifixIcon, required this.controller,
        this.obscureText = false, this.enable = true, this.labelText, this.maxLines = 5, this.minLine = 1, this.validator,
        this.keyBoardType, this.onChanged, required this.hintStyle, this.onTap, this.width, this.height, this.onEditing, this.focusNode, this.onComplete,
        this.inputFormatters
      })
      : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      minLines: minLine,
      maxLines: maxLines,
      maxLength: maxLength,
      enabled: enable,
      controller: controller,
      obscureText: obscureText,
      onEditingComplete: onEditing,
      onFieldSubmitted: onComplete,
      focusNode: focusNode,
      keyboardType: keyBoardType,
      inputFormatters: inputFormatters,
      // ✅ Add this line

      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        filled: true,
        fillColor: AppColors.textFieldColor,
        hintText: hintText,
        suffixIcon: sufixIcon,
        prefixIcon: prifixIcon,
        hintStyle: hintStyle,
        enabledBorder: AuthCommonTheme.enabledBorder,
        disabledBorder: AuthCommonTheme.enabledBorder,
        focusedBorder: AuthCommonTheme.focusedBorder,
        errorBorder: AuthCommonTheme.errorBorder,
        border: AuthCommonTheme.border,
      ),

      validator: validator,
      onChanged: onChanged,
    );
  }
}