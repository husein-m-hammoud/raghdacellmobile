import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raghadcell/App/app.dart';
import 'package:raghadcell/App/app_localizations.dart';
import 'package:raghadcell/Core/Constants/app_assets.dart';
import 'package:raghadcell/Core/Constants/app_colors.dart';
import 'package:raghadcell/Feature/SideMenu/blocs/profile_bloc/profile_bloc.dart';
import 'package:sizer/sizer.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: Row(
        children: [
          // InkWell(
          //   onTap: () {
          //     // navigatorKey.currentState!.push(MaterialPageRoute(
          //     //     builder: (_) => const ViewImagesWidget(
          //     //           image: AppAssets.userIcon,
          //     //         )));
          //   },
          //   child:
          CircleAvatar(
            backgroundImage: const AssetImage(AppAssets.userIcon),
            radius: 8.w,
          ),
          // ),
          SizedBox(
            width: 2.w,
          ),
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileErrorState) {
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
              } else if (state is GetProfileState) {
                return Text(
                  "${"Welcome".tr(context)} ${state.profileModel.data!.username}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor),
                );
              } else {
                return const Text("Loading...");
              }
            },
          ),
        ],
      ),
    );
  }
}
