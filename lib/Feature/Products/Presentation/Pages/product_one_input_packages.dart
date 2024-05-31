// ignore_for_file: must_be_immutable, unnecessary_null_comparison

import 'package:flutter/material.dart';
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
import 'package:raghadcell/Feature/Home/models/products_packages_model.dart';
import 'package:sizer/sizer.dart';

class OrdersInput extends StatefulWidget {
  OrdersInput({
    super.key,
    required this.isVisibile,
    required this.productpackage,
  });

  final Package productpackage;

  final bool isVisibile;

  @override
  State<OrdersInput> createState() => _OrdersInputState();
}

class _OrdersInputState extends State<OrdersInput> {
  final TextEditingController quantityController = TextEditingController();

  final FocusNode quantityNode = FocusNode();

  final TextEditingController totalController = TextEditingController(
      text: "0 ${AppSharedPreferences.isUSD ? "\$" : "LBP"}");

  final FocusNode totalNode = FocusNode();

  final TextEditingController playerNumberController = TextEditingController();

  final FocusNode playerNumberNode = FocusNode();

  final FocusNode emailNode = FocusNode();

  final FocusNode passwordNode = FocusNode();

  final FocusNode contactNumberNode = FocusNode();

  final TextEditingController emailController = TextEditingController(
      text: AppSharedPreferences.preferences.getString("phoneNumber"));

  final TextEditingController passwordController = TextEditingController(
      text: AppSharedPreferences.preferences.getString("password"));

  final TextEditingController playerNameController = TextEditingController();

  final TextEditingController contactNumberController = TextEditingController();

  final FocusNode playerNameNode = FocusNode();

  final GlobalKey<FormState> formKey = GlobalKey();

  late final ProductsBloc homeBloc = ProductsBloc();

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
                  title: widget.productpackage.name!,
                ),
                Expanded(
                  child: NestedScrollView(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return <Widget>[
                        SliverAppBar(
                          backgroundColor: Colors.transparent,
                          title: SingleImageWidget(
                              image: "${Urls.storage}/${widget.productpackage.image}"),
                          centerTitle: true,
                          expandedHeight: 20.h,
                          floating: false,
                          pinned: false,
                          toolbarHeight: 30.h,
                          automaticallyImplyLeading: false,
                        )
                      ];
                    },
                    body: ListView(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      children: [
                        // TilteWidget(tilte: "Packages".tr(context)),
                        Form(
                            key: formKey,
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  textDirection: TextDirection.ltr,
                                  children: [
                                    Expanded(
                                      child: TextFalidWithTilteWidget(
                                          onChanged: (p0) {
                                            if (p0 != "") {

                                                totalController.text = formatNumber((int.parse(p0) * widget.productpackage.userPrice));


                                              // totalController.text =
                                              //     '${int.parse(p0) * productpackage.userPrice}${AppSharedPreferences.isUSD ? "\$" : "LBP"}';
                                            }
                                            if (p0 == "") {
                                              totalController.text =
                                                  "0 ${AppSharedPreferences.isUSD ? "\$" : "LBP"}";
                                            }
                                          },
                                          validator: (p0) {
                                            // if (double.parse(p0!) <
                                            //     product.minimumQut) {
                                            //   return product.minimumQutNote;
                                            // }

                                            if (p0!.isEmpty) {
                                              return "this field is required"
                                                  .tr(context);
                                            }

                                            return null;
                                          },
                                          title: "Quantity".tr(context),
                                          hintText: "1234....",
                                          validatorMessage:
                                              "Please enter your number"
                                                  .tr(context),
                                          isValidator: true,
                                          textInputType: TextInputType.number,
                                          focusNode: quantityNode,
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

                                widget.productpackage.isTiktok == 1
                                    ? TextFalidWithTilteWidget(
                                        validator: (p0) {
                                          if (p0!.isEmpty) {
                                            return "this field is required";
                                          }

                                          return null;
                                        },
                                        title: "E-mail or phone number"
                                            .tr(context),
                                        hintText:
                                            "${"Enter Your".tr(context)} ${"E-mail".tr(context)}",
                                        validatorMessage:
                                            "Please enter E-mail or Phone"
                                                .tr(context),
                                        textInputType:
                                            TextInputType.emailAddress,
                                        isValidator: true,
                                        isPassword: false,
                                        focusNode: emailNode,
                                        controller: emailController)
                                    : Container(),
                                widget.productpackage.isTiktok == 1
                                    ? TextFalidWithTilteWidget(
                                        title:
                                            "Password (Optional)".tr(context),
                                        hintText:
                                            "${"Enter Your".tr(context)} ${"Password (Optional)".tr(context)}",
                                        textInputType:
                                            TextInputType.visiblePassword,
                                        isPassword: true,
                                        focusNode: passwordNode,
                                        controller: passwordController)
                                    : Container(),
                                widget.productpackage.isTiktok == 1
                                    ? TextFalidWithTilteWidget(
                                        validator: (p0) {
                                          if (p0!.isEmpty) {
                                            return "this field is required"
                                                .tr(context);
                                          }
                                          if (p0.length < 10) {
                                            return "the length must not less than 10"
                                                .tr(context);
                                          }

                                          return null;
                                        },
                                        title: "Contact number".tr(context),
                                        hintText:
                                            "${"Enter Your".tr(context)} ${"Contact number".tr(context)}",
                                        textInputType: TextInputType.number,
                                        isValidator: true,
                                        validatorMessage:
                                            "please enter Contact number"
                                                .tr(context),
                                        focusNode: contactNumberNode,
                                        controller: contactNumberController)
                                    : Container(),
                                widget.productpackage.thPartyApiId != null ||
                                        widget.productpackage.requirePlayerNumber == 1
                                    ? TextFalidWithTilteWidget(
                                        onChanged: (p0) {
                                          playerNameController.text = "";
                                        },
                                        validator: (p0) {
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
                                        playerNameController.text =
                                            state.message;
                                      }
                                    }
                                  },
                                  builder: (context, state) {
                                    return Visibility(
                                        visible: widget.productpackage.thPartyApiId !=
                                                    null &&
                                                widget.productpackage
                                                        .requirePlayerNumber == 0,
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
                                                          widget.productpackage
                                                              .thPartyApiId));
                                                }
                                              },
                                              height: 6.h,
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                      color: AppColors.myRed),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          3.w)),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    state is PlayerNumberState &&
                                                            state.isLoading
                                                        ? "Loading..."
                                                            .tr(context)
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
                                //599522922
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
                                      Navigator.pushAndRemoveUntil(
                                      context, MaterialPageRoute(builder: (context) => HomePage(),), (route) => false);
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
                                                          .validate()&&
                                                      (widget.productpackage.thPartyApiId == null || homeBloc.hasName!)) {
                                                    homeBloc.add(OrderOneEvent(
                                                        emailOrPhoneNumber:
                                                            emailController.text
                                                                .trim(),
                                                        password:
                                                            passwordController
                                                                .text
                                                                .trim(),
                                                        contactNumber:
                                                            contactNumberController
                                                                .text
                                                                .trim(),
                                                        packageId:
                                                            widget.productpackage.id,
                                                        playerNumber:
                                                            playerNumberController
                                                                .text
                                                                .trim(),
                                                        quantity:
                                                            quantityController
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
