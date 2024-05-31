import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RowText extends StatelessWidget {
  const RowText({super.key, required this.title, required this.subtitle});
  final String title;
  final Widget subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w800),
              title,
            ),
          ),
          subtitle,
        ],
      ),
    );
  }
}
