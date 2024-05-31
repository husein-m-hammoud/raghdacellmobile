import 'package:flutter/material.dart';
import 'package:raghadcell/Core/Constants/app_colors.dart';
import 'package:sizer/sizer.dart';

class IconTextInBorder extends StatelessWidget {
  final String text;
  final String? icon;
  const IconTextInBorder({ this.icon, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.h,horizontal: 2.w),
      padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 2.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.w),
          border: Border.all(
            color: AppColors.primaryColor,
          )),
      child: Row(
        children: [
          icon == null ? const Icon(Icons.location_on,color: AppColors.logoRed,):
          Container(
            height: 6.h,
            width: 6.w,
            decoration:
                BoxDecoration(image: DecorationImage(image: AssetImage(icon!))),
          ),
          SizedBox(width: 2.w,),
          Expanded(
              child: Text(
            text,
            style: TextStyle(fontSize: 12.sp, color: AppColors.blackColor),
          ))
        ],
      ),
    );
  }
}
