import 'package:flutter/material.dart';
import 'package:raghadcell/Core/Constants/app_colors.dart';
import 'package:sizer/sizer.dart';

class RequestsDetailsWidget extends StatelessWidget {
  final String title;
  final String detail;
  final FontWeight fontWeight;
  final Color textColor;
  const RequestsDetailsWidget(
      {this.fontWeight = FontWeight.normal,
      this.textColor = Colors.black,
      required this.title,
      required this.detail,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
              ),
            )),
            Expanded(
                flex: 2,
                child: Text(
                  detail,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: fontWeight,
                      color: textColor),
                ))
          ],
        ),
        const Divider(
          thickness: 1,
          color: AppColors.borderColor,
        )
      ],
    );
  }
}
