import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:page_transition/page_transition.dart';
import 'package:raghadcell/App/app_localizations.dart';
import 'package:raghadcell/Core/Constants/app_colors.dart';
import 'package:raghadcell/Core/Widgets/coustom_button.dart';
import 'package:raghadcell/Feature/Auth/Bloc/register_bloc/register_bloc.dart';
import 'package:raghadcell/Feature/Auth/Presentation/Pages/change_password_page.dart';
import 'package:raghadcell/Feature/Auth/Presentation/Widgets/rigester_header_widget.dart';
import 'package:raghadcell/Feature/Home/Presentation/Pages/home_page.dart';
import 'package:raghadcell/Feature/Splash/splash_screen.dart';
import 'package:sizer/sizer.dart';

class VerificationCodePage extends StatefulWidget {
  final String email;
  final String password;
  final String phone;
  final String userName;
  const VerificationCodePage(
      {this.email = "",
      super.key,
      this.password = "",
      this.phone = "",
      this.userName = ""});

  @override
  State<VerificationCodePage> createState() => _VerificationCodePageState();
}

class _VerificationCodePageState extends State<VerificationCodePage> {
  bool _onEditing = true;
  String? code = "";
  // final RegisterBloc registerBloc = RegisterBloc();
  late bool isResetPassword = widget.email != "" &&
      widget.password == "" &&
      widget.phone == "" &&
      widget.userName == "";

  @override
  build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterStates>(
      listener: (context, state) {
        if (state is AuthState) {
          if (state.loadingState && state.message == null) {
          } else if (!state.loadingState && state.message == null) {
            //resetpassword
            if (widget.email != "" &&
                widget.password == "" &&
                widget.phone == "" &&
                widget.userName == "") {
              Navigator.of(context).pushAndRemoveUntil(
                PageTransition(
                    child: ChangePasswordPage(
                      email: widget.email,
                      verificode: code!,
                    ),
                    type: PageTransitionType.rightToLeft,
                    duration: const Duration(milliseconds: 400)),
                (route) => false,
              );
            }
            //signup
            else if (widget.email != "" &&
                widget.password != "" &&
                widget.phone != "" &&
                widget.userName != "") {
              Navigator.of(context).pushAndRemoveUntil(
                PageTransition(
                    child: const SplashScreen(),
                    type: PageTransitionType.rightToLeft,
                    duration: const Duration(milliseconds: 400)),
                (route) => false,
              );
            }
            //login
            else if (widget.email == "" &&
                    widget.password != "" &&
                    widget.phone != "" ||
                widget.userName != "") {
              Navigator.of(context).pushAndRemoveUntil(
                PageTransition(
                    child: const SplashScreen(),
                    type: PageTransitionType.rightToLeft,
                    duration: const Duration(milliseconds: 400)),
                (route) => false,
              );
            }
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 5),
              content: Text(
                "verification successfully".tr(context),
              ),
            ));
          } else if (!state.loadingState && state.message != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 5),
              content: Text(
                state.message!,
              ),
            ));
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                RigesterHeaderWidget(
                  title: "Verification Code".tr(context),
                  subTitle:
                      "${"We have sent a verification code to your ".tr(context)} ${isResetPassword ? "WhatsApp Account".tr(context) : "email".tr(context)}",
                ),
                Expanded(
                  child: ListView(

                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    children: [
                      Center(
                        child: VerificationCode(
                          fullBorder: true,
                          textStyle:
                              const TextStyle(color: AppColors.primaryColor),
                          keyboardType: TextInputType.number,
                          underlineColor: AppColors.primaryColor,
                          length: 4,
                          cursorColor: AppColors.primaryColor,
                          margin: const EdgeInsets.all(12),
                          onCompleted: (String value) {
                            setState(() {
                              code = value;
                            });
                          },
                          onEditing: (bool value) {
                            setState(() {
                              _onEditing = value;
                            });
                            if (!_onEditing) {
                              FocusScope.of(context).unfocus();
                            }
                          },
                        ),
                      ),
                      Center(child: Text("whatsapp_code_hint".tr(context),
                        style:const TextStyle(fontWeight: FontWeight.bold,color: AppColors.logoRed),)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: _onEditing
                              ? Text('Please enter full code'.tr(context))
                              : Text('${"Your code:".tr(context)} $code'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.w, vertical: 3.h),
                        child: state is AuthState && state.loadingState
                            ? const Center(child: CircularProgressIndicator())
                            : CoustomButton(
                                onPressed: () {
                                  if (widget.email != "" &&
                                      widget.password == "" &&
                                      widget.phone == "" &&
                                      widget.userName == "") {
                                    context.read<RegisterBloc>().add(
                                        CheckVerifiCodeAndEmailForForgetPasswordEvent(
                                            email: widget.email,
                                            verifiCode: code!.trim() == ""
                                                ? code = "-1"
                                                : code!));
                                  }
                                  //signup
                                  else if (widget.email != "" &&
                                      widget.password != "" &&
                                      widget.phone != "" &&
                                      widget.userName != "") {
                                    context.read<RegisterBloc>().add(
                                        CheckVerificationCodeAndSignUpEvent(
                                            verificationCode: code!.trim() == ""
                                                ? code = "-1"
                                                : code!,
                                            email: widget.email,
                                            password: widget.password,
                                            phone: widget.phone,
                                            username: widget.userName));
                                  }
                                  //login
                                  else if (widget.email == "" &&
                                          widget.password != "" &&
                                          widget.phone != "" ||
                                      widget.userName != "") {
                                    context.read<RegisterBloc>().add(
                                        CheckVerifiCodeAndLoginEvent(
                                            password: widget.password,
                                            phone: widget.phone,
                                            userName: widget.userName,
                                            verificationCode: code!.trim() == ""
                                                ? code = "-1"
                                                : code!));
                                  }
                                },
                                buttonText: "verify".tr(context),
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
