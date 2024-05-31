import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raghadcell/App/app_localizations.dart';
import 'package:raghadcell/Core/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:raghadcell/Core/Widgets/header_title_widget.dart';
import 'package:raghadcell/Core/Widgets/toggle_payment_card_widget.dart';
import 'package:raghadcell/Feature/SideMenu/Presentation/Widgets/USDT_card_widget.dart';
import 'package:raghadcell/Feature/SideMenu/Presentation/Widgets/promo_code.dart';
import 'package:raghadcell/Feature/SideMenu/Presentation/Widgets/whish_money_card.dart';
import 'package:raghadcell/Feature/SideMenu/blocs/deposit_bloc/deposit_bloc.dart';
import 'package:sizer/sizer.dart';

class ChargingTheWalletPage extends StatefulWidget {
  const ChargingTheWalletPage({super.key});

  @override
  State<ChargingTheWalletPage> createState() => _ChargingTheWalletPageState();
}

class _ChargingTheWalletPageState extends State<ChargingTheWalletPage> {
  // final FocusNode linkNode = FocusNode();

  // final TextEditingController phoneController =
  //     TextEditingController(text: "0987655432");

  final List<bool> isSelected = [
    if (AppSharedPreferences.isUSD) true,
    false,
    false
  ];

  final PageController pageController = PageController();
  DepositBloc depositBloc = DepositBloc()..add(GetDepositInformationEvent());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => depositBloc,
      child: Scaffold(
          body: SafeArea(
              child: Column(children: [
        HeaderTitleWidget(
          title: "Charging the wallet".tr(context),
        ),
        SizedBox(
          height: 2.h,
        ),
        TogglePaymentCardsWidget(
            isSelected: isSelected,
            onTap: (index) {
              pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.linear);
            }),
        SizedBox(
          height: 2.h,
        ),
        Expanded(child: BlocBuilder<DepositBloc, DepositState>(
          builder: (context, state) {
            if (state is GetDepositInformationState) {
              return PageView(
                onPageChanged: (index) {
                  setState(() {
                    for (int indexBtn = 0;
                        indexBtn < isSelected.length;
                        indexBtn++) {
                      if (indexBtn == index) {
                        isSelected[indexBtn] = true;
                      } else {
                        isSelected[indexBtn] = false;
                      }
                    }
                  });
                },
                controller: pageController,
                children: [
                  if (AppSharedPreferences.isUSD)
                    USDTCardWidget(
                        usdtTaxPercentage: state
                            .depositInformationModel.data!.usdtTaxPercentage!,
                        ustdText:
                            state.depositInformationModel.data!.usdtText!),
                  WhishMoneyCardWidget(
                      whishMoneyTaxPercentage: state.depositInformationModel
                          .data!.whishMoneyTaxPercentage!,
                      wishMonyPhoneNumber:
                          state.depositInformationModel.data!.whishMoneyText!),
                  PromoCode()
                ],
              );
            } else if (state is GetDepositInformationLoadingAndErrorState) {
              return const Center(child: CircularProgressIndicator());
            }
            return TextButton(
                onPressed: () {
                  depositBloc.add(GetDepositInformationEvent());
                },
                child: const Text(
                  "Try Again",
                  style: TextStyle(color: Colors.blue),
                ));
          },
        ))
      ]))),
    );
  }
}
