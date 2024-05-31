import 'package:flutter/material.dart';
import 'package:raghadcell/Core/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:sizer/sizer.dart';

import 'package:raghadcell/Core/Constants/app_assets.dart';
import 'package:raghadcell/Core/Constants/app_colors.dart';

class TogglePaymentCardsWidget extends StatefulWidget {
  final List<bool> isSelected;
  final Function(int) onTap;

  const TogglePaymentCardsWidget(
      {Key? key, required this.isSelected, required this.onTap})
      : super(key: key);

  @override
  State<TogglePaymentCardsWidget> createState() =>
      _TogglePaymentCardsWidgetState();
}

class _TogglePaymentCardsWidgetState extends State<TogglePaymentCardsWidget> {
  List<String> selectedItem = [
    if (AppSharedPreferences.isUSD) "USDT-TRC20",
    "Whish Money",
    "Code"
  ];
  List<String> selectedImage = [
    if (AppSharedPreferences.isUSD) AppAssets.tIcon,
    AppAssets.wIcon,
    AppAssets.promocode
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(widget.isSelected.length, (index) {
        return InkWell(
            splashColor: AppColors.seconedaryColor,
            borderRadius: BorderRadius.circular(20.w),
            onTap: () {
              //set the toggle logic
              setState(() {
                for (int indexBtn = 0;
                    indexBtn < widget.isSelected.length;
                    indexBtn++) {
                  if (indexBtn == index) {
                    widget.isSelected[indexBtn] = true;
                    widget.onTap(index);
                  } else {
                    widget.isSelected[indexBtn] = false;
                  }
                }
              });
            },
            child: Container(
                height: 12.h,
                width: 24.w,
                alignment: Alignment.center,
                // padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // borderRadius: BorderRadius.circular(2.w),
                  border: Border.all(
                      color: widget.isSelected[index]
                          ? AppColors.primaryColor
                          : Colors.transparent,
                      width: 2
                      // ? 2 : 1
                      ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage(selectedImage[index]),
                      height: 6.h,
                      width: 10.w,
                    ),
                    Text(
                      selectedItem[index],
                      style: TextStyle(
                        fontSize: 8.sp,
                      ),
                    ),
                  ],
                )));
      }),
    );
  }
}
