import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:raghadcell/Core/Constants/app_colors.dart';
import 'package:sizer/sizer.dart';

class LoadingWidget extends StatelessWidget {
 final Color? color;
  const  LoadingWidget({this.color = AppColors.primaryColor, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 12.h,
        width: 24.w,
        child:  LoadingIndicator(
            indicatorType: Indicator.ballRotateChase,
            colors: [color!],
            strokeWidth: 4,
            backgroundColor: Colors.transparent,
            pathBackgroundColor: Colors.transparent),
      ),
    );
  }
}
