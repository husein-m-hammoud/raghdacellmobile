// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:raghadcell/App/app_localizations.dart';
// import 'package:raghadcell/Core/Constants/app_assets.dart';
// import 'package:raghadcell/Core/Util/SharedPreferences/SharedPreferencesHelper.dart';
// import 'package:raghadcell/Core/Widgets/header_title_widget.dart';
// import 'package:raghadcell/Feature/Main/Bloc/main_bloc/main_bloc.dart';
// import 'package:raghadcell/Feature/SideMenu/Presentation/Pages/about_us_page.dart';
// import 'package:raghadcell/Feature/SideMenu/Presentation/Pages/charging_the_wallet_page.dart';
// import 'package:raghadcell/Feature/SideMenu/Presentation/Pages/contact_us_page.dart';
// import 'package:raghadcell/Feature/SideMenu/Presentation/Pages/requests_page.dart';
// import 'package:raghadcell/Feature/SideMenu/Presentation/Widgets/auth_buttons_widget.dart';
// import 'package:raghadcell/Feature/SideMenu/Presentation/Widgets/change_lang_widget.dart';
// import 'package:raghadcell/Feature/SideMenu/Presentation/Widgets/menu_item_widget.dart';
// import 'package:raghadcell/Feature/SideMenu/Presentation/Widgets/profile_widget.dart';
// import 'package:raghadcell/Feature/Wallet/Presentation/Pages/wallet_page.dart';
// import 'package:raghadcell/Feature/notification/presentation/pages/view_notification_page.dart';
// import 'package:sizer/sizer.dart';

// class MenuPage extends StatelessWidget {
//   const MenuPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(children: [
//           HeaderTitleWidget(
//             title: "Menu".tr(context),
//             buttonBack: false,
//           ),
//           AppSharedPreferences.hasToken
//               ? SizedBox(height: 28.h, child: ProfileWidget())
//               : Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 10.w),
//                   child: const Image(image: AssetImage(AppAssets.logoImage)),
//                 ),
//           // : const SizedBox(),
//           Expanded(
              
//               child: ListView(
        
//             physics: const BouncingScrollPhysics(
//                 parent: AlwaysScrollableScrollPhysics()),
       
//             children: [

//               AppSharedPreferences.hasToken
//                   ? Column(
//                       children: [
//                         MenuItemWidget(
//                           text: "Wallet".tr(context),
//                           onTap: () {
//                             Navigator.of(context).push(
//                               PageTransition(
//                                   child: const WalletPage(),
//                                   type: PageTransitionType.rightToLeft,
//                                   duration: const Duration(milliseconds: 400)),
//                             );
//                             // context
//                             //     .read<MainBloc>()
//                             //     .add(SelectBottomNavigationBarItem(index: 3));
//                           },
//                         ),
//                         MenuItemWidget(
//                           text: "Requests".tr(context),
//                           onTap: () {
//                             Navigator.of(context).push(
//                               PageTransition(
//                                   child: const RequestsPage(),
//                                   type: PageTransitionType.rightToLeft,
//                                   duration: const Duration(milliseconds: 400)),
//                             );
//                           },
//                         ),
//                         MenuItemWidget(
//                           text: "Charging the wallet".tr(context),
//                           onTap: () {
//                             Navigator.of(context).push(
//                               PageTransition(
//                                   child: const ChargingTheWalletPage(),
//                                   type: PageTransitionType.rightToLeft,
//                                   duration: const Duration(milliseconds: 400)),
//                             );
//                           },
//                         ),
//                         MenuItemWidget(
//                           text: "Notifications".tr(context),
//                           onTap: () {
//                             // context
//                             //     .read<MainBloc>()
//                             //     .add(SelectBottomNavigationBarItem(index: 2));
//                             Navigator.of(context).push(
//                               PageTransition(
//                                   child: const ViewNotificationPage(
//                                     viewBackButton: true,
//                                   ),
//                                   type: PageTransitionType.rightToLeft,
//                                   duration: const Duration(milliseconds: 400)),
//                             );
//                           },
//                         ),
//                       ],
//                     )
//                   : const SizedBox(),
//               MenuItemWidget(
//                 text: "About Us".tr(context),
//                 onTap: () {
//                   if (AppSharedPreferences.hasToken) {
//                     Navigator.of(context).push(
//                       PageTransition(
//                           child: AboutUsPage(
//                             viewBackButton: true,
//                           ),
//                           type: PageTransitionType.rightToLeft,
//                           duration: const Duration(milliseconds: 400)),
//                     );
//                   } else {
//                     context
//                         .read<MainBloc>()
//                         .add(SelectBottomNavigationBarItem(index: 2));
//                   }
//                 },
//               ),
//               MenuItemWidget(
//                 text: "Contact Us".tr(context),
//                 onTap: () {
//                   Navigator.of(context).push(
//                     PageTransition(
//                         child: ContactUsPage(
//                           viewBackButton: true,
//                         ),
//                         type: PageTransitionType.rightToLeft,
//                         duration: const Duration(milliseconds: 400)),
//                   );
//                 },
//               ),
//               const ChangeLangWidget(),
//               SizedBox(
//                 height: 2.h,
//               ),
//               const AuthButtonWidget(),
//               SizedBox(
//                 height: 4.h,
//               ),
//             ],
//           ))
//         ]),
//       ),
//     );
//   }
// }
