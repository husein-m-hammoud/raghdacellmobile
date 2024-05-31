import 'package:flutter/material.dart';
import 'package:raghadcell/App/app_localizations.dart';
import 'package:raghadcell/Core/Widgets/header_title_widget.dart';
import 'package:raghadcell/Core/Widgets/titles_widget.dart';
import 'package:raghadcell/Feature/ShippingPayments/Presentation/Widgets/card_payment_widget.dart';
import 'package:raghadcell/Core/Widgets/toggle_payment_card_widget.dart';
import 'package:raghadcell/model.dart';
import 'package:sizer/sizer.dart';

class ShippingPayments extends StatelessWidget {
  ShippingPayments({super.key});
  final List<bool> isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      HeaderTitleWidget(
        title: "Shipping payments".tr(context),
        buttonBack: false,
      ),
      SizedBox(
        height: 2.h,
      ),
      TogglePaymentCardsWidget(isSelected: isSelected, onTap: (index) {}),
      SizedBox(
        height: 2.h,
      ),
      const TitlesWidget(
        title1: "Value",
        title2: "Notice",
        title3: "Date",
        title4: "Order Status",
      ),
      Expanded(
          child: ListView.builder(
        itemCount: paymentsModel.length,
        itemBuilder: (context, index) {
          return CardPaymentWidget(
              colorState: paymentsModel[index].colorState,
              date: paymentsModel[index].date,
              orderStatus: paymentsModel[index].orderStatus,
              notice: paymentsModel[index].notice,
              value: paymentsModel[index].value);
        },
      ))
    ])));
  }
}
