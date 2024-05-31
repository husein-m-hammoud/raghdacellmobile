import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raghadcell/App/app.dart';
import 'package:raghadcell/App/app_localizations.dart';
import 'package:raghadcell/Core/Constants/app_assets.dart';
import 'package:raghadcell/Core/Constants/app_colors.dart';
import 'package:raghadcell/Feature/SideMenu/blocs/contact_us_bloc/bloc/contact_us_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaWidget extends StatelessWidget {
  SocialMediaWidget({super.key});
  final ContactUsBloc contactUsBloc = ContactUsBloc()
    ..add(GetContactUsInfoTextsEvent());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => contactUsBloc,
      child: BlocBuilder<ContactUsBloc, ContactUsState>(
        builder: (context, state) {
          if (state is GetContactUsInfoTextState) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 3.h),
              margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                border: Border.all(color: AppColors.seconedaryColor),
                borderRadius: BorderRadius.circular(2.w),
              ),
              child: Row(
                children: [
                  // Expanded(
                  //   child: InkWell(

                  //     child: Container(
                  //       height: 5.h,
                  //       decoration: const BoxDecoration(
                  //           image: DecorationImage(
                  //               image: AssetImage(AppAssets.snapchatIcon))),
                  //     ),
                  //   ),
                  // ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                      launchUrl(Uri.parse(
                            state.contactUsInfoTextModel.data!.whatsapp!),mode: LaunchMode.externalApplication);
                      },
                      child: Container(
                        height: 5.h,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(AppAssets.whatsappIcon))),
                      ),
                    ),
                  ),
                  // Expanded(
                  //   child: Container(
                  //     height: 5.h,
                  //     decoration: const BoxDecoration(
                  //         image: DecorationImage(
                  //             image: AssetImage(AppAssets.twitterIcon))),
                  //   ),
                  // ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        launchUrl(Uri.parse(
                            state.contactUsInfoTextModel.data!.facebook!),mode: LaunchMode.externalApplication);
                      },
                      child: Container(
                        height: 5.h,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(AppAssets.facebookIcon))),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        launchUrl(Uri.parse(
                            state.contactUsInfoTextModel.data!.instagram!),mode: LaunchMode.externalApplication);
                      },
                      child: Container(
                        height: 5.h,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(AppAssets.instagramIcon))),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        launchUrl(Uri.parse(
                            state.contactUsInfoTextModel.data!.tiktok!),mode: LaunchMode.externalApplication);
                      },
                      child: Container(
                        height: 5.h,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(AppAssets.tiktokIcon))),
                      ),
                    ),
                  )
                ],
              ),
            );
          } else if (state is ContactUsInfoTextLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if(state is ContactUsInfoTextErrorState){
            return Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          } else {
            return const Text("Error");
          }
        },
      ),
    );
  }
}
