import 'package:flutter/material.dart';
import 'package:raghadcell/Core/Constants/app_colors.dart';

import 'package:sizer/sizer.dart';

class HeaderTitleWidget extends StatelessWidget {
  final String title;
  final bool buttonBack;
  const HeaderTitleWidget({this.buttonBack = true, this.title = "", super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        children: [
          Expanded(
            child: buttonBack
                ? IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.borderColor,
                      size: 8.w,
                    ),
                  )
                : const SizedBox(),
          ),
          Expanded(
              flex: 2,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold),
              )),
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
