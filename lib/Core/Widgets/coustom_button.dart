import 'package:flutter/material.dart';
import 'package:raghadcell/Core/Constants/app_colors.dart';
import 'package:sizer/sizer.dart';

class CoustomButton extends StatelessWidget {
  final Function onPressed;
  final String buttonText;
  final FontWeight? fontWeight;
  final double? size;
  final double? hieght;

  const CoustomButton(
      {required this.onPressed,
      required this.buttonText,
      this.fontWeight = FontWeight.bold,
      this.size = 16,
      super.key,
      this.hieght});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.w),
          gradient: const LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: AppColors.linearPrimaryColor)),
      child: MaterialButton(
        height: hieght,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.w)),
        // color: buttonColor,
        onPressed: () {
          onPressed();
        },
        child: Text(
          buttonText,
          style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: size!.sp,
              fontWeight: fontWeight),
        ),
      ),
    );
  }
}
