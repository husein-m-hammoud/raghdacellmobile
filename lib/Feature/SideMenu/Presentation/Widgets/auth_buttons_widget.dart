import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:raghadcell/App/app.dart';
import 'package:raghadcell/App/app_localizations.dart';
import 'package:raghadcell/Core/Constants/app_colors.dart';
import 'package:raghadcell/Core/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:raghadcell/Core/Widgets/coustom_button.dart';
import 'package:raghadcell/Feature/Auth/Presentation/Pages/signin_page.dart';
import 'package:raghadcell/Feature/Auth/Presentation/Pages/signup_page.dart';
import 'package:raghadcell/Feature/Splash/splash_screen.dart';
import 'package:sizer/sizer.dart';

class AuthButtonWidget extends StatelessWidget {
  const AuthButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSharedPreferences.hasToken
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: SizedBox(
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.w),
                      color: Color(0xff1e40af)),
                  child: MaterialButton(
                    // height: hieght,

                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.w)),
                    // color: buttonColor,
                    onPressed: () {
                      AppSharedPreferences.removeToken();
                      navigatorKey.currentState!.pushAndRemoveUntil(
                        PageTransition(
                            child: const SplashScreen(),
                            type: PageTransitionType.rightToLeft,
                            duration: const Duration(milliseconds: 400)),
                        (route) => false,
                      );
                    },
                    child: Text(
                      "Log Out".tr(context),
                      style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 16!.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
          )
        : Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: SizedBox(
                  width: double.infinity,
                  child: CoustomButton(
                      onPressed: () {
                        navigatorKey.currentState!.push(
                          PageTransition(
                              child: SignInPage(),
                              type: PageTransitionType.rightToLeft,
                              duration: const Duration(milliseconds: 400)),
                        );
                      },
                      buttonText: "Sign In".tr(context)),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: SizedBox(
                  width: double.infinity,
                  child: CoustomButton(
                      onPressed: () {
                        navigatorKey.currentState!.push(
                          PageTransition(
                              child: SignUpPage(),
                              type: PageTransitionType.rightToLeft,
                              duration: const Duration(milliseconds: 400)),
                        );
                      },
                      buttonText: "Sign Up".tr(context)),
                ),
              )
            ],
          );
  }
}
