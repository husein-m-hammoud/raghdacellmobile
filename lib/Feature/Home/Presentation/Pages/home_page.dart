import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:raghadcell/App/app.dart';
import 'package:raghadcell/App/app_localizations.dart';
import 'package:raghadcell/Core/Constants/app_assets.dart';
import 'package:raghadcell/Core/Constants/app_colors.dart';
import 'package:raghadcell/Core/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:raghadcell/Core/Widgets/app_bar_widget.dart';
import 'package:raghadcell/Core/Widgets/carousel_slider_images.dart';
import 'package:raghadcell/Core/Widgets/card_design_widget.dart';
import 'package:raghadcell/Core/Widgets/main_backgraund_widget.dart';
import 'package:raghadcell/Core/function/pagination_products_onpressed.dart';
import 'package:raghadcell/Feature/Home/Presentation/Widgets/drawer_widget.dart';
import 'package:raghadcell/Feature/Home/bloc/products_bloc/products_bloc.dart';
import 'package:raghadcell/Feature/Products/Presentation/Pages/search_products.dart';
import 'package:raghadcell/Feature/SideMenu/Presentation/Widgets/change_currency.dart';
import 'package:raghadcell/Feature/SideMenu/Presentation/Widgets/show_balance_widget.dart';
import 'package:raghadcell/Feature/SideMenu/blocs/profile_bloc/profile_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Products/Presentation/Widgets/products_list.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final List<String> images = [
  final TextEditingController searchController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final PageController pageController = PageController();

  // final ProductsBloc homeBloc =     ;
  @override
  void initState() {
    context.read<ProductsBloc>().page = 1;
    context.read<ProductsBloc>().add(GetProductsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Container(
          height: 8.h,
          decoration: BoxDecoration(shape: BoxShape.circle),
          child: GestureDetector(
            onTap: () {
              launchUrl(
                  Uri.parse(
                      "https://api.whatsapp.com/send/?phone=96176586062&text&type=phone_number&app_absent=0"),
                  mode: LaunchMode.externalApplication);
            },
            child: Image.asset(
              AppAssets.whatsappIcon,
            ),
          ),
        ),
        drawer: const DrawerWidget(),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(
              AppBar().preferredSize.height + 9.h,
              // 20.h
            ),
            child: SafeArea(
              child: Container(
                color: AppColors.logoRed,
                child: Column(
                  children: [
                    SizedBox(
                      height: .5.h,
                    ),
                    const AppBarWidget(),
                    SizedBox(
                      height: 1.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SearchProductPage(),
                              ));
                        },
                        child: Form(
                          key: formKey,
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: TextFormField(
                              style: const TextStyle(color: Colors.black),
                              enabled: false,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  suffixIcon: IconButton(
                                    iconSize: 25.sp,
                                    style: ButtonStyle(
                                        shape: MaterialStatePropertyAll<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(3.w),
                                                    topRight:
                                                        Radius.circular(3.w)))),
                                        backgroundColor:
                                            const MaterialStatePropertyAll<
                                                Color>(AppColors.logoRed)),
                                    onPressed: () {
                                      // if (formKey.currentState!.validate()) {
                                      //   context.read<ProductsBloc>().add(
                                      //       ProductsSearchEvent(
                                      //           searchController.text.trim()));
                                      // }
                                    },
                                    icon: const Icon(Icons.search),
                                    color: Colors.white,
                                  ),
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 2.w),
                                  hintText: "Search...".tr(context),
                                  hintStyle:
                                      const TextStyle(color: Colors.black),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(3.w),
                                      borderSide: BorderSide(
                                          color: AppColors.whiteColor,
                                          width: 2.h))),
                              controller: searchController,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
        body: MainBackGraundWidget(
          child: Column(
            children: [
              if (AppSharedPreferences.hasToken)
                BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const ShowBalanceWidget(
                          isDrawer: false,
                        ),
                        if (AppSharedPreferences.hasToken)
                          const ChangeCurrencyWidget(),
                      ],
                    );
                  },
                ),
              if (!AppSharedPreferences.hasToken)
                SizedBox(
                  height: .5.h,
                ),
              Expanded(
                child: NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) => [
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.only(top: 2.h),
                              child: const CarouselSliderImages(),
                            ),
                          )
                        ],
                    physics: const AlwaysScrollableScrollPhysics(),
                    body: BlocBuilder<ProductsBloc, HomeState>(
                      builder: (context, state) {
                        if (state is ProductsErrorState) {
                          return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(state.message),
                                TextButton(
                                    onPressed: () {
                                      context
                                          .read<ProductsBloc>()
                                          .add(GetProductsEvent());
                                    },
                                    child: Text(
                                      'Try Again'.tr(context),
                                      style: errorTryAgainStyle,
                                    ))
                              ]);
                        } else if (state is ProductsLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return SmartRefresher(
                            key: MyApp.uniqueKey,
                            onLoading: () async {
                              context
                                  .read<ProductsBloc>()
                                  .add(GetProductsEvent());
                            },
                            onRefresh: () {
                              context.read<ProductsBloc>().page = 1;
                              context
                                  .read<ProductsBloc>()
                                  .add(GetProductsEvent());
                              context.read<ProfileBloc>().add(ProfileEvent());
                            },
                            enablePullDown: true,
                            enablePullUp: true,
                            controller:
                                context.read<ProductsBloc>().refreshController,
                            child: productsList(
                                productsModel: context
                                    .read<ProductsBloc>()
                                    .productsModel!),
                          );
                        }
                      },
                    )),
              ),
            ],
          ),
        ));
  }
}
