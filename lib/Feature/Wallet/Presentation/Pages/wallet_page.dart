import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raghadcell/App/app_localizations.dart';
import 'package:raghadcell/Core/Constants/app_colors.dart';
import 'package:raghadcell/Core/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:raghadcell/Core/Widgets/header_title_widget.dart';
import 'package:raghadcell/Core/Widgets/select_start_and_end_date.dart';
import 'package:raghadcell/Core/Widgets/titles_widget.dart';
import 'package:raghadcell/Core/function/functions.dart';
import 'package:raghadcell/Feature/Wallet/Presentation/Widgets/drop_down_widget.dart';
import 'package:raghadcell/Feature/Wallet/Presentation/Widgets/lists.dart';
import 'package:raghadcell/Feature/Wallet/Presentation/Widgets/money_widget.dart';
import 'package:raghadcell/Feature/Wallet/Presentation/Widgets/wallet_card_widget.dart';
import 'package:raghadcell/Feature/Wallet/bloc/wallet_datails_bloc.dart';
import 'package:sizer/sizer.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  // final String selectedItem = 'All';

  // final String selectedDay = 'All';
  final WalletDetailsBloc walletDetailsBloc = WalletDetailsBloc()
    ..add(GetAndFilterWalletDetailsEvent());

  final TextEditingController startDateController = TextEditingController();

  final TextEditingController endDateController = TextEditingController();

  bool isvisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => walletDetailsBloc,
      child: Scaffold(
        body:
            SafeArea(child: BlocBuilder<WalletDetailsBloc, WalletDetailsState>(
          builder: (context, state) {
            return Column(
              children: [
                HeaderTitleWidget(
                  title: "Wallet".tr(context),
                  buttonBack: true,
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MoneyWidget(
                          backColor: const Color(0xff9a192c),
                          money: state is GetWalletDetailsState
                              ? formatNumber(
                                  state.viewWalletModel.user!.currentBalance)
                              : state is WalletDetailsLoadingState
                                  ? "Loading...".tr(context)
                                  : state is WalletDetailsErrorState
                                      ? state.message
                                      : "Error".tr(context),
                          title: "Current Balance".tr(context),
                          textColor: Colors.white,
                          borderColor: AppColors.seconedaryColor),
                      MoneyWidget(
                          backColor: const Color(0xff115f2f),
                          money: state is GetWalletDetailsState
                              ? formatNumber(
                                  state.viewWalletModel.user!.totalShipped)
                              : state is WalletDetailsLoadingState
                                  ? "Loading..."
                                  : state is WalletDetailsErrorState
                                      ? state.message
                                      : "Error",
                          title: "Shipping Total".tr(context),
                          textColor: Colors.white,
                          borderColor: AppColors.primaryColor),
                      MoneyWidget(
                          backColor: const Color(0xff482c52),
                          money: state is GetWalletDetailsState
                              ? formatNumber(
                                  state.viewWalletModel.user!.totalSpent)
                              : state is WalletDetailsLoadingState
                                  ? "Loading..."
                                  : state is WalletDetailsErrorState
                                      ? state.message
                                      : "Error",
                          title: "Total Payment".tr(context),
                          textColor: Colors.white,
                          borderColor: AppColors.seconedaryColor),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropDownWidget(
                        onChange: (value) {
                          if (value == "All".tr(context)) {
                            walletDetailsBloc
                                .add(GetAndFilterWalletDetailsEvent());
                          } else if (value == "Imports".tr(context)) {
                            walletDetailsBloc.add(
                                GetAndFilterWalletDetailsEvent(
                                    status: "Charged"));
                          } else if (value == "Exports".tr(context)) {
                            walletDetailsBloc.add(
                                GetAndFilterWalletDetailsEvent(
                                    status: "Discounted"));
                          }
                        },
                        items: WalletLists.filter(context),
                      ),
                      DropDownWidget(
                        onChange: (value) {
                          setState(() {
                            isvisible = value == 'Specific date'.tr(context);
                            if (value == "All".tr(context)) {
                              walletDetailsBloc
                                  .add(GetAndFilterWalletDetailsEvent());
                            } else if (value == "Today".tr(context)) {
                              walletDetailsBloc.add(
                                  GetAndFilterWalletDetailsEvent(
                                      startDate: getDateToday()));
                            } else if (value == "Last week".tr(context)) {
                              walletDetailsBloc.add(
                                  GetAndFilterWalletDetailsEvent(
                                      startDate: getLastWeek()
                                          .toString()
                                          .substring(0, 10)));
                            } else if (value == "Last Month".tr(context)) {
                              walletDetailsBloc.add(
                                  GetAndFilterWalletDetailsEvent(
                                      startDate: getLastMonth()
                                          .toString()
                                          .substring(0, 10)));
                            } else if (value == "Specific date".tr(context)) {}
                          });
                        },
                        items: WalletLists.days(context),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                SelectStartAndEndDate(
                    onValue: (value) {
                      value.fold((l) {
                        startDateController.text = l;
                      }, (r) {
                        endDateController.text = r;
                      });
                      if (startDateController.text != "" &&
                          endDateController.text != "") {
                        walletDetailsBloc.add(GetAndFilterWalletDetailsEvent(
                            startDate: startDateController.text,
                            endDate: endDateController.text));
                      }
                    },
                    isvisible: isvisible,
                    startDateController: startDateController,
                    endDateController: endDateController),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: TitlesWidget(
                    title1: "Event".tr(context),
                    title2: "Previous value".tr(context),
                    title3: "Value".tr(context),
                    title4: "Current value".tr(context),
                    title5: "Action".tr(context),
                  ),
                ),
                Expanded(
                  child: state is GetWalletDetailsState
                      ? ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          itemCount:
                              state.viewWalletModel.data!.walletDetails!.length,
                          itemBuilder: (context, index) {
                            return WalletCardWidget(
                                walletDetails: state.viewWalletModel.data!
                                    .walletDetails![index]);
                          },
                        )
                      : state is WalletDetailsLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : state is WalletDetailsErrorState
                              ? Text.rich(
                                  TextSpan(children: [
                                    TextSpan(text: state.message),
                                    TextSpan(
                                        text: 'Try Again'.tr(context),
                                        style: TextStyle(fontSize: 10.sp),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            walletDetailsBloc.add(
                                                GetAndFilterWalletDetailsEvent());
                                          })
                                  ]),
                                )
                              : Text("Error".tr(context)),
                )
              ],
            );
          },
        )),
      ),
    );
  }
}
