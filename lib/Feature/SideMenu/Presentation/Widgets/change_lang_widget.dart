import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:raghadcell/App/Bloc/app_language_bloc/app_language_bloc.dart';
import 'package:raghadcell/App/app_localizations.dart';
import 'package:raghadcell/Core/Constants/app_colors.dart';
import 'package:raghadcell/Core/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:raghadcell/Feature/Home/bloc/products_bloc/products_bloc.dart';
import 'package:raghadcell/Feature/SideMenu/blocs/profile_bloc/profile_bloc.dart';
import 'package:sizer/sizer.dart';

class ChangeLangWidget extends StatelessWidget {
  const ChangeLangWidget({super.key});

  @override
  Widget build(BuildContext context) {
    bool status = AppSharedPreferences.hasArLang;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
      child: Row(
        children: [
          Text(
            "Language".tr(context),
            style: TextStyle(
                color: AppColors.blackColor,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 4.w,
          ),
          BlocConsumer<AppLanguageBloc, LanguageState>(
            builder: (context, state) {
              if (state is LanguageLoadingState) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: AppColors.whiteColor,
                ));
              }
              return FlutterSwitch(
                width: 16.w,
                height: 4.h,
                valueFontSize: 10.sp,
                toggleSize: 4.w,
                value: status,
                borderRadius: 5.w,
                activeColor: AppColors.primaryColor,
                inactiveColor: AppColors.seconedaryColor,
                padding: 2.w,
                showOnOff: true,
                activeText: "AR",
                inactiveText: "EN",
                onToggle: (val) {
                  BlocProvider.of<ProductsBloc>(context).page = 1;
                  if (status) {
                    context.read<AppLanguageBloc>().add(ChangeLanguageToEn());
                  } else {
                    context.read<AppLanguageBloc>().add(ChangeLanguageToAr());
                  }
                },
              );
            },
            listener: (BuildContext context, LanguageState state) {

            },
          ),
        ],
      ),
    );
  }
}
