import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:raghadcell/Core/Constants/app_colors.dart';
import 'package:sizer/sizer.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final Color textColor;
  final TextInputType textInputType;
  final int? maxLine;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final TextInputAction? textInputAction;
  final bool isPhoneNumber;
  final bool isValidator;
  final String? validatorMessage;
  final Color? fillColor;
  final TextCapitalization capitalization;
  final bool isAmount;
  final bool amountIcon;
  final bool? isDense;
  final bool enabled;
  final bool haveSuffixIcon;
  final String? suffixIcon;

  final bool isDescription;
  final bool isPassword;
  final Function(String text)? onChanged;
  final String? prefixIconImage;
  final bool? isPos;

  final bool variant;
  final Color? iconColor;
  final bool hasName;
  final String? Function(String?)? validator;
  final String? initialValue;
  final Widget? textFieldIcon;

  CustomTextField(
      {super.key,
      required this.controller,
      this.isDense,
      this.textColor = AppColors.blackColor,
      this.suffixIcon,
      this.hintText,
      this.enabled = true,
      required this.textInputType,
      this.haveSuffixIcon = false,
      this.maxLine,
      this.focusNode,
      this.iconColor,
      this.nextNode,
      this.textInputAction,
      this.isPhoneNumber = false,
      this.isValidator = false,
      this.validatorMessage,
      this.capitalization = TextCapitalization.none,
      this.fillColor,
      this.isAmount = false,
      this.amountIcon = false,
      this.isDescription = false,
      this.onChanged,
      this.prefixIconImage,
      this.isPassword = false,
      this.isPos = false,
      this.variant = false,
      this.hasName = true,
      this.validator,
      this.initialValue,
      this.textFieldIcon});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(context) {
    return TextFormField(
      initialValue: widget.initialValue,
      cursorColor: AppColors.primaryColor,
      style: TextStyle(color: widget.textColor),
      controller: widget.controller,
      maxLines: widget.maxLine ?? 1,
      textCapitalization: widget.capitalization,
      focusNode: widget.focusNode,
      obscureText: widget.isPassword ? _obscureText : false,
      onChanged: widget.onChanged,
      inputFormatters:
          (widget.textInputType == TextInputType.phone || widget.isPhoneNumber)
              ? <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp('[0-9+]'))
                ]
              : widget.isAmount
                  ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))]
                  : null,
      keyboardType:
          widget.isAmount ? TextInputType.number : widget.textInputType,
      textInputAction: widget.textInputAction ?? TextInputAction.next,
      onFieldSubmitted: (v) {
        FocusScope.of(context).requestFocus(widget.nextNode);
      },
      validator: widget.validator,
      // validator: (input) {

      //   if (widget.hasName == false) {
      //     setState(() {});
      //   }
      //   // if (widget.hasName) {
      //   //   return null;
      //   // }
      //
      // },
      decoration: InputDecoration(
        enabled: widget.enabled,
        prefixIconConstraints: BoxConstraints(
          minWidth: widget.variant ? 5 : 20,
          minHeight: widget.variant ? 5 : 20,
        ),
        prefixIcon: widget.textFieldIcon != null
            // ? Padding(
            // padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            // child: Container(
            //     padding:
            //         EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
            //     // decoration: BoxDecoration(
            //     //     color:
            //     //         AppColors.getPrimarySeconedary().withOpacity(.135)),
            //     child: Image.asset(
            //       widget.prefixIconImage!,
            //       color: widget.iconColor,
            //       width: 20,
            //       height: 20,
            //     )),
            // )
            ? widget.textFieldIcon
            : const SizedBox(),
        suffixIconConstraints: BoxConstraints(
          minWidth: widget.variant
              ? 5
              : widget.isPos!
                  ? 0
                  : 40,
          minHeight: widget.variant ? 5 : 20,
        ),
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: _toggle,
                child: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.borderColor,
                ))
            : widget.haveSuffixIcon
                ? GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 5.w,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(widget.suffixIcon!))),
                    ))
                : const SizedBox.shrink(),
        hintText: widget.hintText ?? '',
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.borderColor, width: 1),
          borderRadius: BorderRadius.circular(2.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.borderColor, width: 1),
          borderRadius: BorderRadius.circular(2.w),
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2.w),
            borderSide: const BorderSide(color: Colors.red)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2.w),
            borderSide:
                const BorderSide(color: AppColors.borderColor, width: 1)),
        filled: widget.fillColor != null,
        fillColor: widget.fillColor,
        isDense: widget.isDense,
        contentPadding: EdgeInsets.symmetric(
            vertical: 10.0, horizontal: widget.variant ? 0 : 10),
        alignLabelWithHint: true,
        counterText: '',
        hintStyle: TextStyle(color: AppColors.blackColor, fontSize: 10.sp),
        errorStyle: const TextStyle(height: 1.5),
      ),
    );
  }
}
