import 'package:flutter/material.dart';
import 'package:raghadcell/Core/Constants/app_assets.dart';
import 'package:raghadcell/Core/Constants/app_colors.dart';

import 'package:sizer/sizer.dart';

showBadDialog(BuildContext context, {required String message}) {
  AlertDialog alertDialog = AlertDialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.w),
        side: const BorderSide(width: 2, color: AppColors.primaryColor)),
    content: SizedBox(
      height: 30.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: const AssetImage(AppAssets.opsImage),
            height: 15.h,
          ),
          SizedBox(height: 3.h,),
          Row(
            children: [
              Expanded(
                  child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.blackColor, fontSize: 15.sp),
              ))
            ],
          )
        ],
      ),
    ),
  );
  showDialog(
    barrierDismissible: true,
    useSafeArea: true,
    context: context,
    builder: (BuildContext context) {
      return alertDialog;
    },
  );
}
