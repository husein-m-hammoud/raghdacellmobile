import 'package:flutter/material.dart';
import 'package:raghadcell/App/app_localizations.dart';
import 'package:raghadcell/Core/Constants/app_colors.dart';
import 'package:raghadcell/Core/Dialogs/bad_dialog.dart';
import 'package:raghadcell/Core/Widgets/coustom_button.dart';
import 'package:raghadcell/Core/Widgets/text_falid_with_title_widget.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'package:sizer/sizer.dart';

confirmDialog(BuildContext context,
    {required TextEditingController priceController,
    required TextEditingController quantityController,
    required TextEditingController socialLinkController,
    required FocusNode quantityNode,
    required FocusNode priceNode,
    required FocusNode socialLinkNode}) {
  AlertDialog alertDialog = AlertDialog(
    elevation: 1,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.w),
        side: const BorderSide(width: 2, color: AppColors.primaryColor)),
    content: SizedBox(
      height: 50.h,
      width: 90.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFalidWithTilteWidget(
               fillColor: AppColors.borderColor,
                            textColor: AppColors.whiteColor,
              title: "Quantity".tr(context),
              enable: false,
              focusNode: quantityNode,
              controller: quantityController),
          TextFalidWithTilteWidget(
               fillColor: AppColors.borderColor,
                            textColor: AppColors.whiteColor,
              title: "Price".tr(context),
              enable: false,
              focusNode: priceNode,
              controller: priceController),
          TextFalidWithTilteWidget(
               fillColor: AppColors.borderColor,
                            textColor: AppColors.whiteColor,
              title: "Social Link".tr(context),
              enable: false,
              focusNode: socialLinkNode,
              controller: socialLinkController),
          SizedBox(
            height: 3.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.w),
                    border: Border.all(color: AppColors.borderColor, width: 1)),
                child: MaterialButton(
                    //height: 6.h,

                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.w)),
                    // color: buttonColor,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: GradientText("Cancel".tr(context),
                        style: TextStyle(
                          fontSize: 12.sp,
                        ),
                        colors: AppColors.linearPrimaryColor)),
              ),
              CoustomButton(
                  onPressed: () {
                    showBadDialog(context,
                        message: "Your balance is not enough, please top up"
                            .tr(context));
                  },
                  buttonText: "Confirm".tr(context))
            ],
          )
        ],
      ),
    ),
  );
  showDialog(
    barrierDismissible: false,
    useSafeArea: true,
    context: context,
    builder: (BuildContext context) {
      return alertDialog;
    },
  );
}
