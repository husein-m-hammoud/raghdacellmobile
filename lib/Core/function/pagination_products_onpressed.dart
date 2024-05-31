import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:raghadcell/App/app.dart';
import 'package:raghadcell/Core/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:raghadcell/Feature/Auth/Presentation/Pages/signin_page.dart';
import 'package:raghadcell/Feature/Home/bloc/products_bloc/products_bloc.dart';
import 'package:raghadcell/Feature/Products/Presentation/Pages/product_five_page.dart';
import 'package:raghadcell/Feature/Products/Presentation/Pages/product_four_page.dart';
import 'package:raghadcell/Feature/Products/Presentation/Pages/product_one_page.dart';
import 'package:raghadcell/Feature/Products/Presentation/Pages/product_three_page.dart';
import 'package:raghadcell/Feature/Products/Presentation/Pages/product_two_page.dart';

paginateProduct(BuildContext context, state, int index) {
  if (AppSharedPreferences.hasToken) {
    if (context
                .read<ProductsBloc>()
                .productsModel!
                .data!
                .products![index]
                .number ==
            1 &&
        context
                .read<ProductsBloc>()
                .productsModel!
                .data!
                .products![index]
                .available !=
            0) {
      navigatorKey.currentState!.push(
        PageTransition(
            child: ProductOnePage(
              product: context
                  .read<ProductsBloc>()
                  .productsModel!
                  .data!
                  .products![index],
            ),
            type: PageTransitionType.rightToLeft,
            duration: const Duration(milliseconds: 400)),
      );
    }
    if (context
                .read<ProductsBloc>()
                .productsModel!
                .data!
                .products![index]
                .number ==
            2 &&
        context
                .read<ProductsBloc>()
                .productsModel!
                .data!
                .products![index]
                .available !=
            0) {
      navigatorKey.currentState!.push(
        PageTransition(
            child: ProductTwoPage(
              product: state.productsModel.data!.products![index],
            ),
            type: PageTransitionType.rightToLeft,
            duration: const Duration(milliseconds: 400)),
      );
    }
    if (context
                .read<ProductsBloc>()
                .productsModel!
                .data!
                .products![index]
                .number ==
            4 &&
        context
                .read<ProductsBloc>()
                .productsModel!
                .data!
                .products![index]
                .available !=
            0) {
      navigatorKey.currentState!.push(
        PageTransition(
            child: ProductFourPage(
              product: state.productsModel.data!.products![index],
            ),
            type: PageTransitionType.rightToLeft,
            duration: const Duration(milliseconds: 400)),
      );
    }
    if (context
                .read<ProductsBloc>()
                .productsModel!
                .data!
                .products![index]
                .number ==
            5 &&
        context
                .read<ProductsBloc>()
                .productsModel!
                .data!
                .products![index]
                .available !=
            0) {
      navigatorKey.currentState!.push(
        PageTransition(
            child: ProductFivePage(
              product: state.productsModel.data!.products![index],
            ),
            type: PageTransitionType.rightToLeft,
            duration: const Duration(milliseconds: 400)),
      );
    }
    if (context
                .read<ProductsBloc>()
                .productsModel!
                .data!
                .products![index]
                .number ==
            3 &&
        context
                .read<ProductsBloc>()
                .productsModel!
                .data!
                .products![index]
                .available !=
            0) {
      navigatorKey.currentState!.push(
        PageTransition(
            child: ProductThreePage(
              product: state.productsModel.data!.products![index],
            ),
            type: PageTransitionType.rightToLeft,
            duration: const Duration(milliseconds: 400)),
      );
    }
  } else {
    navigatorKey.currentState!.push(
      PageTransition(
          child: SignInPage(),
          type: PageTransitionType.scale,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 400)),
    );
  }
}
