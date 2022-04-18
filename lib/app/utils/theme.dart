import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:stock_market_app/app/utils/constants/color_constant.dart';


ThemeData lightThemeData() {
  return ThemeData.light().copyWith(
    primaryColor: primaryCl,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      caption: TextStyle(color: primaryCl,fontSize: 28.sp,fontWeight: FontWeight.w500),

      subtitle1: TextStyle(color: primaryCl,fontSize: 9.sp,fontWeight: FontWeight.w300),
      subtitle2: TextStyle(color: primaryCl,fontSize: 11.sp,fontWeight: FontWeight.w300),
      bodyText1: TextStyle(color: primaryCl,fontSize: 13.sp,fontWeight: FontWeight.w300),
      bodyText2: TextStyle(color: primaryCl,fontSize: 15.sp,fontWeight: FontWeight.w300),
      overline:  TextStyle(color: primaryCl,fontSize: 20.sp,fontWeight: FontWeight.w300),

      headline1: TextStyle(color: primaryCl,fontSize: 18.sp,fontWeight: FontWeight.w500),
      headline2: TextStyle(color: primaryCl,fontSize: 16.sp,fontWeight: FontWeight.w500),
      headline3: TextStyle(color: primaryCl,fontSize: 14.sp,fontWeight: FontWeight.w500),
      headline4:TextStyle(color: primaryCl,fontSize: 12.sp,fontWeight: FontWeight.w500),
      headline5:TextStyle(color: primaryCl,fontSize: 10.sp,fontWeight: FontWeight.w500),
      headline6:TextStyle(color: primaryCl,fontSize: 8.sp,fontWeight: FontWeight.w500),

      button: TextStyle(color: primaryCl,fontSize: 14.sp,fontWeight: FontWeight.w500),
    ),
    colorScheme: ColorScheme.light(
      primary: primaryCl,
      secondary: logoDark,
      error: secondaryCl,
    ),
  );
}

ThemeData darkThemeData() {
  return ThemeData.dark().copyWith(
    primaryColor: primaryCl,
    scaffoldBackgroundColor: primaryCl,
    textTheme: TextTheme(
      caption: TextStyle(color: whiteCl,fontSize: 28.sp,fontWeight: FontWeight.w500),

      subtitle1: TextStyle(color: whiteCl,fontSize: 9.sp,fontWeight: FontWeight.w300),
      subtitle2: TextStyle(color: whiteCl,fontSize: 11.sp,fontWeight: FontWeight.w300),
      bodyText1: TextStyle(color: whiteCl,fontSize: 13.sp,fontWeight: FontWeight.w300),
      bodyText2: TextStyle(color: whiteCl,fontSize: 15.sp,fontWeight: FontWeight.w300),
      overline:  TextStyle(color: whiteCl,fontSize: 20.sp,fontWeight: FontWeight.w300),

      headline1: TextStyle(color: whiteCl,fontSize: 18.sp,fontWeight: FontWeight.w500),
      headline2: TextStyle(color: whiteCl,fontSize: 16.sp,fontWeight: FontWeight.w500),
      headline3: TextStyle(color: whiteCl,fontSize: 14.sp,fontWeight: FontWeight.w500),
      headline4:TextStyle(color: whiteCl,fontSize: 12.sp,fontWeight: FontWeight.w500),
      headline5:TextStyle(color: whiteCl,fontSize: 10.sp,fontWeight: FontWeight.w500),
      headline6:TextStyle(color: whiteCl,fontSize: 8.sp,fontWeight: FontWeight.w500),

      button: TextStyle(color: whiteCl,fontSize: 14.sp,fontWeight: FontWeight.w500),
    ),
    colorScheme: ColorScheme.dark(
      primary: primaryCl,
      secondary: secondaryCl,
      error: red,
    ),
  );
}


//final appBarTheme = AppBarTheme(centerTitle: false, elevation: 0);
