import 'package:flutter/material.dart';
import 'package:raghadcell/App/app_localizations.dart';
import 'package:raghadcell/Core/Constants/app_assets.dart';
import 'package:raghadcell/Core/Constants/app_colors.dart';
import 'package:sizer/sizer.dart';

class RigesterHeaderWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final String? email;
  const RigesterHeaderWidget(
      {this.subTitle = "", this.email, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          height: 2.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Image(
            image: const AssetImage(
              AppAssets.logoImage,
            ),
            height: 15.h,
            width: 40.w,
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
        Center(
            child: Text(
          title.tr(context),
          style: TextStyle(
              color: AppColors.blackColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold),
        )),
        SizedBox(
          height: 1.h,
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                subTitle.tr(context),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.borderColor,
                  fontSize: 10.sp,
                ),
              ),
            ),
          ],
        ),
        email != null
            ? Row(
                children: [
                  Expanded(
                    child: Text(
                      email!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 10.sp,
                      ),
                    ),
                  ),
                ],
              )
            : const SizedBox(),
      ],
    );
  }
}
