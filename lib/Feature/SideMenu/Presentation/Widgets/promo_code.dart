import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raghadcell/App/app_localizations.dart';
import 'package:raghadcell/Core/Constants/app_colors.dart';
import 'package:raghadcell/Core/Widgets/coustom_button.dart';
import 'package:raghadcell/Core/Widgets/coustom_text_falid.dart';
import 'package:raghadcell/Core/Widgets/text_falid_with_title_widget.dart';
import 'package:raghadcell/Feature/SideMenu/blocs/deposit_bloc/bloc/shopping_value_bloc.dart';
import 'package:raghadcell/Feature/SideMenu/blocs/deposit_bloc/deposit_bloc.dart';
import 'package:sizer/sizer.dart';

class PromoCode extends StatelessWidget {
  PromoCode({super.key});
  final TextEditingController codeController = TextEditingController();
  final FocusNode codeNode = FocusNode();
  // final ShoppingValueBloc shoppingValue = ShoppingValueBloc();
  final TextEditingController shoppingValueController = TextEditingController();
  final FocusNode shoppingValueNode = FocusNode();
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final DepositBloc depositBloc = DepositBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => depositBloc,
      child: ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        children: [
          Form(
            key: globalKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: CustomTextField(
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return "this field is required".tr(context);
                  }
                  return null;
                },
                controller: codeController,
                enabled: true,
                textInputType: TextInputType.emailAddress,
                // textColor: AppColors.whiteColor,
                fillColor: AppColors.whiteColor,
                focusNode: codeNode,
                hintText: "Enter Code".tr(context),
                validatorMessage: "",
              ),
            ),
          ),
          BlocConsumer<ShoppingValueBloc, ShoppingValueState>(
            listener: (context, state) {
              // print(state);
              if (state is ShoppingValueCheckState) {
                if (state.message != "") {
                  shoppingValueController.text = state.message;
                }
              }
            },
            builder: (context, state) {
              return TextFalidWithTilteWidget(
                  widget: MaterialButton(
                    minWidth: 40.w,
                    onPressed: () {
                      if (globalKey.currentState!.validate()) {
                        context
                            .read<ShoppingValueBloc>()
                            .add(ShoppingValueEvent(
                              code: codeController.text.trim(),
                            ));
                      }
                    },
                    height: 6.h,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: AppColors.myRed),
                        borderRadius: BorderRadius.circular(3.w)),
                    child: Row(
                      children: [
                        Text(
                          state is ShoppingValueCheckState && state.isLoading
                              ? "Loading..."
                              : "Shipping value".tr(context),
                          style:
                              TextStyle(fontSize: 12.sp, color: Colors.black87),
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        const Icon(Icons.search),
                      ],
                    ),
                  ),
                  title: "Shipping value".tr(context),
                  enable: false,
                  textInputType: TextInputType.name,
                  focusNode: shoppingValueNode,
                  controller: shoppingValueController);
            },
          ),
          SizedBox(
            height: 3.h,
          ),
          BlocBuilder<DepositBloc, DepositState>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: state is GetDepositInformationLoadingAndErrorState &&
                        state.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : CoustomButton(
                        onPressed: () {
                          if (globalKey.currentState!.validate()) {
                            depositBloc.add(PromoCodeChargingWalletEvent(
                                value: codeController.text.trim()));
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
}
