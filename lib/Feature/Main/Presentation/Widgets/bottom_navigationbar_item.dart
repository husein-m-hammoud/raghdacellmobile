import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

BottomNavigationBarItem bottomNavigationBarItem(BuildContext context,
    {required int currentIndex, required String icon, required String label}) {
  return BottomNavigationBarItem(
    icon: ImageIcon(
      AssetImage(icon),
      size: 8.w,
    ),
    label: label,
  );
}
