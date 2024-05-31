import 'package:flutter/material.dart';
import 'package:raghadcell/Core/Constants/app_colors.dart';
import 'package:sizer/sizer.dart';

class EmptyWidget extends StatelessWidget {
  final String title;
  const EmptyWidget({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      alignment: Alignment.center,
      decoration:
          BoxDecoration(color:AppColors.borderColor,borderRadius: BorderRadius.circular(5.w), boxShadow: [
        BoxShadow(
            blurRadius: 1,
            offset: const Offset(1, 2),
            color: AppColors.blackColor.withOpacity(0.1))
      ]),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor),
      ),
    );
  }
}
