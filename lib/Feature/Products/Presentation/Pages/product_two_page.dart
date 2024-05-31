// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

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
import 'package:sizer/sizer.dart';

class ProductTwoPage extends StatefulWidget {
  ProductTwoPage({
    super.key,
    required this.product,
  });

  final product;

  @override
  State<ProductTwoPage> createState() => _ProductTwoPageState();
}

class _ProductTwoPageState extends State<ProductTwoPage> {
  late final TextEditingController quantityController =
      TextEditingController(text: "${widget.product.minimumQut}");

  final FocusNode quantityNode = FocusNode();

  late final TextEditingController totalController = TextEditingController(
      text: formatNumber(
          (int.parse(quantityController.text) * widget.product.userPrice)));

  final FocusNode totalNode = FocusNode();

  final TextEditingController playerNumberController = TextEditingController();

  final FocusNode playerNumberNode = FocusNode();

  final TextEditingController playerNameController = TextEditingController();

  final FocusNode playerNameNode = FocusNode();

  final GlobalKey<FormState> formKey = GlobalKey();

  ProductsBloc homeBloc = ProductsBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => homeBloc,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              HeaderTitleWidget(
                title: widget.product.name!,
              ),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  children: [
                    SingleImageWidget(
                        image: Urls.storage + widget.product.image!),
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
                                                  widget.product.userPrice));
                                        }
                                      },
                                      validator: (p0) {
                                        if (double.parse(p0!) <
                                            widget.product.minimumQut!) {
                                          return widget.product.minimumQutNote;
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
                                      fillColor: AppColors.borderColor,
                                      textColor: AppColors.whiteColor,
                                      title: "Total".tr(context),
                                      enable: false,
                                      focusNode: totalNode,
                                      controller: totalController),
                                ),
                              ],
                            ),

                            // TextFalidWithTilteWidget(
                            //     validator: (p0) {
                            //       if (p0!.isEmpty) {
                            //         return "this field is required";
                            //       }
                            //       return null;
                            //     },
                            //     title: "Player number".tr(context),
                            //     hintText:
                            //         "${"Enter Your".tr(context)} ${"Player number".tr(context)}",
                            //     validatorMessage:
                            //         "Please enter player number".tr(context),
                            //     isValidator: true,
                            //     textInputType: TextInputType.number,
                            //     focusNode: playerNumberNode,
                            //     controller: playerNumberController),
                            widget.product.thPartyApiId != null ||
                                    widget.product.requirePlayerNumber == 1
                                ? TextFalidWithTilteWidget(
                                    onChanged: (p0) {
                                      playerNameController.text = "";
                                    },
                                    validator: (p0) {
                                      // if (hasName == false || hasName == null) {
                                      //   return "The player number must be correct.";
                                      // } else
                                      if (p0!.isEmpty) {
                                        return "Please enter player number";
                                      }
                                      return null;
                                    },
                                    title: "Player number".tr(context),
                                    hintText:
                                        "${"Enter Your".tr(context)} ${"Player number".tr(context)}",
                                    isValidator: true,
                                    textInputType: TextInputType.number,
                                    focusNode: playerNumberNode,
                                    controller: playerNumberController)
                                : Container(),
                            BlocConsumer<ProductsBloc, HomeState>(
                              listener: (context, state) {
                                if (state is PlayerNumberState) {
                                  if (state.message != "") {
                                    playerNameController.text = state.message;
                                  }
                                }
                              },
                              builder: (context, state) {
                                return Visibility(
                                    visible: widget.product.thPartyApiId !=
                                            null &&
                                        widget.product.requirePlayerNumber == 0,
                                    child: TextFalidWithTilteWidget(
                                        validator: (p0) {
                                          if (p0!.isEmpty) {
                                            return "please enter correct player number"
                                                .tr(context);
                                          }
                                          if (!homeBloc.hasName!) {
                                            return "please enter correct player number"
                                                .tr(context);
                                          }
                                          return null;
                                        },
                                        widget: MaterialButton(
                                          minWidth: 40.w,
                                          onPressed: () {
                                            if (playerNumberController
                                                .value.selection.isValid) {
                                              homeBloc.add(PlayerNumberEvent(
                                                  playerNumber: int.parse(
                                                      playerNumberController
                                                          .text
                                                          .trim()),
                                                  productPartyApi: widget
                                                      .product.thPartyApiId));
                                            }
                                          },
                                          height: 6.h,
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                  color: AppColors.myRed),
                                              borderRadius:
                                                  BorderRadius.circular(3.w)),
                                          child: Row(
                                            children: [
                                              Text(
                                                state is PlayerNumberState &&
                                                        state.isLoading
                                                    ? "Loading...".tr(context)
                                                    : "Search player name"
                                                        .tr(context),
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: Colors.black87),
                                              ),
                                              SizedBox(
                                                width: 3.w,
                                              ),
                                              const Icon(Icons.search)
                                            ],
                                          ),
                                        ),
                                        title: "Player name".tr(context),
                                        enable: false,
                                        textInputType: TextInputType.name,
                                        focusNode: playerNameNode,
                                        controller: playerNameController));
                              },
                            ),

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
                                      "the order has been sent successfully"
                                          .tr(context),
                                    ),
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
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    backgroundColor: Colors.red,
                                    duration: const Duration(seconds: 5),
                                    content: Text(state.message!),
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
                                            child: CircularProgressIndicator(),
                                          )
                                        : CoustomButton(
                                            onPressed: () {
                                              if (formKey.currentState!
                                                      .validate() &&
                                                  (widget.product
                                                              .thPartyApiId ==
                                                          null ||
                                                      homeBloc.hasName!)) {
                                                homeBloc.add(OrderTwoEvent(
                                                  playerName:
                                                      playerNameController.text
                                                          .trim(),
                                                  productId: widget.product.id!,
                                                  playerNumber:
                                                      playerNumberController
                                                          .text
                                                          .trim(),
                                                  quantity: quantityController
                                                      .text
                                                      .trim(),
                                                ));
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
    );
  }
}
