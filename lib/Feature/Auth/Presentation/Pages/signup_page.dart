// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:raghadcell/App/app_localizations.dart';

import 'package:raghadcell/Core/Constants/app_colors.dart';

import 'package:raghadcell/Core/Widgets/coustom_button.dart';
import 'package:raghadcell/Feature/Auth/Bloc/register_bloc/register_bloc.dart';
import 'package:raghadcell/Feature/Auth/Presentation/Pages/signin_page.dart';
import 'package:raghadcell/Feature/Auth/Presentation/Pages/verification_code_page.dart';
import 'package:raghadcell/Feature/Auth/Presentation/Widgets/rigester_header_widget.dart';
import 'package:raghadcell/Core/Widgets/text_falid_with_title_widget.dart';
import 'package:sizer/sizer.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController userNameController = TextEditingController();

  final FocusNode userNameNode = FocusNode();

  final TextEditingController passwordController = TextEditingController();

  final FocusNode passwordNode = FocusNode();

  final PhoneController phoneController = PhoneController(
    PhoneNumber.parse('+961'),
  );

  final FocusNode phoneNode = FocusNode();

  final TextEditingController emailController = TextEditingController();

  final FocusNode emailNode = FocusNode();

  final GlobalKey<FormState> formKey = GlobalKey();

  // final RegisterBloc registerBloc = RegisterBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterStates>(
      listener: (context, state) {
        if (state is AuthState) {
          if (state.loadingState && state.message == null) {
            // showLoaderDialog(context);
          }
          if (!state.loadingState && state.message == null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 5),
              content: Text(
                "Sign Up successfully".tr(context),
              ),
            ));
            Navigator.of(context).push(
              PageTransition(
                  child: VerificationCodePage(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                    userName: userNameController.text.trim(),
                    phone:
                        "+${phoneController.value!.countryCode}${phoneController.value!.nsn}"
                            .trim(),
                  ),
                  type: PageTransitionType.rightToLeft,
                  duration: const Duration(milliseconds: 400)),
            );
          }

          if (!state.loadingState && state.message != null) {
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
                      child: Form(
          key: formKey,
          child: Column(
            children: [
              RigesterHeaderWidget(title: "Sign Up".tr(context)),
              SizedBox(
                height: 2.h,
              ),
              Expanded(
                child: Center(
                  child: ListView(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    shrinkWrap: true,
                    children: [
                      TextFalidWithTilteWidget(
                          validator: (p0) {
                            if (p0!.isEmpty) {
                              return "Please Enter Your Email".tr(context);
                            }
                            return null;
                          },
                          isValidator: true,
                          title: "Email".tr(context),
                          hintText:
                              "${"Enter Your".tr(context)} ${"Email".tr(context)}",
                          textInputType: TextInputType.emailAddress,
                          focusNode: emailNode,
                          controller: emailController),
                      TextFalidWithTilteWidget(
                          validator: (p0) {
                            if (p0!.isEmpty) {
                              return "Please Enter Your User Name"
                                  .tr(context);
                            }
                            return null;
                          },
                          title: "User Name".tr(context),
                          hintText:
                              "${"Enter Your".tr(context)} ${"User Name".tr(context)}",
                          textInputType: TextInputType.emailAddress,
                          isValidator: true,
                          focusNode: userNameNode,
                          controller: userNameController),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.w, vertical: 1.h),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2.w, vertical: 1.h),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    "Phone".tr(context),
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        color: AppColors.blackColor),
                                  ))
                                ],
                              ),
                            ),
                            PhoneFormField(
                                controller: phoneController,
                                // focusNode: userNameNode,
                                decoration: InputDecoration(
                                  // filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 1.2.h, horizontal: 2.5.w),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(2.w),
                                      borderSide: const BorderSide(
                                          color: AppColors.borderColor,
                                          width: 1)),
                                ),
                                // or use the controller
                                validator: PhoneValidator.compose([
                                  PhoneValidator.required(),
                                  PhoneValidator.validMobile(),
                                ]),
                                // countrySelectorNavigator: const CountrySelectorNavigator.page(),
                                onChanged: (phoneNumber) => print(
                                    "+${phoneController.value!.countryCode}${phoneController.value!.nsn}"),
                                enabled: true,
                                isCountrySelectionEnabled: false,
                                showDialCode: true,
                                showIsoCodeInInput: true,
                                showFlagInInput: true,
                                flagSize: 16),
                          ],
                        ),
                      ),
                      TextFalidWithTilteWidget(
                          validator: (p0) {
                            if (p0!.isEmpty) {
                              return "Please Enter Your Password"
                                  .tr(context);
                            }
                            return null;
                          },
                          title: "Password".tr(context),
                          hintText:
                              "${"Enter Your".tr(context)} ${"Password".tr(context)}",
                          textInputType: TextInputType.visiblePassword,
                          isValidator: true,
                          isPassword: true,
                          focusNode: passwordNode,
                          controller: passwordController),
                      SizedBox(
                        height: 4.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.w),
                        child: state is AuthState && state.loadingState
                            ? const Center(
                                child: CircularProgressIndicator())
                            : CoustomButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    context.read<RegisterBloc>().add(
                                            CheckVerificationCodeAndSignUpEvent(
                                          password: passwordController.text
                                              .trim(),
                                          phone:
                                              "+${phoneController.value!.countryCode}${phoneController.value!.nsn}"
                                                  .trim(),
                                          username: userNameController.text
                                              .trim(),
                                          email:
                                              emailController.text.trim(),
                                        ));
                                  }
                                },
                                buttonText: "Sign Up".tr(context),
                              ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "You have an account?".tr(context),
                            style: TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 10.sp,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                PageTransition(
                                    child: SignInPage(),
                                    type: PageTransitionType.rightToLeft,
                                    duration:
                                        const Duration(milliseconds: 400)),
                                (route) => false,
                              );
                            },
                            child: Text(
                              "Sign In".tr(context),
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.primaryColor,
                                color: AppColors.primaryColor,
                                fontSize: 10.sp,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
                      ),
                    ),
        );
      },
    );
  }
}
