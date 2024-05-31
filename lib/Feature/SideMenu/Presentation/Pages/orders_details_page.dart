import 'package:flutter/material.dart';
import 'package:raghadcell/Apis/Urls.dart';
import 'package:raghadcell/App/app_localizations.dart';
import 'package:raghadcell/Core/Constants/app_assets.dart';
import 'package:raghadcell/Core/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:raghadcell/Core/Widgets/background_widget.dart';
import 'package:raghadcell/Core/Widgets/header_title_widget.dart';
import 'package:raghadcell/Core/Widgets/single_image_widget.dart';
import 'package:raghadcell/Core/function/functions.dart';
import 'package:raghadcell/Feature/SideMenu/Presentation/Widgets/requests_details_widget.dart';
import 'package:raghadcell/Feature/SideMenu/Presentation/models/orders_model.dart';
import 'package:sizer/sizer.dart';
class RequestsDetailsPage extends StatelessWidget {
  final Orders order;
  const RequestsDetailsPage({required this.order, super.key});

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
                    child: Column(
                      children: [
                        SingleImageWidget(
                            image: Urls.storage + order.productImage),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 3.w, vertical: 1.h),
                          margin: EdgeInsets.symmetric(
                              vertical: 1.h, horizontal: 2.w),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.red),
                              borderRadius: BorderRadius.circular(3.w)),
                          child: Column(
                            children: [
                              RequestsDetailsWidget(
                                title: "ID",
                                detail: order.id.toString(),
                              ),
                              RequestsDetailsWidget(
                                title: "Date",
                                detail: order.date.toString(),
                              ),
                              RequestsDetailsWidget(
                                title: "Time",
                                detail: order.time.toString(),
                              ),
                              RequestsDetailsWidget(
                                title: "User Name",
                                detail: order.user!.username!,
                              ),
                              RequestsDetailsWidget(
                                title: "Phone",
                                detail: order.user!.phoneNumber!,
                              ),
                              order.walletAddress != null
                                  ? RequestsDetailsWidget(
                                      title: "Wallet Address",
                                      detail: order.walletAddress,
                                      fontWeight: FontWeight.bold,
                                      textColor: Colors.green,
                                    )
                                  : const SizedBox(),
                              order.refuseReason != null
                                  ? RequestsDetailsWidget(
                                      title: "Refuse Reason",
                                      detail: order.refuseReason,
                                    )
                                  : order.acceptNote != null
                                      ? RequestsDetailsWidget(
                                          title: "Accept Note",
                                          detail: order.acceptNote,
                                        )
                                      : const SizedBox(),
                              RequestsDetailsWidget(
                                title: "Order Status",
                                detail: order.status,
                              ),
                              order.playerName != null
                                  ? RequestsDetailsWidget(
                                      title: "Player name",
                                      detail: order.playerName,
                                    )
                                  : const SizedBox(),
                              order.playerNumber != null
                                  ? RequestsDetailsWidget(
                                      title: "Player Number",
                                      detail: order.playerNumber,
                                    )
                                  : const SizedBox(),
                              order.productName != null
                                  ? RequestsDetailsWidget(
                                      title: "Product",
                                      detail: order.productName,
                                    )
                                  : const SizedBox(),
                              order.packageName != null
                                  ? RequestsDetailsWidget(
                                      title: "Packages",
                                      detail: order.packageName,
                                    )
                                  : const SizedBox(),
                              order.quantity != null
                                  ? RequestsDetailsWidget(
                                      title: "Quantity",
                                      detail: order.quantity.toString(),
                                    )
                                  : const SizedBox(),
                              order.totalPrice != null
                                  ? RequestsDetailsWidget(
                                      title: "Total Price",
                                      detail: formatNumber(order.totalPrice),
                                      // "${order.totalPrice.toString()}${AppSharedPreferences.isUSD ? "\$" : "LBP"}",
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ))),
    );
  }
}
