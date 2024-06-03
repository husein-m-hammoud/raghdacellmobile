import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:raghadcell/App/app.dart';
import 'package:raghadcell/App/app_localizations.dart';
import 'package:raghadcell/Core/Widgets/header_title_widget.dart';
import 'package:raghadcell/Core/Widgets/main_backgraund_widget.dart';
import 'package:raghadcell/Core/Widgets/select_start_and_end_date.dart';
import 'package:raghadcell/Core/Widgets/titles_widget.dart';
import 'package:raghadcell/Core/function/functions.dart';
import 'package:raghadcell/Feature/SideMenu/Presentation/Pages/orders_details_page.dart';
import 'package:raghadcell/Feature/SideMenu/Presentation/Widgets/lists.dart';
import 'package:raghadcell/Feature/SideMenu/Presentation/Widgets/request_card_widget.dart';
import 'package:raghadcell/Feature/SideMenu/blocs/orders_bloc/orders_bloc.dart';
import 'package:raghadcell/Feature/Wallet/Presentation/Widgets/drop_down_widget.dart';
import 'package:sizer/sizer.dart';

class RequestsPage extends StatefulWidget {
  const RequestsPage({super.key});

  @override
  State<RequestsPage> createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  final TextEditingController startDateController = TextEditingController();

  final TextEditingController endDateController = TextEditingController();

  final String selectedItem = 'All';

  final String selectedDay = 'All';

  final OrdersBloc ordersBloc = OrdersBloc()..add(GetAndFilterOrdersEvent());

  bool isvisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ordersBloc,
      child: Scaffold(
        body: MainBackGraundWidget(
          child: SafeArea(child: BlocBuilder<OrdersBloc, OrdersState>(
            // listener: (context, state) {},
            builder: (context, state) {
              return Column(
                children: [
                  HeaderTitleWidget(
                    title: "Orders".tr(context),
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
                          items: RequestsLists.status(context),
                          onChange: (value) {
                            if (value == "All".tr(context)) {
                              ordersBloc.add(GetAndFilterOrdersEvent());
                            } else if (value == "Completed".tr(context)) {
                              ordersBloc.add(
                                  GetAndFilterOrdersEvent(status: "COMPLETED"));
                            } else if (value == "Canceled".tr(context)) {
                              ordersBloc.add(
                                  GetAndFilterOrdersEvent(status: "CANCELED"));
                            } else if (value == "Waiting".tr(context)) {
                              ordersBloc.add(
                                  GetAndFilterOrdersEvent(status: "WAITING"));
                            }
                          },
                        ),
                        DropDownWidget(
                          items: RequestsLists.days(context),
                          onChange: (value) {
                            setState(() {
                              isvisible = value == 'Specific date'.tr(context);
                              if (value == "Today".tr(context)) {
                                ordersBloc.add(GetAndFilterOrdersEvent(
                                    startDate: getDateToday()));
                              } else if (value == "Last week".tr(context)) {
                                ordersBloc.add(GetAndFilterOrdersEvent(
                                    startDate: getLastWeek()
                                        .toString()
                                        .substring(0, 10)));
                              } else if (value == "Last Month".tr(context)) {
                                ordersBloc.add(GetAndFilterOrdersEvent(
                                    startDate: getLastMonth()
                                        .toString()
                                        .substring(0, 10)));
                              } else if (value ==
                                  "Specific date".tr(context)) {}
                              // startDateController.clear();
                              // endDateController.clear();
                            });
                          },
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
                          ordersBloc.add(GetAndFilterOrdersEvent(
                              startDate: startDateController.text,
                              endDate: endDateController.text));
                        }
                      },
                      isvisible: isvisible,
                      startDateController: startDateController,
                      endDateController: endDateController),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    child: TitlesWidget(
                      title1: "Products".tr(context),
                      title2: "ID".tr(context),
                      title3: "Player Number".tr(context),
                      title4: "Order Status".tr(context),
                      title5: "Action".tr(context),
                      // title6: "Date".tr(context),
                      // title7: "Time".tr(context),
                      // title8: "Price".tr(context),
                      // title9: ,
                    ),
                  ),
                  Expanded(
                      child: state is GetOrdersState
                          ? ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 2.w),
                              physics: const BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
                              itemCount:
                                  state.ordersModerl.data!.orders!.length,
                              itemBuilder: (context, index) {
                                return RequestCardWidget(
                                  order:
                                      state.ordersModerl.data!.orders![index],
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      PageTransition(
                                          child: RequestsDetailsPage(
                                            order: state.ordersModerl.data!
                                                .orders![index],
                                          ),
                                          type: PageTransitionType.rightToLeft,
                                          duration: const Duration(
                                              milliseconds: 400)),
                                    );
                                  },
                                  colorState: state.ordersModerl.data!
                                              .orders![index].status ==
                                          "WAITING"
                                      ? Colors.blue
                                      : state.ordersModerl.data!.orders![index]
                                                  .status ==
                                              "COMPLETED"
                                          ? Colors.green
                                          : state.ordersModerl.data!
                                                      .orders![index].status ==
                                                  "CANCELED"
                                              ? Colors.red
                                               : state
                                                          .ordersModerl
                                                          .data!
                                                          .orders![index]
                                                          .status ==
                                                      "FAILED"
                                                  ? Colors.blue
                                                  : Colors.black,
                                );
                              },
                            )
                          : state is OrdersLoadingState
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : state is OrdersErrorState
                                  ? Center(
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(state.message),
                                            TextButton(
                                                onPressed: () {
                                                  ordersBloc.add(
                                                      GetAndFilterOrdersEvent());
                                                },
                                                child: Text(
                                                  'Try Again'.tr(context),
                                                  style: errorTryAgainStyle,
                                                ))
                                          ]),
                                    )
                                  : Text("Error".tr(context)))
                ],
              );
            },
          )),
        ),
      ),
    );
  }
}
