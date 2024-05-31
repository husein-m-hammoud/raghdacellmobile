import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:raghadcell/App/Bloc/scroll_bloc/scroll_bloc.dart';
import 'package:raghadcell/App/app.dart';
import 'package:raghadcell/Core/Constants/app_assets.dart';
import 'package:raghadcell/Core/Util/SharedPreferences/SharedPreferencesHelper.dart';

import 'package:raghadcell/Feature/notification/presentation/pages/view_notification_page.dart';

import 'package:sizer/sizer.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScrollBloc, ScrollListener>(
      builder: (context, state) {
        return SafeArea(
          child: AppBar(
            leading: IconButton(
              color: Colors.white,
              padding: EdgeInsets.all(2.w),
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
            actions: [
              AppSharedPreferences.hasToken
                  ? IconButton(
                      icon: Icon(
                        color: Colors.amber,
                        Icons.notifications,
                        size: 25.sp,
                      ),
                      onPressed: () {
                        navigatorKey.currentState!.push(
                          PageTransition(
                              child: const ViewNotificationPage(
                                viewBackButton: true,
                              ),
                              type: PageTransitionType.leftToRightWithFade,
                              duration: const Duration(milliseconds: 400)),
                        );
                      },
                    )
                  : const SizedBox(),
            ],
            title: Image.asset(
              AppAssets.logoImage2,
              height: 8.h,
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
        );
      },
    );
  }
}
