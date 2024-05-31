import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:raghadcell/App/app.dart';
import 'package:raghadcell/App/app_localizations.dart';
import 'package:raghadcell/Core/Widgets/header_title_widget.dart';
import 'package:raghadcell/Core/Widgets/main_backgraund_widget.dart';
import 'package:raghadcell/Feature/notification/bloc/view_notification_bloc.dart';
import 'package:raghadcell/Feature/notification/presentation/widget/notification_card.dart';
import 'package:sizer/sizer.dart';

import '../../../../Core/Constants/app_colors.dart';

class ViewNotificationPage extends StatefulWidget {
  const ViewNotificationPage({super.key, required this.viewBackButton});
  final bool viewBackButton;

  @override
  State<ViewNotificationPage> createState() => _ViewNotificationPageState();
}

class _ViewNotificationPageState extends State<ViewNotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainBackGraundWidget(
        child: SafeArea(
          child: Column(
            children: [
              HeaderTitleWidget(
                buttonBack: widget.viewBackButton,
                title: "Notifications".tr(context),
              ),
              BlocProvider(
                create: (context) => ViewNotificationBloc()..add(ViewNotificationEvent()),
                child: BlocConsumer<ViewNotificationBloc, NotificationState>(
                  listener: (context, state) {
                    if (state is NotificationSuccessfulState) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.green,
                        duration: const Duration(seconds: 5),
                        content: Text(
                            "The Notification has been deleted successfully"
                                .tr(context)),
                      ));
                    } else if (state is NotificationErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          duration: const Duration(seconds: 5),
                          content: Center(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(state.message),
                                  TextButton(
                                      onPressed: () {
                                        context
                                            .read<ViewNotificationBloc>()
                                            .add(ViewNotificationEvent());
                                      },
                                      child: Text(
                                        'Try Again'.tr(context),
                                        style: errorTryAgainStyle,
                                      ))
                                ]),
                          )));
                    }
                  },
                  builder: (context, state) {
                    return Expanded(
                      // height: 80.h,
                      child: SmartRefresher(
                        onRefresh: () {
                          context.read<ViewNotificationBloc>().page = 1;
                          context
                              .read<ViewNotificationBloc>()
                              .add(ViewNotificationEvent());
                          context
                              .read<ViewNotificationBloc>()
                              .refreshController
                              .refreshCompleted();
                          context
                              .read<ViewNotificationBloc>()
                              .refreshController
                              .loadComplete();
                        },
                        onLoading: () async {
                          if (context
                                      .read<ViewNotificationBloc>()
                                      .viewNotificationModel!
                                      .data!
                                      .lastPage ==
                                  context.read<ViewNotificationBloc>().page ||
                              context
                                      .read<ViewNotificationBloc>()
                                      .viewNotificationModel!
                                      .data!
                                      .notifications!
                                      .length ==
                                  context
                                      .read<ViewNotificationBloc>()
                                      .viewNotificationModel!
                                      .data!
                                      .total!) {
                            context
                                .read<ViewNotificationBloc>()
                                .refreshController
                                .loadNoData();
                          } else if (context
                                      .read<ViewNotificationBloc>()
                                      .viewNotificationModel!
                                      .data!
                                      .notifications!
                                      .length <
                                  context
                                      .read<ViewNotificationBloc>()
                                      .viewNotificationModel!
                                      .data!
                                      .total! &&
                              context.read<ViewNotificationBloc>().page ==
                                  context
                                      .read<ViewNotificationBloc>()
                                      .viewNotificationModel!
                                      .data!
                                      .lastPage) {
                            context.read<ViewNotificationBloc>().page = 1;
                            context
                                .read<ViewNotificationBloc>()
                                .refreshController
                                .loadComplete();
                          } else {
                            context.read<ViewNotificationBloc>().page++;
                            context
                                .read<ViewNotificationBloc>()
                                .refreshController
                                .requestLoading();
                            context
                                .read<ViewNotificationBloc>()
                                .add(ViewNotificationEvent());
                            context
                                .read<ViewNotificationBloc>()
                                .refreshController
                                .loadComplete();
                          }
                        },
                        enablePullDown: true,
                        enablePullUp: true,
                        controller: context
                            .read<ViewNotificationBloc>()
                            .refreshController,
                        child: state is GetNotificationState ||
                                state is NotificationSuccessfulState
                            ? ListView.separated(
                                physics: const AlwaysScrollableScrollPhysics(),
                                padding: EdgeInsets.symmetric(horizontal: 2.w),
                                // gridDelegate:
                                //     SliverGridDelegateWithFixedCrossAxisCount(
                                //   crossAxisCount: 2,
                                //       // Number of items per row
                                //   childAspectRatio:
                                //       0.6, // Aspect ratio for grid items
                                //   crossAxisSpacing:
                                //       5, // Spacing between items horizontally
                                //   mainAxisSpacing:
                                //       10, // Spacing between items vertically
                                // ),
                                itemCount: context
                                    .read<ViewNotificationBloc>()
                                    .viewNotificationModel!
                                    .data!
                                    .notifications!
                                    .length,
                                itemBuilder: (context, index) {
                                  return NotificationCard(
                                      onPressed: () {
                                        context.read<ViewNotificationBloc>().add(
                                            DeleteNotificationEvent(index,
                                                notification: context
                                                    .read<ViewNotificationBloc>()
                                                    .viewNotificationModel!
                                                    .data!
                                                    .notifications![index],
                                                notificationNumber: context
                                                    .read<ViewNotificationBloc>()
                                                    .viewNotificationModel!
                                                    .data!
                                                    .notifications![index]
                                                    .id!));
                                        if (state
                                            is NotificationSuccessfulState) {
                                          setState(() {
                                            context
                                                .read<ViewNotificationBloc>()
                                                .viewNotificationModel!
                                                .data!
                                                .notifications!
                                                .removeAt(index);
                                          });
                                        }
                                      },
                                      index: index,
                                      notification: context
                                          .read<ViewNotificationBloc>()
                                          .viewNotificationModel!
                                          .data!
                                          .notifications![index]);
                                }, separatorBuilder: (BuildContext context, int index) {
                                  return Divider(height: 2.h,thickness: 0.3.h,color: AppColors.logoRed.withOpacity(0.3),);
                         },
                              )
                            : const Center(
                                child: CircularProgressIndicator(),
                              ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
