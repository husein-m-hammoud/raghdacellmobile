import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raghadcell/App/app.dart';
import 'package:raghadcell/App/app_localizations.dart';

import 'package:raghadcell/Core/Constants/app_colors.dart';

import 'package:raghadcell/Feature/SideMenu/Presentation/Widgets/show_balance_widget.dart';
import 'package:raghadcell/Feature/SideMenu/blocs/profile_bloc/profile_bloc.dart';
import 'package:sizer/sizer.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

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
          return Column(
            children: [
              Text(
                state.profileModel.data!.username!,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w900,
                    color: AppColors.whiteColor),
              ),
              const ShowBalanceWidget(
                isDrawer: true,
              ),
              // if (AppSharedPreferences.hasToken)   ChangeCurrencyWidget(context: context,),
            ],
          );
        } else {
          return const Text("Loading...");
        }
      },
    );
  }
}
