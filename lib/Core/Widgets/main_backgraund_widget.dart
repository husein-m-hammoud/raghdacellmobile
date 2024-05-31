import 'package:flutter/material.dart';
 
class MainBackGraundWidget extends StatelessWidget {
  const MainBackGraundWidget({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        // decoration: BoxDecoration(
        //     image: DecorationImage(
        //         colorFilter: ColorFilter.mode(
        //             Colors.white.withOpacity(0.2), BlendMode.colorDodge),
        //         image: const AssetImage(AppAssets.logoImage))),
        // padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: child);
  }
}
