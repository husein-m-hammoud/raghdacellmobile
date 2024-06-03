import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:raghadcell/Feature/Home/models/products_model.dart';
import 'package:sizer/sizer.dart';

import '../../../../Core/Util/SharedPreferences/SharedPreferencesHelper.dart';
import '../../../../Core/Widgets/card_design_widget.dart';
import '../../../Auth/Presentation/Pages/signin_page.dart';
import '../Pages/product_five_page.dart';
import '../Pages/product_four_page.dart';
import '../Pages/product_one_page.dart';
import '../Pages/product_three_page.dart';
import '../Pages/product_two_page.dart';
import '../Pages/product_api_page.dart';



Widget productsList({required ProductsModel productsModel}){
  return  GridView.builder(
    physics: const AlwaysScrollableScrollPhysics(),
    padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 2.h),
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
    productsModel.data!.products!.length,
    itemBuilder: (context, index) {
      return CardDesignWidget(
        imageHeight: 10.h,
        isAvilable: productsModel.data!
            .products![index].available,
        image: productsModel.data!
            .products![index].image!,
        title: productsModel.data!
            .products![index].name!,
        onPressed: () {
          if (AppSharedPreferences.hasToken) {

            if(productsModel.data!.products![index].available == 0){
              return;
            }
            if (productsModel.data!
                .products![index].number ==
                1 ) {
              Navigator.push(
                  context,MaterialPageRoute(builder: (context) =>
                  ProductOnePage(
                    product: productsModel
                        .data!.products![index],
                  ),)
              );
            }
              if (productsModel.data!.products![index].number == 6 &&
                productsModel.data!.products![index].istoken != 1) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductOnePage(
                      product: productsModel.data!.products![index],
                      number: 6,
                    ),
                  ));
            }
            if (productsModel.data!.products![index].number == 6 &&
                productsModel.data!.products![index].istoken == 1) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductApiPage(
                        product: productsModel.data!.products![index]
                        // package: null,
                        ),
                  ));
            }
            if (productsModel.data!
                .products![index].number ==
                2) {
              Navigator.push(
                  context,MaterialPageRoute(builder: (context) =>  ProductTwoPage(
                product: productsModel.data!
                    .products![index],
              ),)
              );
            }
            if (productsModel.data!
                .products![index].number ==
                4 ) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProductFourPage(
                product: productsModel.data!
                    .products![index],
              ),));
            }
            if (productsModel.data!
                .products![index].number ==
                5 ) {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>ProductFivePage(
                product: productsModel.data!
                    .products![index],
              ) ,));

            }
            if (productsModel.data!
                .products![index].number ==
                3 ) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProductThreePage(
                product: productsModel.data!
                    .products![index],
              ),));

            }
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage(),));
          }
        },
      );
    },
  );
}
class ProductsList extends StatelessWidget {
  const ProductsList({super.key,required this.productsModel,});
  final ProductsModel productsModel;

  @override
  Widget build(BuildContext context) {
    return  GridView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 2.h),
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
      productsModel.data!.products!.length,
      itemBuilder: (context, index) {
        return CardDesignWidget(
          imageHeight: 10.h,
          isAvilable: productsModel.data!
              .products![index].available,
          image: productsModel.data!
              .products![index].image!,
          title: productsModel.data!
              .products![index].name!,
          onPressed: () {
            if (AppSharedPreferences.hasToken) {
              if (productsModel.data!
                  .products![index].number ==
                  1 &&
                  productsModel.data!
                      .products![index].available !=
                      0) {
                Navigator.push(
                  context,MaterialPageRoute(builder: (context) =>
                    ProductOnePage(
                      product: productsModel
                          .data!.products![index],
                    ),)
                );
              }
              if (productsModel.data!
                  .products![index].number ==
                  2 &&
                  productsModel.data!
                      .products![index].available !=
                      0) {
                Navigator.push(
                 context,MaterialPageRoute(builder: (context) =>  ProductTwoPage(
                  product: productsModel.data!
                      .products![index],
                ),)
                );
              }
              if (productsModel.data!
                  .products![index].number ==
                  4 &&
                  productsModel.data!
                      .products![index].available !=
                      0) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProductFourPage(
                  product: productsModel.data!
                      .products![index],
                ),));
              }
              if (productsModel.data!
                  .products![index].number ==
                  5 &&
                  productsModel.data!
                      .products![index].available !=
                      0) {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>ProductFivePage(
                  product: productsModel.data!
                      .products![index],
                ) ,));

              }
              if (productsModel.data!
                  .products![index].number ==
                  3 &&
                  productsModel.data!
                      .products![index].available !=
                      0) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProductThreePage(
                  product: productsModel.data!
                      .products![index],
                ),));

              }
            } else {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage(),));
            }
          },
        );
      },
    );
  }
}
