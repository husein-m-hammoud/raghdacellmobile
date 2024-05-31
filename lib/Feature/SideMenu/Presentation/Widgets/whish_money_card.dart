// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:raghadcell/App/app.dart';
import 'package:raghadcell/App/app_localizations.dart';
import 'package:raghadcell/Core/Constants/app_assets.dart';
import 'package:raghadcell/Core/Constants/app_colors.dart';
import 'package:raghadcell/Core/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:raghadcell/Core/Widgets/coustom_button.dart';
import 'package:raghadcell/Core/Widgets/text_falid_with_title_widget.dart';
import 'package:raghadcell/Core/function/functions.dart';
import 'package:raghadcell/Feature/SideMenu/blocs/deposit_bloc/deposit_bloc.dart';
import 'package:sizer/sizer.dart';

class WhishMoneyCardWidget extends StatefulWidget {
  const WhishMoneyCardWidget(
      {super.key,
      required this.wishMonyPhoneNumber,
      required this.whishMoneyTaxPercentage});
  final String wishMonyPhoneNumber;
  final String whishMoneyTaxPercentage;

  @override
  State<WhishMoneyCardWidget> createState() => _WhishMoneyCardWidgetState();
}

class _WhishMoneyCardWidgetState extends State<WhishMoneyCardWidget> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  File? imageFile;
  late final TextEditingController phoneController =
      TextEditingController(text: widget.wishMonyPhoneNumber);

  final FocusNode phoneNode = FocusNode();

  final TextEditingController shoppingValueController = TextEditingController(
      text: "0 ${AppSharedPreferences.isUSD ? "\$" : "LBP"}");

  final TextEditingController valueController = TextEditingController();

  final FocusNode valueNode = FocusNode();

  final TextEditingController photoController = TextEditingController();

  final FocusNode photoNode = FocusNode();
  final DepositBloc depositBloc = DepositBloc();

  final FocusNode shoppingValueNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => depositBloc,
      child: ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            // child: CustomTextField(
            //   controller: phoneController,
            //   enabled: false,
            //   textInputType: TextInputType.text,
            //   isValidator: true,
            //   haveSuffixIcon: true,
            //   suffixIcon: AppAssets.pastIcon,
            //   textColor: AppColors.whiteColor,
            //   fillColor: AppColors.borderColor,
            //   focusNode: phoneNode,
            //   hintText: "Enter your Link",
            //   validatorMessage: "",
            // ),
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.borderColor,
                  borderRadius: BorderRadius.circular(3.w),
                  border: Border.all(color: Colors.black)),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      style: const TextStyle(color: AppColors.whiteColor),
                      enabled: false,
                      controller: phoneController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 2.w),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3.w),
                            borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy),
                    color: Colors.white,
                    onPressed: () {
                      Clipboard.setData(
                          ClipboardData(text: phoneController.text));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Copied Successfully'.tr(context))));
                    },
                  ),
                ],
              ),
            ),
          ),
          Form(
            key: globalKey,
            child: TextFalidWithTilteWidget(
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return "this field is required".tr(context);
                  }

                  return null;
                },
                onChanged: (p0) {
                  if (p0 != "") {
                    // shoppingValueController.text =
                    // formatNumber((int.parse(p0)));
                    int shoppingValue = int.parse(p0);

                    if (widget.whishMoneyTaxPercentage != null) {
                      double percentageValue =
                          double.parse(widget.whishMoneyTaxPercentage) / 100.0;
                      int result =
                          (shoppingValue - (shoppingValue * percentageValue))
                              .toInt();
                      shoppingValueController.text = formatNumber(result);
                    }
                  } else {
                    shoppingValueController.text = "0\$";
                  }
                },
                title: "The Value".tr(context),
                hintText:
                    "${"Enter the Value to be sent".tr(context)} ${AppSharedPreferences.isUSD ? "\$" : "LBP"}",
                validatorMessage: "Please Enter The Value".tr(context),
                textInputType: TextInputType.emailAddress,
                isValidator: true,
                focusNode: valueNode,
                controller: valueController),
          ),
          TextFalidWithTilteWidget(
              enable: false,
              title: "Shipping value".tr(context),
              fillColor: AppColors.borderColor,
              validatorMessage: "Please Enter The Value".tr(context),
              textInputType: TextInputType.emailAddress,
              isValidator: true,
              focusNode: shoppingValueNode,
              controller: shoppingValueController),
          SizedBox(height: 1.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Text("Upload Photo".tr(context)),
          ),
          SizedBox(height: 1.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: MaterialButton(
              height: 5.h,
              color: Colors.white,
              onPressed: () async {
                showButtonSheet(context);
              },
              shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(3.w)),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Upload the notice".tr(context),
                  style:
                      TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          if (imageFile != null)
            Container(
                margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                height: 20.h,
                width: 12.w,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(3.w)),
                child: Image.file(imageFile!))
          else
            Center(
              child: Text("No image".tr(context)),
            ),
          BlocConsumer<DepositBloc, DepositState>(
            listener: (context, state) {
              if (state is GetDepositInformationLoadingAndErrorState) {
                if (state.isLoading && state.message == null) {}
                if (!state.isLoading && state.message == null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.green,
                    duration: const Duration(seconds: 5),
                    content: Text(
                      "the order has been sent successfully".tr(context),
                    ),
                  ));
                  Navigator.of(context).pop(
                      // PageTransition(
                      //     child:  Navigator.pop(context);
                      //     type: PageTransitionType.rightToLeft,
                      //     duration: const Duration(milliseconds: 400)),
                      // (route) => false,
                      );
                }

                if (!state.isLoading && state.message != null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      duration: const Duration(seconds: 5),
                      content: Center(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(state.message!),
                              TextButton(
                                  onPressed: () {
                                    depositBloc.add(
                                        UDSTAndWishMonyChargingWalletEvent(
                                            image: imageFile!.path,
                                            type: "WHISH_MONEY",
                                            value:
                                                valueController.text.trim()));
                                  },
                                  child: Text(
                                    'Try Again'.tr(context),
                                    style: errorTryAgainStyle,
                                  ))
                            ]),
                      )));
                }
              }
            },
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: state is GetDepositInformationLoadingAndErrorState &&
                        state.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : CoustomButton(
                        onPressed: () async {
                          if (globalKey.currentState!.validate() &&
                              imageFile != null) {
                            depositBloc.add(UDSTAndWishMonyChargingWalletEvent(
                                image: imageFile!.path,
                                type: "WHISH_MONEY",
                                value: valueController.text.trim()));
                          }
                        },
                        buttonText: "Send".tr(context)),
              );
            },
          )
        ],
      ),
    );
  }

  showButtonSheet(context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(2.w)),
          height: 15.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      var picked = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (picked != null) {
                        setState(() {
                          imageFile = File(picked.path);
                        });
                        Navigator.of(context).pop();
                      }
                    },
                    child: Container(
                      height: 7.h,
                      width: 15.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.w),
                          image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(AppAssets.galary))),
                    ),
                  ),
                  SizedBox(
                    height: 0.4.h,
                  ),
                  Text(
                    "Gallery",
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () async {
                        var picked = await ImagePicker()
                            .pickImage(source: ImageSource.camera);
                        if (picked != null) {
                          setState(() {
                            imageFile = File(picked.path);
                          });
                          Navigator.of(context).pop();
                        }
                      },
                      child: Container(
                        height: 7.h,
                        width: 15.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.w),
                            image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(AppAssets.camera))),
                      )),
                  SizedBox(
                    height: 0.4.h,
                  ),
                  Text(
                    "Camera",
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
