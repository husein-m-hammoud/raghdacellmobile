import 'package:flutter/material.dart';
import 'package:raghadcell/Core/Constants/app_colors.dart';
import 'package:sizer/sizer.dart';

class CardPaymentWidget extends StatelessWidget {
  final String value;
  final String notice;
  final String date;
  final String orderStatus;
  final Color colorState;
  const CardPaymentWidget(
      {required this.date,
      required this.orderStatus,
      required this.notice,
      required this.value,
      required this.colorState,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: Row(
          children: [
            Expanded(
                child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.blackColor, fontSize: 10.sp),
            )),
            const Expanded(
                child: CircleAvatar(
              child: Icon(Icons.person),
            )),
            Expanded(
                child: Text(
              date,
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.blackColor, fontSize: 10.sp),
            )),
            Expanded(
                child: Text(
              orderStatus,
              textAlign: TextAlign.center,
              style: TextStyle(color: colorState, fontSize: 10.sp),
            )),
          ],
        ),
      ),
    );
  }
}
