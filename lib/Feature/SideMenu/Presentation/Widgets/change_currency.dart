import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:load_switch/load_switch.dart';
import 'package:raghadcell/App/Bloc/bloc/app_currency_bloc.dart';
import 'package:raghadcell/App/app.dart';
import 'package:raghadcell/App/app_localizations.dart';
import 'package:raghadcell/Core/Constants/app_colors.dart';
import 'package:raghadcell/Core/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:raghadcell/Feature/Home/bloc/products_bloc/products_bloc.dart';
import 'package:raghadcell/Feature/SideMenu/blocs/profile_bloc/profile_bloc.dart';
import 'package:sizer/sizer.dart';

class ChangeCurrencyWidget extends StatefulWidget {
  const ChangeCurrencyWidget({
    super.key,
  });

  @override
  State<ChangeCurrencyWidget> createState() => _ChangeCurrencyWidgetState();
}

class _ChangeCurrencyWidgetState extends State<ChangeCurrencyWidget> {
  bool value = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCurrencyBloc, AppCurrencyState>(
      listener: (context, state) {
        if (state is ChangeCurrency) {
          String prevCurrency = AppSharedPreferences.isUSD ? "LBP" : "USD";
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
            content: Text(
              AppSharedPreferences.hasArLang
                  ? " تم تغيير العملة بنجاح من ${prevCurrency.tr(context)} الى ${AppSharedPreferences.getCurrency.tr(context)}"
                  : "The Currency $prevCurrency Has Been Changed Successfully to ${AppSharedPreferences.getCurrency}",
            ),
          ));

          BlocProvider.of<ProfileBloc>(context).add(ProfileEvent());
          BlocProvider.of<ProductsBloc>(context).add(GetProductsEvent());
          BlocProvider.of<ProductsBloc>(context).page = 1;
        } else if (state is AppCurrencyErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              // duration: const Duration(seconds: 5),
              content: Center(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(state.message),
                      TextButton(
                          onPressed: () {
                            if (AppSharedPreferences.isUSD) {
                              context
                                  .read<AppCurrencyBloc>()
                                  .add(ChangeCurrencyToLBPEvent());
                            } else {
                              context
                                  .read<AppCurrencyBloc>()
                                  .add(ChangeCurrencyToUSDEvent());
                            }
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
        bool status = AppSharedPreferences.isUSD;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          child: Row(
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "LBP",
                style: TextStyle(
                    color: AppColors.logoRed,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp),
              ),
              SizedBox(
                width: 2.w,
              ),
              LoadSwitch(
                isLoading: state is LoadingState,
                width: 8.w,
                height: 2.h,
                value: status,
                future: () async {
                  // await Future.delayed(Duration(seconds: 2));
                  return status;
                },
                style: SpinStyle.circle,
                curveIn: Curves.easeInBack,
                curveOut: Curves.easeOutBack,
                animationDuration: const Duration(milliseconds: 500),
                switchDecoration: (value, val) => BoxDecoration(
                  color: const Color.fromARGB(88, 193, 17, 17),
                  borderRadius: BorderRadius.circular(30),
                  shape: BoxShape.rectangle,
                ),
                spinColor: (value) => value
                    ? const Color.fromARGB(255, 31, 65, 232)
                    : const Color.fromARGB(255, 255, 77, 77),
                spinStrokeWidth: 3,
                thumbDecoration: (value, val) => BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  shape: BoxShape.rectangle,
                ),
                onChange: (v) {},
                onTap: (v) {
                  if (status) {
                    context
                        .read<AppCurrencyBloc>()
                        .add(ChangeCurrencyToLBPEvent());
                  } else {
                    context
                        .read<AppCurrencyBloc>()
                        .add(ChangeCurrencyToUSDEvent());
                  }
                },
              ),
              SizedBox(
                width: 2.w,
              ),
              Text(
                "USD",
                style: TextStyle(
                    color: AppColors.logoRed,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp
                    ),
              ),

              // Switch(
              //   inactiveTrackColor: AppColors.myRed,
              //   activeTrackColor: Colors.blue,
              //   inactiveThumbColor: AppColors.seconedaryColor,
              //   activeColor: Colors.blue,
              //   value: status,
              //   onChanged: (value) {
              //     if (status) {
              //       context
              //           .read<AppCurrencyBloc>()
              //           .add(ChangeCurrencyToLBPEvent());
              //     } else {
              //       context
              //           .read<AppCurrencyBloc>()
              //           .add(ChangeCurrencyToUSDEvent());
              //     }
              //   },
              // ),
              // FlutterSwitch(
              //   width: 16.w,
              //   height: 4.h,
              //   valueFontSize: 10.sp,
              //   toggleSize: 4.w,
              //   value: status,
              //   borderRadius: 5.w,
              //   activeColor: AppColors.primaryColor,
              //   inactiveColor: AppColors.seconedaryColor,
              //   padding: 2.w,
              //   showOnOff: true,
              //   activeText: "USD",
              //   inactiveText: "LBP",
              //   onToggle: (val) {
              //     if (status) {
              //       context
              //           .read<AppCurrencyBloc>()
              //           .add(ChangeCurrencyToLBPEvent());
              //     } else {
              //       context
              //           .read<AppCurrencyBloc>()
              //           .add(ChangeCurrencyToUSDEvent());
              //     }
              //   },
              // ),
            ],
          ),
        );
      },
    );
  }
}
