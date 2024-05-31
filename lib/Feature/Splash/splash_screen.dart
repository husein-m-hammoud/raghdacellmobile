import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:page_transition/page_transition.dart';
import 'package:raghadcell/App/Bloc/connectivity_bloc/connectivity_bloc.dart';
import 'package:raghadcell/App/app_localizations.dart';
import 'package:raghadcell/Core/Constants/app_assets.dart';
import 'package:raghadcell/Core/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:raghadcell/Core/Widgets/background_widget.dart';
import 'package:raghadcell/Feature/Home/Presentation/Pages/home_page.dart';
import 'package:raghadcell/Feature/SideMenu/blocs/profile_bloc/profile_bloc.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    context.read<ProfileBloc>().add(ProfileEvent());
    super.initState();
  }

  void init() async {


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {

       print("show the state $state");
           if (!AppSharedPreferences.hasToken ||state is GetProfileState) {
             Navigator.of(context).pushAndRemoveUntil(
               PageTransition(
                   child: HomePage(),
                   type: PageTransitionType.rightToLeft,
                   duration: const Duration(milliseconds: 400)),
                   (route) => false,
             );
           }

        },
        child: BackgroundWidget(
          image: AppAssets.backGroundImage,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: const Image(image: AssetImage(AppAssets.logoImage)),
            ),
          ]),
        ),
      ),
    );
  }
}
