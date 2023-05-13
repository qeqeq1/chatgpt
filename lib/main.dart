import 'package:chatgpt/common/style/app_style.dart';
import 'package:chatgpt/pages/Home/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  runApp(ScreenUtilInit(
      designSize: const Size(540, 960),
      builder: (context, child) {
        return GetMaterialApp(
          home: const HomePage(),
          theme: AppStyle.defaultThemeData,
          debugShowCheckedModeBanner: false,
        );
      }));
}
