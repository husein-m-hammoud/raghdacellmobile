import 'package:flutter/material.dart';
import 'package:raghadcell/Core/Widgets/column_text.dart';
import 'package:raghadcell/Feature/Wallet/Presentation/model/view_wallet_model.dart';
import 'package:sizer/sizer.dart';

class CardText extends StatelessWidget {
  const CardText(
      {super.key, required this.walletDetails, required this.columnTextList});

  final WalletDetails walletDetails;
  final List<RowText> columnTextList;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 2.h),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.w),
          side: BorderSide(color: Colors.purple, width: 0.5.w)),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          for (int i = 0; i < columnTextList.length; i++)
            RowText(
                title: columnTextList[i].title,
                subtitle: columnTextList[i].subtitle),
          // SizedBox(
          //   height: 2.h,
          // ),
          // ColumnText(
          //   title: 'رقم هوية الأحوال أو البطاقة الوطنية : ',
          //   subtitle: message.idNumber!,
          // ),
          // SizedBox(
          //   height: 2.h,
          // ),
          // ColumnText(
          //   title: 'رقم الهاتف المرتبط بالمحفظة : ',
          //   subtitle: message.phoneNumber!,
          // ),
          // SizedBox(
          //   height: 2.h,
          // ),
          // ColumnText(
          //   title: 'في أي محافظة تسكن : ',
          //   subtitle: message.province!,
          // ),
          // SizedBox(
          //   height: 2.h,
          // ),
          // ColumnText(
          //   title: 'حد السقف الشهري :  ',
          //   subtitle: message.maxSalary!,
          // ),
        ]),
      ),
    );
  }
}
