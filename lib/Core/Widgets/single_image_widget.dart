import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:raghadcell/App/app.dart';
import 'package:raghadcell/Core/Widgets/view_images.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class SingleImageWidget extends StatelessWidget {
  const SingleImageWidget({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
      child: InkWell(
        onTap: () {
          // navigatorKey.currentState!.push(MaterialPageRoute(
          //   builder: (context) => ViewImagesWidget(image: image),
          // ));
        },
        borderRadius: BorderRadius.circular(5.w),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(3.w),
          child: CachedNetworkImage(
            fadeInCurve: Curves.fastEaseInToSlowEaseOut,
            fit: BoxFit.fill,
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
            imageUrl: image,
            height: 25.h,
            placeholder: (context, url) {
              return Shimmer.fromColors(
                  baseColor: const Color.fromARGB(255, 203, 213, 225),
                  highlightColor: Colors.white,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 2.w),
                    color: Colors.amber,
                    height: 25.h,
                    width: double.infinity,
                  ));
            },
          ),
        ),
        // child: Container(
        //   height: 25.h,
        //   width: double.infinity,
        //   decoration: BoxDecoration(
        //       border: Border.all(color: AppColors.borderColor, width: 1),
        //       borderRadius: BorderRadius.circular(5.w),
        //       color: AppColors.borderColor.withOpacity(0.5),
        //       image: DecorationImage(
        //           image: NetworkImage(image), fit: BoxFit.fill)),
        // ),
      ),
    );
  }
}
