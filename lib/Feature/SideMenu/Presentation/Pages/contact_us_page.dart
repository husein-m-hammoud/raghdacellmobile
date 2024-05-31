import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raghadcell/App/app.dart';
import 'package:raghadcell/App/app_localizations.dart';
import 'package:raghadcell/Core/Constants/app_assets.dart';
import 'package:raghadcell/Core/Constants/app_colors.dart';
import 'package:raghadcell/Core/Widgets/coustom_button.dart';
import 'package:raghadcell/Core/Widgets/coustom_text_falid.dart';
import 'package:raghadcell/Core/Widgets/header_title_widget.dart';
import 'package:raghadcell/Feature/SideMenu/Presentation/Widgets/icon_text_in_border.dart';
import 'package:raghadcell/Feature/SideMenu/Presentation/Widgets/social_media_widget.dart';
import 'package:raghadcell/Feature/SideMenu/blocs/contact_us_bloc/bloc/contact_us_bloc.dart';
import 'package:sizer/sizer.dart';

class ContactUsPage extends StatelessWidget {
  ContactUsPage({super.key, required this.viewBackButton});
  final bool viewBackButton;

  final TextEditingController nameController = TextEditingController();

  final FocusNode nameNameNode = FocusNode();

  final TextEditingController phoneController = TextEditingController();

  final FocusNode phoneNameNode = FocusNode();

  final TextEditingController messageController = TextEditingController();

  final FocusNode messageNameNode = FocusNode();

  final GlobalKey<FormState> formKey = GlobalKey();
  final ContactUsBloc contactUsBloc = ContactUsBloc()
    ..add(GetContactUsInfoTextsEvent());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => contactUsBloc,
      child: BlocListener<ContactUsBloc, ContactUsState>(
          listener: (context, state) {
            if (state is SendMessageContactUsState) {
              if (state.loadingState && state.message == null) {
                // showLoaderDialog(context);
              }
              if (!state.loadingState && state.message == null) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.green,
                  duration: const Duration(seconds: 5),
                  content: Text(
                    "The Message Has been send successfully".tr(context),
                  ),
                ));
              }

              if (!state.loadingState && state.message != null) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    duration: const Duration(seconds: 5),
                    content: Text.rich(
                      TextSpan(children: [
                        TextSpan(text: state.message),
                        TextSpan(
                            text: 'Try Again'.tr(context),
                            style: TextStyle(fontSize: 10.sp),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                contactUsBloc.add(GetContactUsInfoTextsEvent());
                              })
                      ]),
                    )));
              }
            }
          },
          child: Scaffold(
            body: SafeArea(
              child: Column(children: [
                HeaderTitleWidget(
                  buttonBack: viewBackButton,
                  title: "Contact Us".tr(context),
                ),
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 1.h),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                controller: nameController,
                                textInputType: TextInputType.name,
                                isValidator: true,
                                fillColor: AppColors.whiteColor,
                                focusNode: nameNameNode,
                                hintText: "Name".tr(context),
                                validatorMessage:
                                    "Please enter your name".tr(context),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              CustomTextField(
                                controller: phoneController,
                                textInputType: TextInputType.phone,
                                isValidator: true,
                                fillColor: AppColors.whiteColor,
                                focusNode: phoneNameNode,
                                hintText: "Phone".tr(context),
                                validatorMessage:
                                    "Please enter your phone".tr(context),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              CustomTextField(
                                controller: messageController,
                                textInputType: TextInputType.text,
                                isValidator: true,
                                maxLine: 5,
                                fillColor: AppColors.whiteColor,
                                focusNode: messageNameNode,
                                hintText: "Message".tr(context),
                                validatorMessage:
                                    "Please enter your message".tr(context),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              ContactUsButton(
                                  formKey: formKey,
                                  messageController: messageController,
                                  nameController: nameController,
                                  phoneController: phoneController)
                            ],
                          ),
                        ),
                      ),
                      BlocBuilder<ContactUsBloc, ContactUsState>(
                        builder: (context, state) {
                          if (state is ContactUsInfoTextErrorState) {
                            return Center(
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(state.message!),
                                    TextButton(
                                        onPressed: () {
                                          contactUsBloc.add(ContactUsEvent());
                                        },
                                        child: Text(
                                          'Try Again'.tr(context),
                                          style: errorTryAgainStyle,
                                        ))
                                  ]),
                            );
                          }
                          if (state is GetContactUsInfoTextState &&
                                  state is SendMessageContactUsState ||
                              state is GetContactUsInfoTextState) {
                            return IconTextInBorder(
                                icon: AppAssets.messageIcon,
                                text:
                                    state.contactUsInfoTextModel.data!.email!);
                          } else if (state is ContactUsInfoTextLoadingState) {
                            return const Text("Loading...");
                          } else {
                            return Text("another state + $state");
                          }
                        },
                      ),
                      BlocBuilder<ContactUsBloc, ContactUsState>(
                        builder: (context, state) {
                          if (state is ContactUsInfoTextErrorState) {
                            return Text(state.message!);
                          } else if (state is GetContactUsInfoTextState) {
                            return Row(
                              children: [
                                Expanded(
                                  child: IconTextInBorder(
                                      icon: AppAssets.phoneIcon,
                                      text: state.contactUsInfoTextModel.data!
                                          .firstPhoneNumber!),
                                ),
                                Expanded(
                                  child: IconTextInBorder(
                                      text: state.contactUsInfoTextModel.data!
                                          .secondPhoneNumber!),
                                ),
                              ],
                            );
                          } else if (state is ContactUsInfoTextLoadingState) {
                            return const Text("Loading...");
                          } else {
                            return Text("another state + $state");
                          }
                        },
                      ),
                      SocialMediaWidget()
                    ],
                  ),
                )
              ]),
            ),
          )),
    );
  }
}

class ContactUsButton extends StatelessWidget {
  ContactUsButton({
    super.key,
    required this.formKey,
    required this.messageController,
    required this.nameController,
    required this.phoneController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController messageController;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final ContactUsBloc contactUsBloc = ContactUsBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => contactUsBloc,
      child: BlocConsumer<ContactUsBloc, ContactUsState>(
        listener: (context, state) {
          if (state is SendMessageContactUsState) {
            if (state.loadingState && state.message == null) {
              // showLoaderDialog(context);
            }
            if (!state.loadingState && state.message == null) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 5),
                content: Text(
                  "The Message Has been send successfully".tr(context),
                ),
              ));
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
          return BlocBuilder<ContactUsBloc, ContactUsState>(
            builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                child: state is SendMessageContactUsState && state.loadingState
                    ? const Center(child: CircularProgressIndicator())
                    : CoustomButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            contactUsBloc.add(SendMessageEvent(
                                message: messageController.text.trim(),
                                name: nameController.text.trim(),
                                phone: phoneController.text.trim()));
                          }
                        },
                        buttonText: "Send".tr(context)),
              );
            },
          );
        },
      ),
    );
  }
}
