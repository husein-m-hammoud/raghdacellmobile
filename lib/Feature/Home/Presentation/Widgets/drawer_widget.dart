import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:raghadcell/App/Bloc/bloc/current_page_bloc.dart';
import 'package:raghadcell/App/app.dart';
import 'package:raghadcell/App/app_localizations.dart';
import 'package:raghadcell/Core/Constants/app_assets.dart';
import 'package:raghadcell/Core/Constants/app_colors.dart';
import 'package:raghadcell/Core/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:raghadcell/Feature/Products/Presentation/Pages/products_page.dart';
import 'package:raghadcell/Feature/SideMenu/Presentation/Pages/about_us_page.dart';
import 'package:raghadcell/Feature/SideMenu/Presentation/Pages/charging_the_wallet_page.dart';
import 'package:raghadcell/Feature/SideMenu/Presentation/Pages/contact_us_page.dart';
import 'package:raghadcell/Feature/SideMenu/Presentation/Pages/orders_page.dart';
import 'package:raghadcell/Feature/SideMenu/Presentation/Widgets/auth_buttons_widget.dart';
import 'package:raghadcell/Feature/SideMenu/Presentation/Widgets/change_currency.dart';
import 'package:raghadcell/Feature/SideMenu/Presentation/Widgets/change_lang_widget.dart';
import 'package:raghadcell/Feature/SideMenu/Presentation/Widgets/menu_item_widget.dart';
import 'package:raghadcell/Feature/SideMenu/Presentation/Widgets/profile_widget.dart';
import 'package:raghadcell/Feature/SideMenu/Presentation/Widgets/show_balance_widget.dart';
import 'package:raghadcell/Feature/SideMenu/blocs/profile_bloc/profile_bloc.dart';
import 'package:raghadcell/Feature/Wallet/Presentation/Pages/wallet_page.dart';
import 'package:raghadcell/Feature/notification/presentation/pages/view_notification_page.dart';
import 'package:sizer/sizer.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc()..add(ProfileEvent()),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Drawer(
            child: Container(
              decoration: const BoxDecoration(color: AppColors.logoRed),
              child: ListView(
                children: [
                  BlocBuilder<ChangePageColorBloc, ChangePageColorState>(
                    builder: (context, state) {
                      return Padding(
                          padding: EdgeInsets.only(top: 2.h),
                          child: Column(
                            children: [
                              Image.asset(
                                AppAssets.logoImage2,
                                height: 17.h,
                              ),
                              if (AppSharedPreferences.hasToken)
                                const ProfileWidget(),
                              AppSharedPreferences.hasToken
                                  ? Column(
                                      children: [
                                        // MenuItemWidget(
                                        //   color: context
                                        //               .read<ChangePageColorBloc>()
                                        //               .currentPage ==
                                        //           PagesEnum.homePage
                                        //       ? Colors.blue
                                        //       : Colors.transparent,
                                        //   text: "Home".tr(context),
                                        //   onTap: () {
                                        //     context.read<ChangePageColorBloc>().add(
                                        //         const ChangePageColorEvent(
                                        //             currentPage: PagesEnum.homePage));
                                        //     Navigator.of(context).push(
                                        //       PageTransition(
                                        //           child: HomePage(),
                                        //           type:
                                        //               PageTransitionType.rightToLeft,
                                        //           duration: const Duration(
                                        //               milliseconds: 400)),
                                        //     );
                                        //   },
                                        // ),
                                        // const HomePage(),
                                        // ProductsPage(),
                                        // ContactUsPage(
                                        // viewBackButton: false,
                                        // ),
                                        // AboutUsPage(
                                        // viewBackButton: false,
                                        // ),
                                        // const MenuPage()

                                        // MenuItemWidget(
                                        //   color: context
                                        //               .read<ChangePageColorBloc>()
                                        //               .currentPage ==
                                        //           PagesEnum.productsPage
                                        //       ? Colors.blue
                                        //       : Colors.transparent,
                                        //   text: "Products".tr(context),
                                        //   onTap: () {
                                        //     context.read<ChangePageColorBloc>().add(
                                        //         const ChangePageColorEvent(
                                        //             currentPage:
                                        //                 PagesEnum.productsPage));
                                        //     Navigator.of(context).push(
                                        //       PageTransition(
                                        //           child: ProductsPage(),
                                        //           type:
                                        //               PageTransitionType.rightToLeft,
                                        //           duration: const Duration(
                                        //               milliseconds: 400)),
                                        //     );
                                        //   },
                                        // ),
                                        if (AppSharedPreferences.hasToken)
                                          MenuItemWidget(
                                            color: context
                                                        .read<
                                                            ChangePageColorBloc>()
                                                        .currentPage ==
                                                    PagesEnum.requestsPage
                                                ? Colors.blue
                                                : Colors.transparent,
                                            text: "Orders".tr(context),
                                            onTap: () {
                                              context
                                                  .read<ChangePageColorBloc>()
                                                  .add(
                                                      const ChangePageColorEvent(
                                                          currentPage: PagesEnum
                                                              .requestsPage));
                                              Navigator.of(context).push(
                                                PageTransition(
                                                    child: const RequestsPage(),
                                                    type: PageTransitionType
                                                        .rightToLeft,
                                                    duration: const Duration(
                                                        milliseconds: 400)),
                                              );
                                            },
                                          ),
                                        if (AppSharedPreferences.hasToken)
                                          MenuItemWidget(
                                            color: context
                                                        .read<
                                                            ChangePageColorBloc>()
                                                        .currentPage ==
                                                    PagesEnum
                                                        .chargingTheWalletPage
                                                ? Colors.blue
                                                : Colors.transparent,
                                            text: "Charging the wallet"
                                                .tr(context),
                                            onTap: () {
                                              context
                                                  .read<ChangePageColorBloc>()
                                                  .add(const ChangePageColorEvent(
                                                      currentPage: PagesEnum
                                                          .chargingTheWalletPage));
                                              Navigator.of(context).push(
                                                PageTransition(
                                                    child:
                                                        const ChargingTheWalletPage(),
                                                    type: PageTransitionType
                                                        .rightToLeft,
                                                    duration: const Duration(
                                                        milliseconds: 400)),
                                              );
                                            },
                                          ),
                                        if (AppSharedPreferences.hasToken)
                                          MenuItemWidget(
                                            color: context
                                                        .read<
                                                            ChangePageColorBloc>()
                                                        .currentPage ==
                                                    PagesEnum.walletPage
                                                ? Colors.blue
                                                : Colors.transparent,
                                            text: "Wallet".tr(context),
                                            onTap: () {
                                              context
                                                  .read<ChangePageColorBloc>()
                                                  .add(
                                                      const ChangePageColorEvent(
                                                          currentPage: PagesEnum
                                                              .walletPage));
                                              Navigator.of(context).push(
                                                PageTransition(
                                                    child: const WalletPage(),
                                                    type: PageTransitionType
                                                        .rightToLeft,
                                                    duration: const Duration(
                                                        milliseconds: 400)),
                                              );
                                            },
                                          ),

                                        if (AppSharedPreferences.hasToken)
                                          MenuItemWidget(
                                            color: context
                                                        .read<
                                                            ChangePageColorBloc>()
                                                        .currentPage ==
                                                    PagesEnum.notificationPage
                                                ? Colors.blue
                                                : Colors.transparent,
                                            text: "Notifications".tr(context),
                                            onTap: () {
                                              context
                                                  .read<ChangePageColorBloc>()
                                                  .add(const ChangePageColorEvent(
                                                      currentPage: PagesEnum
                                                          .notificationPage));
                                              Navigator.of(context).push(
                                                PageTransition(
                                                    child:
                                                        const ViewNotificationPage(
                                                      viewBackButton: true,
                                                    ),
                                                    type: PageTransitionType
                                                        .rightToLeft,
                                                    duration: const Duration(
                                                        milliseconds: 400)),
                                              );
                                            },
                                          ),
                                      ],
                                    )
                                  : const SizedBox(),
                              MenuItemWidget(
                                  color: context
                                              .read<ChangePageColorBloc>()
                                              .currentPage ==
                                          PagesEnum.aboutUsPage
                                      ? Colors.blue
                                      : Colors.transparent,
                                  text: "About Us".tr(context),
                                  onTap: () {
                                    context.read<ChangePageColorBloc>().add(
                                        const ChangePageColorEvent(
                                            currentPage:
                                                PagesEnum.aboutUsPage));
                                    Navigator.of(context).push(
                                      PageTransition(
                                          child: AboutUsPage(
                                            viewBackButton: true,
                                          ),
                                          type: PageTransitionType.rightToLeft,
                                          duration: const Duration(
                                              milliseconds: 400)),
                                    );
                                  }),
                              MenuItemWidget(
                                color: context
                                            .read<ChangePageColorBloc>()
                                            .currentPage ==
                                        PagesEnum.contactUs
                                    ? Colors.blue
                                    : Colors.transparent,
                                text: "Contact Us".tr(context),
                                onTap: () {
                                  context.read<ChangePageColorBloc>().add(
                                      const ChangePageColorEvent(
                                          currentPage: PagesEnum.contactUs));
                                  Navigator.of(context).push(
                                    PageTransition(
                                        child: ContactUsPage(
                                          viewBackButton: true,
                                        ),
                                        type: PageTransitionType.rightToLeft,
                                        duration:
                                            const Duration(milliseconds: 400)),
                                  );
                                },
                              ),
                              const ChangeLangWidget(),
                              SizedBox(
                                height: 2.h,
                              ),
                              const AuthButtonWidget(),
                              SizedBox(
                                height: 2.h,
                              )
                            ],
                          ));
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
