import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:raghadcell/App/app_localizations.dart';

import 'package:raghadcell/Core/Widgets/coustom_button.dart';
import 'package:raghadcell/Feature/Auth/Bloc/register_bloc/register_bloc.dart';
import 'package:raghadcell/Feature/Auth/Presentation/Pages/verification_code_page.dart';
import 'package:raghadcell/Feature/Auth/Presentation/Widgets/rigester_header_widget.dart';
import 'package:raghadcell/Core/Widgets/text_falid_with_title_widget.dart';
import 'package:sizer/sizer.dart';

class SendEmailPage extends StatelessWidget {
  SendEmailPage({super.key});

  final TextEditingController emailController = TextEditingController();

  final FocusNode emailNode = FocusNode();

  final GlobalKey<FormState> formKey = GlobalKey();
  // final RegisterBloc registerBloc = RegisterBloc();

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
            Navigator.of(context).push(
              PageTransition(
                  child: VerificationCodePage(email: emailController.text),
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
              RigesterHeaderWidget(
                title: "Enter your Email".tr(context),
                // subTitle: "",
              ),
              Center(
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
                        title: "Email".tr(context),
                        hintText: "Enter your Email".tr(context),
                        textInputType: TextInputType.emailAddress,
                        isValidator: true,
                        focusNode: emailNode,
                        controller: emailController),
                    SizedBox(
                      height: 4.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      child: state is AuthState && state.loadingState
                          ? const Center(child: CircularProgressIndicator())
                          : CoustomButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  context.read<RegisterBloc>().add(
                                      CheckVerifiCodeAndEmailForForgetPasswordEvent(
                                          email:
                                              emailController.text.trim()));
                                }
                              },
                              buttonText: "Next".tr(context),
                            ),
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
