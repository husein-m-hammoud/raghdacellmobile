import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class MoneyWidget extends StatelessWidget {
  final Color borderColor;
  final Color textColor;
  final String money;
  final String title;
  final Color backColor;
  const MoneyWidget(
      {required this.money,
      required this.title,
      required this.textColor,
      required this.borderColor,
      super.key,
      required this.backColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 30.w,
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
      margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
      decoration: BoxDecoration(
          color: backColor,
          borderRadius: BorderRadius.circular(2.w),
          border: Border.all(color: borderColor)),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    money,
                    maxLines: 2,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: textColor,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: textColor,
                      fontSize: 8.sp,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ]),
    );
  }
}
