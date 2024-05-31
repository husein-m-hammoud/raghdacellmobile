import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raghadcell/App/app.dart';
import 'package:raghadcell/App/app_localizations.dart';
import 'package:raghadcell/Core/Constants/app_colors.dart';
import 'package:raghadcell/Feature/notification/bloc/view_notification_bloc.dart';
import 'package:raghadcell/Feature/notification/models/view_notification_model.dart';
import 'package:sizer/sizer.dart';

class NotificationCard extends StatefulWidget {
  const NotificationCard(
      {super.key,
      required this.notification,
      required this.index,
      required this.onPressed});

  final Notifications notification;
  final int index;
  final Function() onPressed;

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  ViewNotificationBloc viewNotificationBloc = ViewNotificationBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ViewNotificationBloc, NotificationState>(
      listener: (context, state) {
        if (state is NotificationSuccessfulState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
            content: Text(
                "The Notification has been deleted successfully".tr(context)),
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
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Text(
                    widget.notification.description!,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),

                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 2.w),
                  child: Row(
                    children: [
                      Text(widget.notification.date.toString()),
                      SizedBox(
                        width: 2.w,
                      ),
                      Directionality(
                          textDirection: TextDirection.ltr,
                      child: Text(widget.notification.time.toString())),
                    ],
                  ),
                )


              ]),
            ),
            IconButton(
                onPressed: widget.onPressed,
                icon: const Icon(
                  Icons.delete_outlined,
                  color: Colors.grey,
                )),
          ],
        );
      },
    );
  }
}
