import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:raghadcell/App/app.dart';
import 'package:raghadcell/App/app_localizations.dart';
import 'package:raghadcell/Core/Widgets/card_design_widget.dart';
import 'package:raghadcell/Core/Widgets/header_title_widget.dart';
import 'package:raghadcell/Core/Widgets/title_widget.dart';
import 'package:raghadcell/Feature/Home/bloc/products_bloc/products_bloc.dart';
import 'package:raghadcell/Feature/Products/Presentation/Pages/product_one_input_packages.dart';
import 'package:sizer/sizer.dart';

import '../../../Home/models/products_model.dart';
import '../Pages/product_api_page.dart';


class ProductOnePage extends StatelessWidget {
  ProductOnePage({super.key, required this.product, this.number});

  late final Product product;
    final num? number;

  final GlobalKey<FormState> formKey = GlobalKey();

  late final ProductsBloc homeBloc = ProductsBloc()
    ..add(GetProductsPackagesEvent(productId: product.id!));

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => homeBloc,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              HeaderTitleWidget(title: product.name!),
              Expanded(
                child: NestedScrollView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return <Widget>[
                      // SliverAppBar(
                      //   backgroundColor: Colors.transparent,
                      //   title:
                      //       const SingleImageWidget(image: AppAssets.pubgImage),
                      //   centerTitle: true,
                      //   //expandedHeight: 20.h,
                      //   floating: false,
                      //   pinned: false,
                      //   toolbarHeight: 30.h,
                      //   automaticallyImplyLeading: false,
                      // )
                    ];
                  },
                  body: Column(

                    children: [
                      TilteWidget(tilte: "Packages".tr(context)),
                      Expanded(
                        child: BlocBuilder<ProductsBloc, HomeState>(
                          builder: (context, state) {
                            if (state is GetProductsPackagesState) {
                              return GridView.builder(
                                // physics: const NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.symmetric(horizontal: 2.w),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3, // Number of items per row
                                  childAspectRatio:
                                      0.7, // Aspect ratio for grid items
                                  crossAxisSpacing:
                                      5, // Spacing between items horizontally
                                  mainAxisSpacing:
                                      10, // Spacing between items vertically
                                ),
                                itemCount:
                                    state.productsPackagesModel.data!.length,
                                itemBuilder: (context, index) {
                                  return CardDesignWidget(
                                    imageHeight: 10.h,
                                    subTitle: state.productsPackagesModel
                                        .data![index].userPrice!,
                                    title: state
                                        .productsPackagesModel.data![index].name!,
                                    image: state.productsPackagesModel
                                        .data![index].image!,
                                    onPressed: () {
                                           if (6 == number) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProductApiPage(
                                              product: product,
                                              package: state
                                                  .productsPackagesModel
                                                  .data![index],
                                              // package: null,
                                            ),
                                          ));
                                    } else {
                                      navigatorKey.currentState!.push(
                                        PageTransition(
                                            child: OrdersInput(
                                                productpackage: state
                                                    .productsPackagesModel
                                                    .data![index],
                                                isVisibile: state
                                                            .productsPackagesModel
                                                            .data![index]
                                                            .thPartyApiId ==
                                                        null
                                                    ? false
                                                    : true),
                                            type: PageTransitionType.rightToLeft,
                                            duration: const Duration(
                                                milliseconds: 400)),
                                      );
                                    }
                                    },
                                  );
                                },
                              );
                            } else if (state is ProductsPackagesLoadingState) {
                              // return Shimmer.fromColors(
                              //   baseColor: Colors.grey,
                              //   highlightColor: Colors.black,
                              //   child: SizedBox(
                              //     height: 18.h,
                              //     width: double.infinity,
                              //     child: CardDesignWidget(
                              //         image: "", onPressed: () {}, title: ""),
                              //   ),
                              // );
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state is ProductsPackagesErrorState) {
                              return Text(state.message);
                            } else {
                              return const Text("Error");
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      )
                    ],
                  ),
                  // shrinkWrap: true,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
