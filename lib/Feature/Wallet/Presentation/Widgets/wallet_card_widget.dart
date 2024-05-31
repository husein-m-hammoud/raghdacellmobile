import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:raghadcell/Core/Constants/app_assets.dart';
import 'package:raghadcell/Core/Constants/app_colors.dart';
import 'package:raghadcell/Core/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:raghadcell/Core/function/functions.dart';
import 'package:raghadcell/Feature/Wallet/Presentation/Pages/wallet_page_details.dart';
import 'package:raghadcell/Feature/Wallet/Presentation/model/view_wallet_model.dart';
import 'package:sizer/sizer.dart';

class WalletCardWidget extends StatelessWidget {
  final WalletDetails walletDetails;
  const WalletCardWidget({super.key, required this.walletDetails});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
        child: Row(
          children: [
            Expanded(
                child: CircleAvatar(
              backgroundColor: walletDetails.status == "Discounted"
                  ? Colors.pink[100]
                  : Colors.grey[400],
              child: Image.asset(walletDetails.status == "Discounted"
                  ? AppAssets.redIcon
                  : AppAssets.greenIcon),
              // backgroundImage: AssetImage(
              //     walletDetails.status == "Discounted"
              //         ? AppAssets.redIcon
              //         : AppAssets.greenIcon)
            )),
            Expanded(
                child: Text(
              textDirection: TextDirection.ltr,
              formatNumber(walletDetails.previousBalance),
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.blackColor, fontSize: 11.sp),
            )),
            Expanded(
                child: Text(
              textDirection: TextDirection.ltr,
              formatNumber(walletDetails.value),
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.blackColor, fontSize: 11.sp),
            )),
            Expanded(
                child: Text(
              textDirection: TextDirection.ltr,
              formatNumber(walletDetails.currentBalance),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color.fromRGBO(22, 163, 74, 1.0), fontSize: 11.sp),
            )),
            // Expanded(
            //     child: Text(
            //   order.playerName != null ? order.playerName : '_',
            //   textAlign: TextAlign.center,
            //   style: TextStyle(color: AppColors.blackColor, fontSize: 7.sp),
            // )),
            Expanded(
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    PageTransition(
                        child: WalletDetailsPage(
                          walletDetails: walletDetails,
                        ),
                        type: PageTransitionType.rightToLeft,
                        duration: const Duration(milliseconds: 400)),
                  );
                },
                icon: const Icon(
                  Icons.visibility,
                  color: Colors.red,
                ),
              ),
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
            // Expanded(
            //     child: IconButton(
            //   onPressed: onPressed,
            //   icon: const Icon(
            //     Icons.visibility,
            //     color: Colors.red,
            //   ),
            // )),
          ],
        ),
      ),
    );
  }
}
