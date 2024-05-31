// ignore_for_file: invalid_use_of_visible_for_testing_member, avoid_print, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raghadcell/Apis/Urls.dart';
import 'package:raghadcell/App/app_localizations.dart';
import 'package:raghadcell/Core/Constants/app_colors.dart';
import 'package:raghadcell/Core/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:raghadcell/Core/Widgets/coustom_button.dart';
import 'package:raghadcell/Core/Widgets/header_title_widget.dart';
import 'package:raghadcell/Core/Widgets/single_image_widget.dart';
import 'package:raghadcell/Core/Widgets/text_falid_with_title_widget.dart';
import 'package:raghadcell/Core/function/functions.dart';
import 'package:raghadcell/Feature/Home/Presentation/Pages/home_page.dart';
import 'package:raghadcell/Feature/Home/bloc/products_bloc/products_bloc.dart';
import 'package:raghadcell/Feature/SideMenu/blocs/profile_bloc/profile_bloc.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:sizer/sizer.dart';

class ProductFourPage extends StatelessWidget {
  ProductFourPage({super.key, required this.product});
  late final product;
  late final TextEditingController quantityController = TextEditingController(
      text:
          "${product.productAdditionalServices![homeBloc.productAdditionalServicesIndexSelected!].minimumQut}");
  final FocusNode quantityNode = FocusNode();
  late final TextEditingController totalController = TextEditingController(
      text: formatNumber((int.parse(quantityController.text) *
          product
              .productAdditionalServices![
                  homeBloc.productAdditionalServicesIndexSelected!]
              .userPrice!)));
  final FocusNode priceNode = FocusNode();
  final TextEditingController socialLinkController = TextEditingController();
  final FocusNode socialLinkNode = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey();

  // final List<ProductAdditionalServices> productAdditionalService;
  final ProductsBloc homeBloc = ProductsBloc()
    ..add(ProductAdditionalServicesIndexSelectedEvent(index: 0));

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => homeBloc,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              HeaderTitleWidget(
                title: product.name!,
              ),
              BlocConsumer<ProductsBloc, HomeState>(
                listener: (context, state) {
                  if (state is OrderSuccessfulState) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 5),
                      content: Text(
                          "The order has been sent successfully".tr(context)),
                    ));
                    // Navigator.pushAndRemoveUntil(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => HomePage(),
                    //     ),
                    //     (route) => false);
                      BlocProvider.of<ProfileBloc>(context)
                                        ..add(ProfileEvent());
                                    Navigator.pop(context);
                  }

                  if (state is OrderErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      duration: const Duration(seconds: 5),
                      content: Text(
                        state.message!,
                      ),
                    ));
                  }

                  if (quantityController.text != "") {
                    totalController.text = (int.parse(quantityController.text) *
                                product
                                    .productAdditionalServices![homeBloc
                                        .productAdditionalServicesIndexSelected!]
                                    .userPrice!)
                            .toString() +
                        (AppSharedPreferences.isUSD ? " \$" : " LBP");
                  }
                  if (quantityController.text == "") {
                    totalController.text =
                        "0 ${AppSharedPreferences.isUSD ? "\$" : "LBP"}";
                  }
                },
                builder: (context, state) {
                  return Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      children: [
                        SingleImageWidget(image: Urls.storage + product.image!),
                        // TaggleSwitchWidget(
                        //     productAdditionalService: productAdditionalService),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(
                              product.productAdditionalServices!.length,
                              (index) {
                            return InkWell(
                                splashColor: AppColors.seconedaryColor,
                                borderRadius: BorderRadius.circular(2.w),
                                onTap: () {
                                  //set the toggle logic
                                  // setState(() {
                                  //   for (int indexBtn = 0;
                                  //       indexBtn < isSelected.length;
                                  //       indexBtn++) {
                                  //     if (indexBtn == index) {
                                  //       isSelected[indexBtn] = true;
                                  //     } else {
                                  //       isSelected[indexBtn] = false;
                                  //     }
                                  //   }
                                  // });
                                  homeBloc.add(
                                      ProductAdditionalServicesIndexSelectedEvent(
                                          index: index));
                                },
                                child: Container(
                                    width: 27.w,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 2.h, horizontal: 3.w),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2.w),
                                      border: Border.all(
                                          color: AppColors.borderColor),
                                    ),
                                    child: GradientText(
                                        product
                                            .productAdditionalServices![index]
                                            .type!,
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                        ),
                                        colors:
                                            homeBloc.productAdditionalServicesIndexSelected ==
                                                    index
                                                ? AppColors.linearPrimaryColor
                                                // ? [Colors.red, Colors.red]
                                                : [
                                                    AppColors.blackColor,
                                                    AppColors.blackColor
                                                  ])));
                          }),
                        ),
                        Form(
                            key: formKey,
                            child: Column(
                              children: [
                                Row(
                                  textDirection: TextDirection.ltr,
                                  children: [
                                    Expanded(
                                      child: TextFalidWithTilteWidget(
                                          onChanged: (p0) {
                                            if (p0 != "") {
                                              totalController
                                                  .text = formatNumber((int
                                                          .parse(p0) *
                                                      product
                                                          .productAdditionalServices![
                                                              homeBloc
                                                                  .productAdditionalServicesIndexSelected!]
                                                          .userPrice!)
                                                  .toInt());
                                            }
                                          },
                                          validator: (p0) {
                                            if (double.parse(p0!) <
                                                product
                                                    .productAdditionalServices![
                                                        homeBloc
                                                            .productAdditionalServicesIndexSelected!]
                                                    .minimumQut!) {
                                              return product
                                                  .productAdditionalServices![
                                                      homeBloc
                                                          .productAdditionalServicesIndexSelected!]
                                                  .minimumQutNote;
                                            }

                                            if (p0.isEmpty) {
                                              return "this field is required"
                                                  .tr(context);
                                            }

                                            return null;
                                          },
                                          title: "Quantity".tr(context),
                                          hintText:
                                              "${"Enter Your".tr(context)} ${"Quantity".tr(context)}",
                                          validatorMessage: "quteNote",
                                          isValidator: true,
                                          textInputType: TextInputType.number,
                                          focusNode: quantityNode,
                                          controller: quantityController),
                                    ),
                                    Expanded(
                                      child: TextFalidWithTilteWidget(
                                          fillColor: AppColors.borderColor,
                                          textColor: AppColors.whiteColor,
                                          title: "Total".tr(context),
                                          enable: false,
                                          focusNode: priceNode,
                                          controller: totalController),
                                    ),
                                  ],
                                ),
                                TextFalidWithTilteWidget(
                                    validator: (p0) {
                                      if (p0!.isEmpty) {
                                        return product
                                            .productAdditionalServices![homeBloc
                                                .productAdditionalServicesIndexSelected!]
                                            .note!;
                                      }
                                      return null;
                                    },
                                    title: "Social Link".tr(context),
                                    hintText:
                                        "${"Enter Your".tr(context)} ${"Link".tr(context)}",
                                    validatorMessage:
                                        "Please enter your link".tr(context),
                                    isValidator: true,
                                    textInputType: TextInputType.name,
                                    focusNode: socialLinkNode,
                                    controller: socialLinkController),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 3.w),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: state is OrderLoadingState
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : CoustomButton(
                                            onPressed: () {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                homeBloc.add(OrderFourEvent(
                                                    link: socialLinkController
                                                        .text
                                                        .trim(),
                                                    productId:
                                                        product.id.toString(),
                                                    serviceType: product
                                                        .productAdditionalServices![
                                                            homeBloc
                                                                .productAdditionalServicesIndexSelected!]
                                                        .type!,
                                                    quantity: quantityController
                                                        .text
                                                        .trim()));
                                              }
                                            },
                                            buttonText: "Buy".tr(context)),
                                  ),
                                )
                              ],
                            )),
                        SizedBox(
                          height: 5.h,
                        )
                      ],
                    ),
                    // shrinkWrap: true,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
