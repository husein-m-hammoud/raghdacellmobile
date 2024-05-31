import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:raghadcell/Core/Constants/app_colors.dart';
import 'package:sizer/sizer.dart';

showLoadingDialog(BuildContext context) {
  AlertDialog alertDialog = AlertDialog(

    content: Row(
      children: [
        SizedBox(
          height: 5.h,
          width: 10.w,
          child: const LoadingIndicator(
              indicatorType: Indicator.ballRotateChase,
              colors: [AppColors.primaryColor],
              strokeWidth: 4,
              backgroundColor: Colors.transparent,
              pathBackgroundColor: Colors.transparent),
        ),
        SizedBox(
          width: 2.w,
        ),
        Text(
          "الرجاء الانتظار ...",
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
        )
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    useSafeArea:true ,
    context: context,
    builder: (BuildContext context) {
      return alertDialog;
    },
  );
}
