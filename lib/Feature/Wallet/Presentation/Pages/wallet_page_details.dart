import 'package:flutter/material.dart';
import 'package:raghadcell/App/app_localizations.dart';
import 'package:raghadcell/Core/Constants/app_assets.dart';
import 'package:raghadcell/Core/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:raghadcell/Core/Widgets/background_widget.dart';
import 'package:raghadcell/Core/Widgets/header_title_widget.dart';
import 'package:raghadcell/Core/function/functions.dart';
import 'package:raghadcell/Feature/SideMenu/Presentation/Widgets/requests_details_widget.dart';
import 'package:raghadcell/Feature/Wallet/Presentation/model/view_wallet_model.dart';
import 'package:sizer/sizer.dart';

class WalletDetailsPage extends StatelessWidget {
  final WalletDetails walletDetails;

  const WalletDetailsPage({
    required this.walletDetails,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
          image: AppAssets.backGroundImage,
          child: SafeArea(
              child: Column(
            children: [
              HeaderTitleWidget(
                title: "Requests".tr(context),
              ),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                      margin:
                          EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.red),
                          borderRadius: BorderRadius.circular(3.w)),
                      child: Column(
                        children: [
                          Center(
                            child: CircleAvatar(
                              radius: 40.sp,
                              child: Image.asset(
                                  walletDetails.status == "Discounted"
                                      ? AppAssets.redIcon
                                      : AppAssets.greenIcon),
                            ),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          RequestsDetailsWidget(
                            title: "Order Status : ".tr(context),
                            detail: walletDetails.status.toString(),
                          ),
                          RequestsDetailsWidget(
                            title: "Process name : ".tr(context),
                            detail: walletDetails.name.toString(),
                          ),
                          RequestsDetailsWidget(
                            title: "Date : ".tr(context),
                            detail: walletDetails.date.toString(),
                          ),
                          RequestsDetailsWidget(
                            title: "Time : ".tr(context),
                            detail: walletDetails.time!,
                          ),
                          RequestsDetailsWidget(
                            title: "Value : ".tr(context),
                            detail:
                                formatNumber(walletDetails.value!),
                          ),
                          RequestsDetailsWidget(
                            title: "Previous value : ".tr(context),
                            detail:
                                formatNumber(walletDetails.previousBalance),
                          ),
                          RequestsDetailsWidget(
                            title: "Current value : ".tr(context),
                            detail:
                                formatNumber(walletDetails.currentBalance),
                            fontWeight: FontWeight.bold,
                            textColor: Colors.green,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ))),
    );
  }
}
