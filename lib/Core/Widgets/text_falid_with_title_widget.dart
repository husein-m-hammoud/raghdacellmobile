import 'package:flutter/material.dart';
import 'package:flutter/src/services/text_formatter.dart';
import 'package:raghadcell/Core/Constants/app_colors.dart';
import 'package:raghadcell/Core/Widgets/coustom_text_falid.dart';
import 'package:sizer/sizer.dart';

class TextFalidWithTilteWidget extends StatelessWidget {
  final String? initialValue;
  final bool hasName;
  final TextEditingController controller;
  final FocusNode focusNode;
  final String title;
  final bool enable;
  final String? hintText;
  final String? validatorMessage;
  final bool isPassword;
  final TextInputType textInputType;
  final bool isValidator;
  final Color fillColor;
  final Color textColor;
  final bool haveSuffixIcon;
  final String? suffixIcon;
  final Widget? widget;
  final String? Function(String?)? validator;
  final dynamic Function(String)? onChanged;
  const TextFalidWithTilteWidget(
      {this.hintText,
      this.enable = true,
      required this.title,
      this.suffixIcon,
      this.haveSuffixIcon = false,
      this.textColor = AppColors.blackColor,
      this.fillColor = AppColors.whiteColor,
      this.isValidator = false,
      this.textInputType = TextInputType.text,
      this.isPassword = false,
      this.validatorMessage,
      this.onChanged,
      required this.focusNode,
      required this.controller,
      super.key,
      this.widget,
      this.hasName = true,
      this.validator,
      this.initialValue,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: .5.h),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: .5.h),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  title,
                  style:
                      TextStyle(fontSize: 10.sp, color: AppColors.blackColor),
                )),
                widget != null ? widget! : const SizedBox()
              ],
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          CustomTextField(
            initialValue: initialValue,
            validator: validator,
            hasName: hasName,
            onChanged: onChanged,
            controller: controller,
            enabled: enable,
            textInputType: textInputType,
            isValidator: isValidator,
            isPassword: isPassword,
            fillColor: fillColor,
            focusNode: focusNode,
            hintText: hintText,
            validatorMessage: validatorMessage,
            textColor: textColor,
            suffixIcon: suffixIcon,
            haveSuffixIcon: haveSuffixIcon,
            
          ),
        ],
      ),
    );
  }
}
