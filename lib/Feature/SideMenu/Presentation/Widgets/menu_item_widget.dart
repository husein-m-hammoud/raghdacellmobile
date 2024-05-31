import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:raghadcell/Core/Constants/app_colors.dart';
import 'package:sizer/sizer.dart';

class MenuItemWidget extends StatelessWidget {
  final String text;
  final Function onTap;
  final Color color;

  const MenuItemWidget(
      {required this.onTap,
      required this.text,
      super.key,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3.w)),
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
              margin: EdgeInsets.symmetric(horizontal: 3.w),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15.sp, color: AppColors.blackColor),
                    ),
                  ),
                ],
              ),
            ),
            // const Divider(
            //   thickness: 1,
            //   color: AppColors.borderColor,
            // )
          ],
        ),
      ),
    );
  }
}
