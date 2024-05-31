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
import 'package:raghadcell/Core/Widgets/single_image_widget.dart';
import 'package:raghadcell/Core/Widgets/text_falid_with_title_widget.dart';
import 'package:raghadcell/Core/function/functions.dart';
import 'package:raghadcell/Feature/Home/Presentation/Pages/home_page.dart';
import 'package:raghadcell/Feature/Home/bloc/products_bloc/products_bloc.dart';
import 'package:raghadcell/Feature/SideMenu/blocs/profile_bloc/profile_bloc.dart';
import 'package:sizer/sizer.dart';

class ProductThreePage extends StatelessWidget {
  ProductThreePage({super.key, required this.product});
  final TextEditingController numberController = TextEditingController();

  final FocusNode numberNode = FocusNode();

  final FocusNode totalNode = FocusNode();
  final TextEditingController emailController = TextEditingController();

  final FocusNode emailNode = FocusNode();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode passwordNode = FocusNode();
  final TextEditingController contactNumberController = TextEditingController();
  final FocusNode playerNumberNode = FocusNode();
  final TextEditingController playerNumberController = TextEditingController();
  final FocusNode contactNumberNode = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey();
  final product;
  final TextEditingController playerNameController = TextEditingController();
  late final TextEditingController quantityController =
      TextEditingController(text: "${product.minimumQut}");
  late final TextEditingController totalController = TextEditingController(
      text: formatNumber(
          (int.parse(quantityController.text) * product.userPrice)));

  final FocusNode playerNameNode = FocusNode();
  late final ProductsBloc homeBloc = ProductsBloc();

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

                                          // totalController.text =
                                          //     '${int.parse(p0) * product.userPrice}\$';
                                        }
                                      },
                                      validator: (p0) {
                                        if (double.parse(p0!) <
                                            product.minimumQut) {
                                          return product.minimumQutNote;
                                        }

                                        if (p0.isEmpty) {
                                          return "this field is required";
                                        }

                                        return null;
                                      },
                                      title: "Quantity".tr(context),
                                      hintText:
                                          "${"Enter Your".tr(context)} ${"Number".tr(context)}",
                                      validatorMessage:
                                          "Please enter your number"
                                              .tr(context),
                                      isValidator: true,
                                      textInputType: TextInputType.number,
                                      focusNode: numberNode,
                                      controller: quantityController),
                                ),
                                Expanded(
                                  child: TextFalidWithTilteWidget(
                                      title: "Total".tr(context),
                                      enable: false,
                                      textColor: AppColors.whiteColor,
                                      fillColor: AppColors.borderColor,
                                      focusNode: totalNode,
                                      controller: totalController),
                                ),
                              ],
                            ),
                            TextFalidWithTilteWidget(
                                validator: (p0) {
                                  if (p0!.isEmpty) {
                                    return "Please Enter Your Email"
                                        .tr(context);
                                  }
                                  return null;
                                },
                                title: "E-mail".tr(context),
                                validatorMessage:
                                    "Please enter E-mail or Phone".tr(context),
                                textInputType: TextInputType.emailAddress,
                                isValidator: true,
                                isPassword: false,
                                focusNode: emailNode,
                                controller: emailController),
                            TextFalidWithTilteWidget(
                                title: "Password (Optional)".tr(context),
                                hintText:
                                    "${"Enter Your".tr(context)} ${"Password (Optional)".tr(context)}",
                                textInputType: TextInputType.visiblePassword,
                                isPassword: true,
                                focusNode: passwordNode,
                                controller: passwordController),
                            TextFalidWithTilteWidget(
                                validator: (p0) {
                                  if (p0!.isEmpty) {
                                    return "please enter Contact number"
                                        .tr(context);
                                  }
                                  return null;
                                },
                                title: "Contact number".tr(context),
                                hintText:
                                    "${"Enter Your".tr(context)} ${"Contact number".tr(context)}",
                                textInputType: TextInputType.number,
                                isValidator: true,
                                focusNode: contactNumberNode,
                                controller: contactNumberController),
                            product.thPartyApiId != null ||
                                    product.requirePlayerNumber == 1
                                ? TextFalidWithTilteWidget(
                                    onChanged: (p0) {
                                      playerNameController.text = "";
                                    },
                                    validator: (p0) {
                                      // if (hasName == false || hasName == null) {
                                      //   return "The player number must be correct.";
                                      // } else
                                      if (p0!.isEmpty) {
                                        return "Please enter player number"
                                            .tr(context);
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
                                // print(state);
                                if (state is PlayerNumberState) {
                                  if (state.message != "") {
                                    playerNameController.text = state.message;
                                  }
                                }
                              },
                              builder: (context, state) {
                                return Visibility(
                                    visible: product.thPartyApiId != null &&
                                            product.requirePlayerNumber == 0
                                        ? true
                                        : false,
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
                                                  productPartyApi:
                                                      product.thPartyApiId));
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
                                      "The order has been sent successfully"
                                          .tr(context),
                                    ),
                                  ));
                                  //  Navigator.pushAndRemoveUntil(
                                  //     context, MaterialPageRoute(builder: (context) => HomePage(),), (route) => false);
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
                                                  homeBloc.hasName!) {
                                                homeBloc.add(OrderThreeEvent(
                                                    emailOrPhoneNumber:
                                                        emailController.text
                                                            .trim(),
                                                    password: passwordController
                                                        .text
                                                        .trim(),
                                                    contactNumber:
                                                        contactNumberController
                                                            .text
                                                            .trim(),
                                                    packageId: product.id!,
                                                    playerNumber:
                                                        playerNumberController
                                                            .text
                                                            .trim(),
                                                    quantity: quantityController
                                                        .text
                                                        .trim(),
                                                    playerName:
                                                        playerNameController
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
    );
  }
}
