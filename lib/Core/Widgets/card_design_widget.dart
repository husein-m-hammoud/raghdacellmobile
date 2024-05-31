// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import 'package:raghadcell/Apis/Urls.dart';
import 'package:raghadcell/App/app_localizations.dart';
import 'package:raghadcell/Core/Constants/app_colors.dart';
import 'package:raghadcell/Core/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../function/functions.dart';

class CardDesignWidget extends StatefulWidget {
  // final Product product;
  final double imageHeight;
  final String image;
  final Function onPressed;
  final String title;
  var subTitle;
  var isAvilable;

  CardDesignWidget(
      {required this.onPressed,
      // required this.product,
      super.key,
      required this.image,
      required this.title,
      this.subTitle,
      this.isAvilable,
      required this.imageHeight});

  @override
  State<CardDesignWidget> createState() => _CardDesignWidgetState();
}

class _CardDesignWidgetState extends State<CardDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      // duration: Duration(milliseconds: 300),

      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(4.w),
      // ),
      elevation: 2,
      child: InkWell(
        highlightColor: Colors.red.withOpacity(0.5),
        splashColor: AppColors.myRed.withOpacity(0.4),
        borderRadius: BorderRadius.circular(5.w),
        onTap: () {
          widget.onPressed();
        },
        child: Stack(
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(3.w),
                    child:widget.image.split('.').last == "svg"?SizedBox(
                      width: double.infinity,
                      child: SvgPicture.network(
                        Urls.storage + widget.image,
                        height: widget.imageHeight,
                        width: double.infinity,
                        placeholderBuilder: (BuildContext context) => Shimmer.fromColors(
                                  baseColor: const Color.fromARGB(255, 203, 213, 225),
                                  highlightColor: Colors.white,
                                  child: Container(
                                    color: Colors.amber,
                                    height: widget.imageHeight,
                                    width: double.infinity,
                                  )),
                      ),
                    ): CachedNetworkImage(
                    width: double.infinity,
                    fadeInCurve: Curves.fastEaseInToSlowEaseOut,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) {
                      return Container(
                        color: Colors.white,
                        width: double.infinity,
                        child: const Icon(
                          Icons.error_outline_outlined,
                          color: Colors.red,
                        ),
                      );
                    },
                    imageUrl: Urls.storage + widget.image,
                    height: widget.imageHeight,
                    placeholder: (context, url) {
                      return Shimmer.fromColors(
                          baseColor: const Color.fromARGB(255, 203, 213, 225),
                          highlightColor: Colors.white,
                          child: Container(
                            color: Colors.amber,
                            height: widget.imageHeight,
                            width: double.infinity,
                          ));
                    },
                  ),
                ),
                Expanded(
                  // height: 40.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 2.w,
                          ),
                          child: Text(
                            widget.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12.sp,),
                          ),
                        ),
                      ),
                      if (widget.subTitle != null)
                        Text(
                          formatNumber(widget.subTitle),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.logoRed,
                              fontSize: 3.7.w,
                              fontWeight: FontWeight.w900),
                        )
                    ],
                  ),
                )
              ],
            ),
            if(widget.isAvilable ==
                0)
            Stack(
              children: [
                Container(
                  height: widget.imageHeight,
                  color: Colors.grey.withOpacity(0.7),
                ),
                Container(
                  margin: EdgeInsets.all(1.w),
                  padding: EdgeInsets.symmetric(horizontal: 1.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.w),
                    color: AppColors.whiteColor,
                  ),
                  child: Text("unavailable".tr(context),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10.sp),),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
