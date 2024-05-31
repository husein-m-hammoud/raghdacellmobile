import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:raghadcell/App/Bloc/app_language_bloc/app_language_bloc.dart';
import 'package:raghadcell/App/Bloc/bloc/app_currency_bloc.dart';
import 'package:raghadcell/App/Bloc/bloc/current_page_bloc.dart';
import 'package:raghadcell/App/Bloc/connectivity_bloc/connectivity_bloc.dart';
import 'package:raghadcell/App/Bloc/scroll_bloc/scroll_bloc.dart';
import 'package:raghadcell/Core/Constants/app_colors.dart';
import 'package:raghadcell/Core/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:raghadcell/Feature/Auth/Bloc/register_bloc/register_bloc.dart';
import 'package:raghadcell/Feature/Home/bloc/products_bloc/products_bloc.dart';
import 'package:raghadcell/Feature/Main/Bloc/main_bloc/main_bloc.dart';
import 'package:raghadcell/Feature/SideMenu/blocs/deposit_bloc/bloc/shopping_value_bloc.dart';
import 'package:raghadcell/Feature/SideMenu/blocs/profile_bloc/profile_bloc.dart';

import 'package:raghadcell/Feature/Splash/splash_screen.dart';
import 'package:raghadcell/Feature/notification/bloc/view_notification_bloc.dart';
import 'package:raghadcell/main.dart';
import 'package:sizer/sizer.dart';
import 'package:raghadcell/App/app_localizations.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
TextStyle errorTryAgainStyle =
    TextStyle(fontSize: 10.sp, color: Colors.blue, fontWeight: FontWeight.bold);

enum PagesEnum {
  homePage,
  productsPage,
  walletPage,
  requestsPage,
  chargingTheWalletPage,
  notificationPage,
  aboutUsPage,
  contactUs
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static final UniqueKey uniqueKey = UniqueKey();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  takeRequestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
    } else {}
  }


  @override
  void initState() {
    takeRequestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;

      if (message.notification != null) {
        plugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                iOS: const DarwinNotificationDetails(
                    presentAlert: true,
                    presentBadge: true,
                    presentBanner: true,
                    presentSound: true,
                    interruptionLevel: InterruptionLevel.active),
                android: AndroidNotificationDetails(channel.id, channel.name,
                    channelDescription: channel.description,
                    color: Colors.blue,
                    playSound: true,
                    icon: "@mipmap/ic_launcher")));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => AppLanguageBloc()..add(InitLanguage()),
            ),
            BlocProvider(
              create: (_) => AppCurrencyBloc()..add(InitCurrency()),
            ),
            BlocProvider(
              create: (context) => ConnectivityBloc(),
            ),
            BlocProvider(
              create: (context) => MainBloc(),
            ),
            BlocProvider(create: (_) => ScrollBloc()),

            BlocProvider(
                create: (_) => ChangePageColorBloc()
                  ..add(const ChangePageColorEvent(
                      currentPage: PagesEnum.homePage))),
            BlocProvider(create: (_) => ShoppingValueBloc()),
            BlocProvider(create: (_) => RegisterBloc()),
            // BlocProvider(create: (_) => ProductSearchBloc()),
            BlocProvider(create: (_) => ProfileBloc()..add(ProfileEvent())),
            BlocProvider(
                create: (_) => ProductsBloc()),

            // BlocProvider(
            //     create: (_) =>
            //         DepositBloc()..add(GetDepositInformationEvent())),
            // BlocProvider(
            //     create: (_) => OrdersBloc()..add(GetAndFilterOrdersEvent())),
          ],
          child: BlocConsumer<AppLanguageBloc, LanguageState>(
            builder: (context, state) {
              return MaterialApp(
                color: AppColors.seconedaryColor,
                title: "Raghdacell",
                debugShowCheckedModeBanner: false,
                locale: Locale(AppSharedPreferences.getArLang),
                supportedLocales: const [Locale('en', 'US'), Locale('ar')],
                localizationsDelegates: const [
                  Applocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate
                ],
                navigatorKey: navigatorKey,
                localeResolutionCallback: (deviceLocale, supportedLocales) {
                  for (var locale in supportedLocales) {
                    if (deviceLocale != null &&
                        deviceLocale.languageCode == locale.languageCode) {
                      return deviceLocale;
                    }
                  }
                  return supportedLocales.first;
                },
                home:
                    //  SearchProducts(),
                    const SplashScreen(),
              );
            },
            listener: (BuildContext context, LanguageState state) {
              if (state is ChangLanguageState) {
                BlocProvider.of<ProfileBloc>(context).add(ProfileEvent());
                BlocProvider.of<ProductsBloc>(context).add(GetProductsEvent());
                BlocProvider.of<ProductsBloc>(context)
                    .add(GetSliderImageEvent());
              }
            },
          )),
    );
  }
}
