import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:raghadcell/App/app_localizations.dart';

import 'package:raghadcell/Core/Widgets/coustom_button.dart';
import 'package:raghadcell/Feature/Auth/Bloc/register_bloc/register_bloc.dart';
import 'package:raghadcell/Feature/Auth/Presentation/Pages/signin_page.dart';
import 'package:raghadcell/Feature/Auth/Presentation/Widgets/rigester_header_widget.dart';
import 'package:raghadcell/Core/Widgets/text_falid_with_title_widget.dart';
import 'package:sizer/sizer.dart';

class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage(
      {super.key, required this.email, required this.verificode});

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final FocusNode confirmPasswordNode = FocusNode();

  final TextEditingController passwordController = TextEditingController();

  final FocusNode passwordNode = FocusNode();

  final GlobalKey<FormState> formKey = GlobalKey();
  // final RegisterBloc registerBloc = RegisterBloc();
  final String email;
  final String verificode;

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
                "password changed successfully".tr(context),
              ),
            ));
            Navigator.of(context).pushAndRemoveUntil(
              PageTransition(
                  child: SignInPage(),
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
              child: Column(
                children: [
                  const RigesterHeaderWidget(
                    title: "",
                    // subTitle: "",
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
                                  "Please Enter Your Password".tr(context);
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
                          TextFalidWithTilteWidget(
                              validator: (p0) {
                                if (p0!.isEmpty) {
                                  "Please Enter your Confirm Password"
                                      .tr(context);
                                }
                                return null;
                              },
                              title: "Confirm Password".tr(context),
                              hintText:
                                  "${"Enter Your".tr(context)} ${"Confirm Password".tr(context)}",
                              isPassword: true,
                              textInputType: TextInputType.visiblePassword,
                              isValidator: true,
                              focusNode: confirmPasswordNode,
                              controller: confirmPasswordController),
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
                                      if (formKey.currentState!
                                          .validate()) {
                                        context.read<RegisterBloc>().add(
                                            ResetPasswordEvent(
                                                verificode: verificode,
                                                email: email,
                                                confirmPassword:
                                                    confirmPasswordController
                                                        .text
                                                        .trim(),
                                                password: passwordController
                                                    .text
                                                    .trim()));
                                      }
                                    },
                                    buttonText: "Save".tr(context),
                                  ),
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
