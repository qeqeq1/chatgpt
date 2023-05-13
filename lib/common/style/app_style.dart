import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppStyle {
  static ThemeData defaultThemeData = ThemeData(
    appBarTheme: AppBarTheme(
        centerTitle: true,
        toolbarHeight: 40,
        backgroundColor: const Color.fromRGBO(68, 70, 84, 1),
        titleTextStyle: TextStyle(fontSize: 30.sp, color: Colors.white),
        actionsIconTheme: IconThemeData(size: 40.sp, color: Colors.white)),
  );
}
