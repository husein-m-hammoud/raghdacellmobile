// ignore_for_file: prefer_if_null_operators

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:raghadcell/Apis/Urls.dart';
import 'package:raghadcell/Core/Constants/app_colors.dart';
import 'package:raghadcell/Feature/SideMenu/Presentation/models/orders_model.dart';
import 'package:sizer/sizer.dart';

class RequestCardWidget extends StatelessWidget {
  final Color colorState;
  final void Function()? onPressed;
  final Orders order;
  const RequestCardWidget(
      {required this.onPressed,
      required this.colorState,
      super.key,
      required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: Row(
          children: [
            Expanded(
                child: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                  Urls.storage + order.productImage!),
            )),
            Expanded(
                child: Text(
              "${order.id}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.blackColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold),
            )),
            Expanded(
                child: Text(
              order.playerNumber != null ? order.playerNumber! : '_',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.blackColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold),
            )),
            // Expanded(
            //     child: Text(
            //   order.playerName != null ? order.playerName : '_',
            //   textAlign: TextAlign.center,
            //   style: TextStyle(color: AppColors.blackColor, fontSize: 7.sp),
            // )),
            Text(
              order.status == "COMPLETED" ? "COMPLETE" : order.status!,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: colorState,
                  fontSize: colorState == Colors.red
                      ? 9.sp
                      : colorState == Colors.green
                          ? 9.sp
                          : 11.sp,
                  fontWeight: FontWeight.w500),
            ),
            // Expanded(
            //     child: Text(
            //   order.date!,
            //   textAlign: TextAlign.center,
            //   style: TextStyle(color: AppColors.blackColor, fontSize: 7.sp),
            // )),
            // Expanded(
            //     child: Text(
            //   order.time!,
            //   textAlign: TextAlign.center,
            //   style: TextStyle(color: AppColors.blackColor, fontSize: 7.sp),
            // )),
            // Expanded(
            //     child: Text(
            //   "${order.totalPrice!}${AppSharedPreferences.isUSD ? "\$" : "LBP"}",
            //   textAlign: TextAlign.center,
            //   style: TextStyle(color: AppColors.blackColor, fontSize: 7.sp),
            // )),
            Expanded(
                child: IconButton(
              onPressed: onPressed,
              icon: const Icon(
                Icons.visibility,
                color: Colors.red,
              ),
            )),
          ],
        ),
      ),
    );
  }
}
