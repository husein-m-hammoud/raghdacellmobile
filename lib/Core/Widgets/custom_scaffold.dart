
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../Constants/app_colors.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({this.title = '', this.buttonBack = true, required this.body,super.key});
  final String title;
  final bool buttonBack;
  final Widget body;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.borderColor,
            size: 8.w,
          ),
        ),

        elevation: 0,
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: AppColors.blackColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold),
        ),

      ),
      body: SafeArea(child: body),
    );
  }
}
