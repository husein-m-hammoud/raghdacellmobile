// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:raghadcell/Core/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:sizer/sizer.dart';

import 'package:raghadcell/Core/Constants/app_colors.dart';

class DropDownWidget extends StatefulWidget {
  final List<String> items;
  final Function(String value) onChange;
  const DropDownWidget({Key? key, required this.items, required this.onChange})
      : super(key: key);

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  String selectedItem = AppSharedPreferences.hasArLang ? "الكل" : "All";

  @override
  Widget build(BuildContext context) {
    print(widget.items);
    return DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
      alignment: Alignment.center,
      iconStyleData: IconStyleData(
          iconDisabledColor: Colors.white, iconEnabledColor: Colors.white),
      items: widget.items
          .map((String item) => DropdownMenuItem<String>(
                alignment: Alignment.center,
                value: item,
                child: Text(
                  item,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ))
          .toList(),
      value: selectedItem,
      onChanged: (value) {
        if (value != null) {
          widget.onChange(value);
        }
        setState(() {
          selectedItem = value!;
        });
      },
      buttonStyleData: ButtonStyleData(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.w),
            gradient:
                const LinearGradient(colors: AppColors.linearPrimaryColor)),
        elevation: 2,
      ),
      dropdownStyleData: DropdownStyleData(
        padding: EdgeInsets.only(left: 2.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.w),
            gradient:
                const LinearGradient(colors: AppColors.linearPrimaryColor)),
      ),
      menuItemStyleData: MenuItemStyleData(
        height: 40,
        padding: EdgeInsets.only(left: 2.w, right: 2.w),
      ),
    ));
  }
}
