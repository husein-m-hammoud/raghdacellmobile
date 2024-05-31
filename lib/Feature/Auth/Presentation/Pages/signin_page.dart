// ignore_for_file: must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:raghadcell/App/app_localizations.dart';

import 'package:raghadcell/Core/Constants/app_colors.dart';

import 'package:raghadcell/Core/Widgets/coustom_button.dart';
import 'package:raghadcell/Core/Widgets/coustom_text_falid.dart';
import 'package:raghadcell/Feature/Auth/Bloc/register_bloc/register_bloc.dart';
import 'package:raghadcell/Feature/Auth/Presentation/Pages/send_email_page.dart';
import 'package:raghadcell/Feature/Auth/Presentation/Pages/signup_page.dart';
import 'package:raghadcell/Feature/Auth/Presentation/Pages/verification_code_page.dart';
import 'package:raghadcell/Feature/Auth/Presentation/Widgets/rigester_header_widget.dart';
import 'package:raghadcell/Core/Widgets/text_falid_with_title_widget.dart';
import 'package:sizer/sizer.dart';

class SignInPage extends StatefulWidget {
  SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController userNameController = TextEditingController();

  final FocusNode userNameNode = FocusNode();

  final TextEditingController passwordController = TextEditingController();

  final FocusNode passwordNode = FocusNode();

  final GlobalKey<FormState> formKey = GlobalKey();

  // final RegisterBloc registerBloc = RegisterBloc();
  bool isUserName = false;

  final PhoneController phoneController = PhoneController(
    PhoneNumber.parse('+961'),
  );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterStates>(
      listener: (context, state) {
        if (state is AuthState) {
          if (state.loadingState && state.message == null) {}
          if (!state.loadingState && state.message == null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 5),
              content: Text(
                "Login Successfully".tr(context),
              ),
            ));

            Navigator.of(context).pushAndRemoveUntil(
              PageTransition(
                  child: VerificationCodePage(
                    userName: userNameController.text.trim(),
                    phone: !isUserName
                        ? "+${phoneController.value!.countryCode}${phoneController.value!.nsn}"
                            .trim()
                        : "",
                    password: passwordController.text.trim(),
                  ),
                  type: PageTransitionType.rightToLeft,
                  duration: const Duration(milliseconds: 400)),
              (route) => false,
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
          child: ListView(
            children: [
              RigesterHeaderWidget(title: "Sign In".tr(context)),
              SizedBox(
                height: 2.h,
              ),
              Center(
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  // const BouncingScrollPhysics(
                  //     parent: AlwaysScrollableScrollPhysics()),
                  shrinkWrap: true,
                  children: [
                    BlocBuilder<RegisterBloc, RegisterStates>(
                      builder: (context, state) {
                        return Padding(
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
                                     isUserName?"User Name".tr(context): "Phone".tr(context),
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: AppColors.blackColor),
                                    )),
                                    CoustomButton(
                                      size: 10,
                                      onPressed: () {
                                        isUserName = !isUserName;
                                        context.read<RegisterBloc>().add(
                                            UserNameOrPhoneNumber(
                                                isUserName: isUserName));
                                      },
                                      buttonText: context
                                              .read<RegisterBloc>()
                                              .isUserName
                                          ? "User Name".tr(context)
                                          : "Phone".tr(context),
                                    )
                                  ],
                                ),
                              ),
                              context.read<RegisterBloc>().isUserName
                                  ? CustomTextField(
                                      validator: (p0) {
                                        if (p0!.isEmpty) {
                                          return "Please Enter User Name or Phone"
                                              .tr(context);
                                        }
                                        return null;
                                      },
                                      controller: userNameController,
                                      textInputType:
                                          TextInputType.emailAddress,
                                      isValidator: true,
                                      focusNode: userNameNode,
                                      hintText:
                                          "${"Enter Your".tr(context)} ${"User Name or Phone".tr(context)}",
                                    )
                                  : PhoneFormField(
                                      controller: phoneController,
                                      focusNode: userNameNode,
                                      decoration: InputDecoration(
                                        // filled: true,
                                        fillColor: Colors.white,
                                        contentPadding:
                                            EdgeInsets.symmetric(
                                                vertical: 1.2.h,
                                                horizontal: 2.5.w),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2.w),
                                            borderSide: const BorderSide(
                                                color:
                                                    AppColors.borderColor,
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
                                      isCountrySelectionEnabled: true,
                                      showDialCode: true,
                                      showIsoCodeInInput: true,
                                      showFlagInInput: true,
                                      flagSize: 16)
                            ],
                          ),
                        );
                      },
                    ),
                    TextFalidWithTilteWidget(
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return "Please Enter Your Password".tr(context);
                          }
                          return null;
                        },
                        title: "Password".tr(context),
                        hintText:
                            "${"Enter Your".tr(context)} ${"Password".tr(context)}",
                        textInputType: TextInputType.visiblePassword,
                        isPassword: true,
                        focusNode: passwordNode,
                        controller: passwordController),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              // Transform.scale(
                              //   scale: 1.5,
                              //   child: Checkbox(
                              //       value: context
                              //           .read<RegisterBloc>()
                              //           .checkBoxValue,
                              //       activeColor: AppColors.primaryColor,
                              //       shape: RoundedRectangleBorder(
                              //           borderRadius:
                              //               BorderRadius.circular(1.w)),
                              //       onChanged: (value) {
                              //         context.read<RegisterBloc>().add(
                              //             ToggleCheckBox(value: value!));
                              //       }),
                              // ),
                              // Text(
                              //   "Remember Me".tr(context),
                              //   style: TextStyle(
                              //     color: AppColors.borderColor,
                              //     fontSize: 10.sp,
                              //   ),
                              // )
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                PageTransition(
                                    child: SendEmailPage(),
                                    type: PageTransitionType.rightToLeft,
                                    duration:
                                        const Duration(milliseconds: 400)),
                              );
                            },
                            child: Text(
                              "Forget Password?".tr(context),
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
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.w),
                        child: state is AuthState && state.loadingState
                            ? const Center(
                                child: CircularProgressIndicator())
                            : CoustomButton(
                                fontWeight: null,
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    context
                                        .read<RegisterBloc>()
                                        .add(CheckVerifiCodeAndLoginEvent(
                                          userName: userNameController.text
                                              .trim(),
                                          phone: !isUserName
                                              ? "+${phoneController.value!.countryCode}${phoneController.value!.nsn}"
                                                  .trim()
                                              : "",
                                          password: passwordController.text,
                                        ));
                                  }
                                },
                                buttonText: "Sign In".tr(context),
                              )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account ? ".tr(context),
                          style: TextStyle(
                            color: AppColors.blackColor,
                            fontSize: 10.sp,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              PageTransition(
                                  child: SignUpPage(),
                                  type: PageTransitionType.rightToLeft,
                                  duration:
                                      const Duration(milliseconds: 400)),
                            );
                          },
                          child: Text(
                            "Create an account".tr(context),
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
            ],
          ),
                      ),
                    ),
        );
      },
    );
  }
}
