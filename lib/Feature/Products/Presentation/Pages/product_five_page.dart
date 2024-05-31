// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raghadcell/Apis/Urls.dart';
import 'package:raghadcell/App/app_localizations.dart';
import 'package:raghadcell/Core/Constants/app_colors.dart';
import 'package:raghadcell/Core/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:raghadcell/Core/Widgets/coustom_button.dart';
import 'package:raghadcell/Core/Widgets/header_title_widget.dart';
import 'package:raghadcell/Core/Widgets/main_backgraund_widget.dart';
import 'package:raghadcell/Core/Widgets/single_image_widget.dart';
import 'package:raghadcell/Core/Widgets/text_falid_with_title_widget.dart';
import 'package:raghadcell/Core/function/functions.dart';
import 'package:raghadcell/Feature/Home/Presentation/Pages/home_page.dart';
import 'package:raghadcell/Feature/Home/bloc/products_bloc/products_bloc.dart';
import 'package:raghadcell/Feature/SideMenu/blocs/profile_bloc/profile_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../Home/models/products_model.dart';

class ProductFivePage extends StatelessWidget {
  ProductFivePage({
    super.key,
    required this.product,
  }) {
    quantityController = TextEditingController(text: "${product.minimumQut}");
    totalController = TextEditingController(
        text: formatNumber(
            int.parse(quantityController.text) * product.userPrice));
  }
  // final TextEditingController quantityController = TextEditingController();
  var quantityController = TextEditingController();
  final FocusNode quantityNode = FocusNode();

  var totalController = TextEditingController();
  final FocusNode priceNode = FocusNode();
  final TextEditingController addressController = TextEditingController();

  final FocusNode playerNumberNode = FocusNode();
  final TextEditingController linkController = TextEditingController();
  final Product product;
  final FocusNode playerNameNode = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey();

  final ProductsBloc homeBloc = ProductsBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => homeBloc,
      child: Scaffold(
        body: MainBackGraundWidget(
          child: SafeArea(
            child: Column(
              children: [
                HeaderTitleWidget(
                  title: product.name!,
                ),
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    children: [
                      SingleImageWidget(image: Urls.storage + product.image!),
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
                                            totalController.text = formatNumber(
                                                (int.parse(p0) *
                                                    product.userPrice));
                                          }
                                        },
                                        validator: (p0) {
                                          if (double.parse(p0!) <
                                              product.minimumQut) {
                                            return product.minimumQutNote;
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
                                        validatorMessage:
                                            "Please enter your quantity"
                                                .tr(context),
                                        isValidator: true,
                                        textInputType: TextInputType.number,
                                        focusNode: quantityNode,
                                        controller: quantityController),
                                  ),
                                  Expanded(
                                    child: TextFalidWithTilteWidget(
                                        validator: (p0) {
                                          if (p0!.isEmpty) {
                                            return "this field is required"
                                                .tr(context);
                                          }
                                          return null;
                                        },
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
                                      return product.note;
                                    }
                                    return null;
                                  },
                                  title: "Wallet address".tr(context),
                                  hintText:
                                      "${"Enter Your".tr(context)} ${"Address".tr(context)}",
                                  validatorMessage:
                                      "Please enter your link".tr(context),
                                  isValidator: true,
                                  textInputType: TextInputType.name,
                                  focusNode: playerNameNode,
                                  controller: addressController),
                              SizedBox(
                                height: 2.h,
                              ),
                              BlocConsumer<ProductsBloc, HomeState>(
                                listener: (context, state) {
                                  if (state is OrderSuccessfulState) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      backgroundColor: Colors.green,
                                      duration: const Duration(seconds: 5),
                                      content: Text(
                                          "The order has been sent successfully"
                                              .tr(context)),
                                    ));
                                    // Navigator.pushAndRemoveUntil(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) => HomePage(),
                                    //     ),
                                    //     (route) => false);
                                    // BlocProvider<ProfileBloc>.of(context).ProfileBloc()..add(ProfileEvent())
                                    BlocProvider.of<ProfileBloc>(context)
                                        ..add(ProfileEvent());
                                    Navigator.pop(context);
                                  }

                                  if (state is OrderErrorState) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      backgroundColor: Colors.red,
                                      duration: const Duration(seconds: 5),
                                      content: Text(
                                        state.message!,
                                      ),
                                    ));
                                  }
                                },
                                builder: (context, state) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 3.w),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: state is OrderLoadingState
                                          ? const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : CoustomButton(
                                              onPressed: () {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  homeBloc.add(OrderFiveEvent(
                                                      productId:
                                                          product.id.toString(),
                                                      walletAddress:
                                                          addressController.text
                                                              .trim(),
                                                      quantity:
                                                          quantityController
                                                              .text
                                                              .trim()));
                                                }
                                              },
                                              buttonText: "Buy".tr(context)),
                                    ),
                                  );
                                },
                              )
                            ],
                          )),
                      SizedBox(
                        height: 5.h,
                      )
                    ],
                  ),
                  // shrinkWrap: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
