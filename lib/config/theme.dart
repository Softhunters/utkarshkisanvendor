import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../common_widgets/app_colors.dart';

class AppTheme {
  static final light = ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.black,
      shadowColor: Colors.black,
      canvasColor: Colors.black,
      backgroundColor: Colors.black,


      // highlightColor: Color(0xff2a319c),
      errorColor: const Color(0xfff71921),
      scaffoldBackgroundColor: const Color(0xFFFFFFFF),
      fontFamily: GoogleFonts.openSans().fontFamily,
      // colorScheme: ColorScheme.fromSwatch().copyWith(secondary: const Color(0xffffffff)),

      primarySwatch: const MaterialColor(
        0xFFFFFFFF,
        <int, Color>{
          50: Color(0xFFFFFFFF),
          100: Color(0xFFFFFFFF),
          200: Color(0xFFFFFFFF),
          300: Color(0xFFFFFFFF),
          400: Color(0xFFFFFFFF),
          500: Color(0xFFFFFFFF),
          600: Color(0xFFFFFFFF),
          700: Color(0xFFFFFFFF),
          800: Color(0xFFFFFFFF),
          900: Color(0xFFFFFFFF),
        },
      ),
      focusColor: Colors.grey,
      listTileTheme: ListTileThemeData(
        tileColor: MaterialStateColor.resolveWith((states) => Colors.white),
        textColor: MaterialStateColor.resolveWith((states) => Colors.black),
      ),

      checkboxTheme: CheckboxThemeData(


        overlayColor: MaterialStateColor.resolveWith((states) => AppColors.primaryBlack),
        checkColor: MaterialStateColor.resolveWith((states) => AppColors.white),
        fillColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.primaryBlack; // White fill color when checked
          }
          return Colors.white; // Transparent fill color when unchecked
        }),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: BorderSide(
            color: AppColors.primaryColor, // Border color
          ),
        ),
      ),



      radioTheme: RadioThemeData(
        fillColor: MaterialStateColor.resolveWith((states) => Colors.black),
        overlayColor: MaterialStateColor.resolveWith((states) => Colors.grey),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.white,

        surfaceTintColor: AppColors.white,
        // color: Color(0xE5ECEBEB),
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
            fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.w700),
        iconTheme: IconThemeData(color: AppColors.primaryColor),
        actionsIconTheme: IconThemeData(color: AppColors.primaryColor),
      ),
      dividerColor: const Color(0xFFBFBEBE),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: Colors.white,
        selectedIconTheme: IconThemeData(color: AppColors.primaryColor),
        unselectedIconTheme: IconThemeData(color: Colors.white),
        elevation: 8,

      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          // foregroundColor: Colors.red,
          backgroundColor: AppColors.primaryColor,

          textStyle: GoogleFonts.openSans(
              fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w500),
          // minimumSize: const Size(100, 45),
          // maximumSize:  Size(100, 45),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
        ),
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.primaryColor,
        actionTextColor: const Color(0xff2a319c),
        contentTextStyle: GoogleFonts.poppins(
            fontSize: 18, color: AppColors.white, fontWeight: FontWeight.w700),
      ),
      textTheme: TextTheme(
        headlineLarge: GoogleFonts.poppins(
          fontSize: 26,
        ),
        displayLarge: GoogleFonts.poppins(
          fontSize: 24,
          color: Colors.black,
        ),
        displayMedium: GoogleFonts.poppins(
          fontSize: 22,
          color: Colors.black,
        ),
        displaySmall: GoogleFonts.poppins(
          fontSize: 22,
          color: Colors.white,
        ),
        headlineMedium: GoogleFonts.poppins(
          fontSize: 20,
          color: Colors.black,
        ),
        headlineSmall: GoogleFonts.poppins(
          fontSize: 20,
          color: Colors.white,
        ),
        titleLarge: GoogleFonts.poppins(
          fontSize: 18,
          color: Colors.black,
        ),

        titleMedium: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
        titleSmall: GoogleFonts.poppins(
          fontSize: 16,
          color: Colors.white,
        ),
        bodyLarge: GoogleFonts.poppins(
          fontSize: 14,
          color: Colors.black,
        ),
        bodyMedium: GoogleFonts.poppins(
          fontSize: 14,
          color: Colors.white,
        ),
        bodySmall: GoogleFonts.poppins(
          fontSize: 12,
          color: Colors.black,
        ),
        labelLarge: GoogleFonts.poppins(fontSize: 12, color: Colors.white),
        labelMedium: GoogleFonts.poppins(fontSize: 12, color: Colors.white),
        labelSmall: GoogleFonts.poppins(fontSize: 10, color: Colors.black),
      ));

  ///  This is Dark theme for whole application .............
  ///
  static final dark = ThemeData.dark().copyWith(
      brightness: Brightness.dark,
      primaryColor: Colors.black,
      canvasColor: Colors.white,
      scaffoldBackgroundColor: Colors.black,
      highlightColor: Colors.green,
      focusColor: Colors.grey,
      // iconTheme: const IconThemeData(color: Colors.white),
      listTileTheme: ListTileThemeData(
        tileColor: MaterialStateColor.resolveWith((states) => Colors.black),
        textColor: MaterialStateColor.resolveWith((states) => Colors.white),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        selectedIconTheme: IconThemeData(color: Colors.blue),
        unselectedIconTheme: IconThemeData(color: Colors.black),
        elevation: 8,
      ),
      appBarTheme: const AppBarTheme(
          color: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
              fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.w700),
          iconTheme: IconThemeData(color: Colors.black),
          actionsIconTheme: IconThemeData(color: Colors.black)),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateColor.resolveWith((states) => Colors.blue),
        overlayColor: MaterialStateColor.resolveWith((states) => Colors.grey),
      ),
      checkboxTheme: CheckboxThemeData(
          // overlayColor: MaterialStateColor.resolveWith((states) =>Colors.red),
          checkColor: MaterialStateColor.resolveWith((states) => Colors.black),
          fillColor: MaterialStateColor.resolveWith((states) => Colors.blue),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          side: const BorderSide(color: Colors.green)),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          // foregroundColor: Colors.red,
          backgroundColor: AppColors.primaryColor,
          textStyle: GoogleFonts.openSans(
              fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w700),
          minimumSize: const Size(145, 40),
          maximumSize: const Size(200, 40),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
        ),
      ),
      textTheme: TextTheme(
        headlineLarge: GoogleFonts.poppins(
            fontSize: 26, color: Colors.white, fontWeight: FontWeight.w700),
        displayLarge: GoogleFonts.poppins(
            fontSize: 24, color: Colors.white, fontWeight: FontWeight.w700),
        displayMedium: GoogleFonts.poppins(
            fontSize: 22, color: Colors.white, fontWeight: FontWeight.w700),
        displaySmall: GoogleFonts.poppins(
            fontSize: 22, color: Colors.black, fontWeight: FontWeight.w700),
        headlineMedium: GoogleFonts.poppins(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700),
        headlineSmall: GoogleFonts.poppins(
            fontSize: 20, color: Colors.black, fontWeight: FontWeight.w700),
        titleLarge: GoogleFonts.poppins(
            fontSize: 18, color: Colors.white, fontWeight: FontWeight.w700),
        labelMedium: GoogleFonts.poppins(
            fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
        titleMedium: GoogleFonts.poppins(
            fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700),
        titleSmall: GoogleFonts.poppins(
            fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700),
        bodyLarge: GoogleFonts.poppins(
            fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400),
        bodyMedium: GoogleFonts.poppins(
            fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
        bodySmall:
            GoogleFonts.poppins(fontSize: 12, color: Colors.red.shade400),
        labelLarge: GoogleFonts.poppins(fontSize: 12, color: Colors.black),
        labelSmall: GoogleFonts.poppins(fontSize: 10, color: Colors.white),
      ));

//  Button Themes.....................
  static final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.red,
    backgroundColor: Colors.red,
    textStyle: GoogleFonts.poppins(
        fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w700),
    minimumSize: const Size(145, 40),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(5.0),
      ),
    ),
  );

}
