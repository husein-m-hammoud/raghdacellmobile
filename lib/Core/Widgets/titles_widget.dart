import 'package:flutter/material.dart';
import 'package:raghadcell/Core/Constants/app_colors.dart';
import 'package:sizer/sizer.dart';

class TitlesWidget extends StatelessWidget {
  final String title1;
  final String title2;

  final String title3;

  final String title4;

  final String? title5;
  final String? title6;
  final String? title7;
  final String? title8;
  final String? title9;

  const TitlesWidget({
    super.key,
    required this.title1,
    required this.title2,
    required this.title3,
    required this.title4,
    this.title5,
    this.title6,
    this.title7,
    this.title8,
    this.title9,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
      margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
      decoration: BoxDecoration(
          color: AppColors.seconedaryColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(5.w), topLeft: Radius.circular(5.w))),
      child: Row(
        children: [
          Expanded(
              child: Text(
            title1,
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.whiteColor, fontSize: 11.sp),
          )),
          Expanded(
              child: Text(
            title2,
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.whiteColor, fontSize: 11.sp),
          )),
          Expanded(
              child: Text(
            title3,
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.whiteColor, fontSize: 11.sp),
          )),
          Expanded(
              child: Text(
            title4,
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.whiteColor, fontSize: 11.sp),
          )),
          title5 != null
              ? Expanded(
                  child: Text(
                  title5!,
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: AppColors.whiteColor, fontSize: 11.sp),
                ))
              : const SizedBox(),
          title6 != null
              ? Expanded(
                  child: Text(
                  title6!,
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: AppColors.whiteColor, fontSize: 11.sp),
                ))
              : const SizedBox(),
          title7 != null
              ? Expanded(
                  child: Text(
                  title7!,
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: AppColors.whiteColor, fontSize: 11.sp),
                ))
              : const SizedBox(),
          title8 != null
              ? Expanded(
                  child: Text(
                  title8!,
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: AppColors.whiteColor, fontSize: 11.sp),
                ))
              : const SizedBox(),
          title9 != null
              ? Expanded(
                  child: Text(
                  title9!,
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: AppColors.whiteColor, fontSize: 11.sp),
                ))
              : const SizedBox(),
        ],
      ),
    );
  }
}
