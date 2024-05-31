import 'package:flutter/material.dart';
import 'package:raghadcell/Core/Constants/app_colors.dart';
import 'package:sizer/sizer.dart';

class TilteWidget extends StatelessWidget {
  final String tilte;
  const TilteWidget({required this.tilte, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.h,horizontal: 1.w),
      height: 6.h,
      child: IntrinsicHeight(
        child: Row(
          children: [
            const VerticalDivider(
              thickness: 4,
              color: AppColors.primaryColor,
            ),
            Text(
              tilte,
              style: TextStyle(
                  color: AppColors.blackColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
