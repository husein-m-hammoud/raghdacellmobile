import 'package:flutter/material.dart';
import 'package:raghadcell/Core/Constants/app_assets.dart';
import 'package:raghadcell/Core/Constants/app_colors.dart';
import 'package:raghadcell/Core/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:raghadcell/Feature/Wallet/Presentation/model/view_wallet_model.dart';
import 'package:sizer/sizer.dart';

class CardWalletDesginWidget extends StatelessWidget {
  final WalletDetails walletDetails;
  final void Function()? onPressed;
  const CardWalletDesginWidget({
    super.key,
    required this.walletDetails,
    this.onPressed,
  });

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
              backgroundImage: AssetImage(walletDetails.status == "Discounted"
                  ? AppAssets.redIcon
                  : AppAssets.greenIcon),
            )),
            Expanded(
                child: Text(
              walletDetails.status!,
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.blackColor, fontSize: 7.sp),
            )),
            Expanded(
                child: Text(
              walletDetails.name!,
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.blackColor, fontSize: 7.sp),
            )),
            Expanded(
                child: Text(
              walletDetails.date!,
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.blackColor, fontSize: 7.sp),
            )),
            Expanded(
                child: Text(
              walletDetails.time!,
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.blackColor, fontSize: 7.sp),
            )),
            Expanded(
                child: Text(
              "${walletDetails.previousBalance}${AppSharedPreferences.isUSD ? "\$" : "LBP"}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 7.sp,
                  decoration: TextDecoration.lineThrough),
            )),
            Expanded(
                child: Text(
              "${walletDetails.value!}${AppSharedPreferences.isUSD ? "\$" : "LBP"}",
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.blackColor, fontSize: 7.sp),
            )),
            Expanded(
                child: Text(
              "${walletDetails.currentBalance!}${AppSharedPreferences.isUSD ? "\$" : "LBP"}",
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.blackColor, fontSize: 7.sp),
            )),
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
    // return Card(
    //     elevation: 1,
    //     child: ListTile(
    //       leading: Container(
    //         height: 6.h,
    //         width: 10.w,
    //         decoration: BoxDecoration(
    //             image: DecorationImage(
    //                 image: AssetImage(walletDetails.status == "Discounted"
    //                     ? AppAssets.redIcon
    //                     : AppAssets.greenIcon))),
    //       ),
    //       title: Text(
    //         walletDetails.status!,
    //         style: TextStyle(
    //           fontSize: 14.sp,
    //         ),
    //       ),
    //       subtitle: Text(walletDetails.name!,
    //           style: TextStyle(
    //             color: AppColors.borderColor,
    //             fontSize: 8.sp,
    //           )),
    //       trailing: Text.rich(
    //         TextSpan(
    //           text: '',
    //           children: <TextSpan>[
    //             TextSpan(
    //                 text: walletDetails.date,
    //                 style: TextStyle(
    //                   color: AppColors.seconedaryColor,
    //                   fontSize: 12.sp,
    //                   decoration: TextDecoration.lineThrough,
    //                 )),
    //             TextSpan(
    //               text: walletDetails.time,
    //               style: TextStyle(
    //                 color: Colors.green,
    //                 fontSize: 12.sp,
    //                 decoration: null,
    //               ),
    //             ),
    //             TextSpan(
    //               text: walletDetails.time,
    //               style: TextStyle(
    //                 color: Colors.green,
    //                 fontSize: 12.sp,
    //                 decoration: null,
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ));
  }
}
