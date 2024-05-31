import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:raghadcell/Core/Constants/app_colors.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class MyCachedNetworkImage extends StatelessWidget {
  final bool forCard;
  const MyCachedNetworkImage({
    required this.forCard,
    Key? key,
    required this.imageUrl,
  }) : super(key: key);
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        placeholder: (context, url) => Center(
              child: Shimmer.fromColors(
                baseColor: AppColors.borderColor,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  margin:
                      forCard ? null : EdgeInsets.symmetric(horizontal: 2.w),
                  height: forCard ? 15.h : 25.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: AppColors.borderColor),
                      color: Colors.grey,
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(5.w))),
                ),
              ),
            ),
        imageBuilder: (context, imageProvider) => Container(
              margin: forCard ? null : EdgeInsets.symmetric(horizontal: 2.w),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1, color: AppColors.borderColor),
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(5.w)),
                  image: DecorationImage(
                      image: imageProvider, fit: BoxFit.contain)),
              height: forCard ? 15.h : 25.h,
              width: double.infinity,
            ),
        fadeInDuration: const Duration(milliseconds: 4),
        fadeOutDuration: const Duration(milliseconds: 4),
        imageUrl: imageUrl,
        errorWidget: (context, url, error) => Container(
            margin: forCard ? null : EdgeInsets.symmetric(horizontal: 2.w),
            width: double.infinity,
            height: forCard ? 15.h : 25.h,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: AppColors.borderColor),
              borderRadius: BorderRadius.only(topRight: Radius.circular(5.w)),
                                  

              boxShadow: const [
                BoxShadow(
                    color: AppColors.borderColor,
                    blurRadius: 3,
                    offset: Offset(1, 5))
              ],
               color: Colors.white,
            ),
            child: const Icon(Icons.error)));
  }
}
