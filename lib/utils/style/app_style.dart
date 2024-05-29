import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:search_delegete_example/utils/app_images/app_images.dart';

class AppStyle{
  static TextStyle poppinsSemiBold = TextStyle(
    color: Colors.red,
    fontWeight: FontWeight.w600,
    fontSize: 35.sp,
    fontFamily: AppImages.fontPoppins,
  );

  static TextStyle poppinsRegular = TextStyle(
    color: Colors.black,
    fontFamily: AppImages.fontPoppins,
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle poppinsBold = TextStyle(
    color: Colors.black,
    fontFamily: AppImages.fontPoppins,
    fontSize: 20.sp,
    fontWeight: FontWeight.w800,
  );
}