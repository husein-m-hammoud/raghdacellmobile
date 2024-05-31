import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raghadcell/Apis/Urls.dart';
import 'package:raghadcell/App/app.dart';
import 'package:raghadcell/App/app_localizations.dart';
import 'package:raghadcell/Core/Constants/app_colors.dart';
import 'package:raghadcell/Core/Widgets/header_title_widget.dart';
import 'package:raghadcell/Core/Widgets/main_backgraund_widget.dart';
import 'package:raghadcell/Core/Widgets/single_image_widget.dart';
import 'package:raghadcell/Feature/SideMenu/blocs/about_us_bloc/bloc/about_us_bloc.dart';
import 'package:sizer/sizer.dart';

class AboutUsPage extends StatelessWidget {
  AboutUsPage({super.key, required this.viewBackButton});
  final bool viewBackButton;
  final AboutUsBloc aboutUsBloc = AboutUsBloc()..add(AboutUsEvent());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => aboutUsBloc,
      child: BlocBuilder<AboutUsBloc, AboutUsState>(
        builder: (context, state) {
          return Scaffold(
            body: MainBackGraundWidget(
              // image: AppAssets.logoImage,
              child: SafeArea(
                child: Column(children: [
                  HeaderTitleWidget(
                    title: "About Us".tr(context),
                    buttonBack: viewBackButton,
                  ),
                  Expanded(
                    child: NestedScrollView(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      headerSliverBuilder: (context, innerBoxIsScrolled) {
                        return <Widget>[
                          SliverAppBar(
                            backgroundColor: Colors.transparent,
                            title: state is GetAboutUsState
                                ? SingleImageWidget(
                                    image: Urls.storage +
                                        state.aboutUsModel.data!
                                            .aboutUsImages![0].image!)
                                : state is AboutUsLoadingState
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : state is AboutUsErrorState
                                        ? Center(
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(state.message!),
                                                  TextButton(
                                                      onPressed: () {
                                                        aboutUsBloc.add(
                                                            AboutUsEvent());
                                                      },
                                                      child: Text(
                                                        'Try Again'.tr(context),
                                                        style:
                                                            errorTryAgainStyle,
                                                      ))
                                                ]),
                                          )
                                        : const Text("Error"),
                            centerTitle: true,
                            floating: false,
                            pinned: false,
                            toolbarHeight: 30.h,
                            automaticallyImplyLeading: false,
                          )
                        ];
                      },
                      body: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Text(
                          state is GetAboutUsState
                              ? state.aboutUsModel.data!.aboutUsText!
                              : state is AboutUsLoadingState
                                  ? "Loading..."
                                  : state is AboutUsErrorState
                                      ? state.message!
                                      : "Error",
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14.sp, color: AppColors.blackColor),
                        ),
                      ),
                    ),
                  )
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
