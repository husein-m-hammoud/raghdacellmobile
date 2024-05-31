import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:raghadcell/App/app.dart';
import 'package:raghadcell/App/app_localizations.dart';
import 'package:raghadcell/Core/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:raghadcell/Core/Widgets/card_design_widget.dart';
import 'package:raghadcell/Core/Widgets/header_title_widget.dart';
import 'package:raghadcell/Core/Widgets/main_backgraund_widget.dart';
import 'package:raghadcell/Feature/Auth/Presentation/Pages/signin_page.dart';
import 'package:raghadcell/Feature/Home/bloc/products_bloc/products_bloc.dart';
import 'package:raghadcell/Feature/Products/Presentation/Pages/product_five_page.dart';
import 'package:raghadcell/Feature/Products/Presentation/Pages/product_four_page.dart';
import 'package:raghadcell/Feature/Products/Presentation/Pages/product_one_page.dart';
import 'package:raghadcell/Feature/Products/Presentation/Pages/product_three_page.dart';
import 'package:raghadcell/Feature/Products/Presentation/Pages/product_two_page.dart';
import 'package:sizer/sizer.dart';

class ProductsPage extends StatelessWidget {
  ProductsPage({super.key});
  final ProductsBloc homeBloc = ProductsBloc()..add(GetProductsEvent());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => homeBloc,
      child: Scaffold(
        // appBar: PreferredSize(
        //     preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        //     child: const AppBarWidget()),
        body: MainBackGraundWidget(
          child: SafeArea(
            child: Column(
              children: [
                HeaderTitleWidget(
                  title: "Products".tr(context),
                  buttonBack: true,
                ),
                Expanded(
                  child: BlocBuilder<ProductsBloc, HomeState>(
                    builder: (context, state) {
                      if (state is GetProductsState) {
                        return SmartRefresher(
                          onRefresh: () {
                            homeBloc.page = 1;
                            homeBloc.add(GetProductsEvent());
                            homeBloc.refreshController.refreshCompleted();
                            homeBloc.refreshController.loadComplete();
                          },
                          onLoading: () async {
                            if (homeBloc.productsModel!.data!.lastPage ==
                                    homeBloc.page ||
                                homeBloc.productsModel!.data!.products!
                                        .length ==
                                    homeBloc.productsModel!.data!.total!) {
                              homeBloc.refreshController.loadNoData();
                            } else if (homeBloc
                                        .productsModel!.data!.products!.length <
                                    homeBloc.productsModel!.data!.total! &&
                                homeBloc.page ==
                                    homeBloc.productsModel!.data!.lastPage) {
                              homeBloc.page = 1;
                              homeBloc.refreshController.loadComplete();
                            } else {
                              homeBloc.page++;
                              homeBloc.refreshController.requestLoading();
                              homeBloc.add(GetProductsEvent());
                              homeBloc.refreshController.loadComplete();
                            }
                          },
                          enablePullDown: true,
                          enablePullUp: true,
                          controller: homeBloc.refreshController,
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: 2.w),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, // Number of items per row
                              childAspectRatio:
                                  0.108.h, // Aspect ratio for grid items
                              crossAxisSpacing:
                                  5, // Spacing between items horizontally
                              mainAxisSpacing:
                                  10, // Spacing between items vertically
                            ),
                            itemCount:
                                homeBloc.productsModel!.data!.products!.length,
                            itemBuilder: (context, index) {
                              return CardDesignWidget(
                                imageHeight: 10.h,
                                isAvilable: homeBloc.productsModel!.data!
                                    .products![index].available,
                                image: homeBloc.productsModel!.data!
                                    .products![index].image!,
                                title: homeBloc.productsModel!.data!
                                    .products![index].name!,
                                onPressed: () {
                                  if (AppSharedPreferences.hasToken) {
                                    if (homeBloc.productsModel!.data!
                                                .products![index].number ==
                                            1 &&
                                        homeBloc.productsModel!.data!
                                                .products![index].available !=
                                            0) {
                                      navigatorKey.currentState!.push(
                                        PageTransition(
                                            child: ProductOnePage(
                                              product: homeBloc.productsModel!
                                                  .data!.products![index],
                                            ),
                                            type:
                                                PageTransitionType.rightToLeft,
                                            duration: const Duration(
                                                milliseconds: 400)),
                                      );
                                    }
                                    if (homeBloc.productsModel!.data!
                                                .products![index].number ==
                                            2 &&
                                        homeBloc.productsModel!.data!
                                                .products![index].available !=
                                            0) {
                                      navigatorKey.currentState!.push(
                                        PageTransition(
                                            child: ProductTwoPage(
                                              product: state.productsModel.data!
                                                  .products![index],
                                            ),
                                            type:
                                                PageTransitionType.rightToLeft,
                                            duration: const Duration(
                                                milliseconds: 400)),
                                      );
                                    }
                                    if (homeBloc.productsModel!.data!
                                                .products![index].number ==
                                            4 &&
                                        homeBloc.productsModel!.data!
                                                .products![index].available !=
                                            0) {
                                      navigatorKey.currentState!.push(
                                        PageTransition(
                                            child: ProductFourPage(
                                              product: state.productsModel.data!
                                                  .products![index],
                                            ),
                                            type:
                                                PageTransitionType.rightToLeft,
                                            duration: const Duration(
                                                milliseconds: 400)),
                                      );
                                    }
                                    if (homeBloc.productsModel!.data!
                                                .products![index].number ==
                                            5 &&
                                        homeBloc.productsModel!.data!
                                                .products![index].available !=
                                            0) {
                                      navigatorKey.currentState!.push(
                                        PageTransition(
                                            child: ProductFivePage(
                                              product: state.productsModel.data!
                                                  .products![index],
                                            ),
                                            type:
                                                PageTransitionType.rightToLeft,
                                            duration: const Duration(
                                                milliseconds: 400)),
                                      );
                                    }
                                    if (homeBloc.productsModel!.data!
                                                .products![index].number ==
                                            3 &&
                                        homeBloc.productsModel!.data!
                                                .products![index].available !=
                                            0) {
                                      navigatorKey.currentState!.push(
                                        PageTransition(
                                            child: ProductThreePage(
                                              product: state.productsModel.data!
                                                  .products![index],
                                            ),
                                            type:
                                                PageTransitionType.rightToLeft,
                                            duration: const Duration(
                                                milliseconds: 400)),
                                      );
                                    }
                                  } else {
                                    navigatorKey.currentState!.push(
                                      PageTransition(
                                          child: SignInPage(),
                                          type: PageTransitionType.scale,
                                          alignment: Alignment.center,
                                          duration: const Duration(
                                              milliseconds: 400)),
                                    );
                                  }
                                },
                              );
                            },
                          ),
                        );
                      } else if (state is ProductsLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is ProductsErrorState) {
                        return Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(state.message),
                                TextButton(
                                    onPressed: () {
                                      homeBloc.page = 1;
                                      homeBloc.add(GetProductsEvent());
                                    },
                                    child: Text(
                                      'Try Again'.tr(context),
                                      style: errorTryAgainStyle,
                                    ))
                              ]),
                        );
                      } else {
                        return Text("Error".tr(context));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
