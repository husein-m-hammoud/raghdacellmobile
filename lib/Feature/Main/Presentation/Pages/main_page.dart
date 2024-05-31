// // ignore_for_file: deprecated_member_use

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:raghadcell/App/Bloc/connectivity_bloc/connectivity_bloc.dart';
// import 'package:raghadcell/App/app_localizations.dart';
// import 'package:raghadcell/Core/Constants/app_assets.dart';
// import 'package:raghadcell/Core/Constants/app_colors.dart';
// import 'package:raghadcell/Feature/Home/Presentation/Pages/home_page.dart';
// import 'package:raghadcell/Feature/Main/Bloc/main_bloc/main_bloc.dart';
// import 'package:raghadcell/Feature/Main/Presentation/Widgets/bottom_navigationbar_item.dart';
// import 'package:raghadcell/Feature/Products/Presentation/Pages/products_page.dart';
// import 'package:raghadcell/Feature/SideMenu/Presentation/Pages/about_us_page.dart';
// import 'package:raghadcell/Feature/SideMenu/Presentation/Pages/contact_us_page.dart';
// import 'package:raghadcell/Feature/SideMenu/Presentation/Pages/menu_page.dart';

// class MainPage extends StatefulWidget {
//   const MainPage({super.key});

//   @override
//   State<MainPage> createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   final List<GlobalKey<NavigatorState>> navigatorKeys = [
//     GlobalKey<NavigatorState>(),
//     GlobalKey<NavigatorState>(),
//     GlobalKey<NavigatorState>(),
//     GlobalKey<NavigatorState>(),
//     GlobalKey<NavigatorState>(),
//   ];

//   final List<Widget> screens = [
   
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         NavigatorState? currentNavigator =
//             navigatorKeys[context.read<MainBloc>().currentIndex].currentState;
//         if (currentNavigator!.canPop()) {
//           currentNavigator.pop();
//           return false;
//         }
//         return false;
//       },
//       child: BlocBuilder<MainBloc, BottomNavigationBarState>(
//         builder: (context, state) {
//           return Scaffold(
//               body: BlocListener<ConnectivityBloc, ConnectedState>(
//                   listener: (context, state) {
//                     if (state.message == "Connecting To Wifi") {
//                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                         backgroundColor: Colors.green,
//                         duration: const Duration(seconds: 5),
//                         content: Text(
//                           state.message.tr(context),
//                         ),
//                       ));
//                     }
//                     if (state.message == "Connecting To Mobile Data") {
//                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                         backgroundColor: Colors.green,
//                         duration: const Duration(seconds: 5),
//                         content: Text(
//                           state.message.tr(context),
//                         ),
//                       ));
//                     }
//                     if (state.message == "Lost Internet Connection") {
//                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                         backgroundColor: Colors.red,
//                         duration: const Duration(seconds: 5),
//                         content: Text(
//                           state.message.tr(context),
//                         ),
//                       ));
//                     }
//                   },
//                   child:

//                       //  IndexedStack(
//                       //     index: context.read<MainBloc>().currentIndex,
//                       //     children: screens)

//                       IndexedStack(
//                           index: context.read<MainBloc>().currentIndex,
//                           children: navigatorKeys.map((key) {
//                             int index = navigatorKeys.indexOf(key);
//                             return Offstage(
//                               offstage: context.read<MainBloc>().currentIndex !=
//                                   index,
//                               child: Navigator(
//                                 key: key,
//                                 onGenerateRoute: (routeSettings) {
//                                   return MaterialPageRoute(
//                                     builder: (context) => screens[index],
//                                   );
//                                 },
//                               ),
//                             );
//                           }).toList())),
//               bottomNavigationBar: Container(
//                 decoration: const BoxDecoration(
//                   boxShadow: [
//                     BoxShadow(
//                         color: AppColors.borderColor,
//                         spreadRadius: 0.5,
//                         blurRadius: 0.5),
//                   ],
//                 ),
//                 child: BottomNavigationBar(
//                   showSelectedLabels: true,
//                   showUnselectedLabels: true,
//                   selectedItemColor: AppColors.primaryColor,
//                   unselectedItemColor: AppColors.borderColor,
//                   backgroundColor: Colors.white,
//                   currentIndex: context.read<MainBloc>().currentIndex,
//                   onTap: (index) {
//                     if (index != context.read<MainBloc>().currentIndex) {
//                       context
//                           .read<MainBloc>()
//                           .add(SelectBottomNavigationBarItem(index: index));
//                     } else {
//                       navigatorKeys[index]
//                           .currentState!
//                           .popUntil((route) => route.isFirst);
//                     }
//                   },
//                   items: [
//                     bottomNavigationBarItem(context,
//                         currentIndex: context.read<MainBloc>().currentIndex,
//                         label: "Home".tr(context),
//                         icon: AppAssets.homeIcon),
//                     bottomNavigationBarItem(context,
//                         currentIndex: context.read<MainBloc>().currentIndex,
//                         label: "Products".tr(context),
//                         icon: AppAssets.productIcon),
//                     bottomNavigationBarItem(context,
//                         currentIndex: context.read<MainBloc>().currentIndex,
//                         icon: AppAssets.contactusIcon,
//                         label: "ContactUs".tr(context)),
//                     bottomNavigationBarItem(context,
//                         currentIndex: context.read<MainBloc>().currentIndex,
//                         icon: AppAssets.aboutIcon,
//                         label: "About Us".tr(context)),
//                     bottomNavigationBarItem(context,
//                         currentIndex: context.read<MainBloc>().currentIndex,
//                         icon: AppAssets.menuIcon,
//                         label: "Menu".tr(context)),
//                   ],
//                 ),
//               ));
//         },
//       ),
//     );
//   }
// }

// class Wallet extends StatelessWidget {
//   const Wallet({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Text("Wallet"),
//       ),
//     );
//   }
// }

// class Payment extends StatelessWidget {
//   const Payment({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Text("Payment"),
//       ),
//     );
//   }
// }

// class HomePage2 extends StatelessWidget {
//   const HomePage2({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Text("Home2"),
//       ),
//     );
//   }
// }
