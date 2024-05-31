import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raghadcell/App/app.dart';
import 'package:raghadcell/App/app_localizations.dart';
import 'package:raghadcell/Core/Constants/app_colors.dart';
import 'package:raghadcell/Core/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:raghadcell/Core/function/functions.dart';
import 'package:raghadcell/Feature/SideMenu/blocs/profile_bloc/profile_bloc.dart';
import 'package:sizer/sizer.dart';

class ShowBalanceWidget extends StatelessWidget {
  const ShowBalanceWidget({super.key, required this.isDrawer});
  final bool isDrawer;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileErrorState) {
          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //   backgroundColor: Colors.red,
          //   duration: const Duration(seconds: 5),
          //   content: Text(
          //     state.message!,
          //   ),
          // ));
          return Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(state.message!),
                  TextButton(
                      onPressed: () {
                        context.read<ProfileBloc>().add(ProfileEvent());
                      },
                      child: Text(
                        'Try Again'.tr(context),
                        style: errorTryAgainStyle,
                      ))
                ]),
          );
        }
        if (state is GetProfileState) {
          return Container(
              // width: 50.w,
              margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Balance : ".tr(context),
                    style: TextStyle(
                        color: isDrawer ? Colors.black : AppColors.logoRed,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w900),
                  ),
                  SizedBox(width: 1.w),
                  Builder(builder: (context) {
                    return Text(
                      formatNumber(context
                          .read<ProfileBloc>()
                          .profileModel!
                          .data!
                          .balance),
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          color: isDrawer ? Colors.white : AppColors.blackColor,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w900),
                    );
                  })
                ],
              ));
        } else {
          return Container(
              margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
              child: Text("Loading...".tr(context)));
        }
      },
    );
  }
}
