import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raghadcell/Apis/Urls.dart';
import 'package:raghadcell/App/app.dart';
import 'package:raghadcell/App/app_localizations.dart';
import 'package:raghadcell/Core/Constants/app_colors.dart';

import 'package:raghadcell/Feature/Home/bloc/products_bloc/products_bloc.dart';
import 'package:shimmer/shimmer.dart';

import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselSliderImages extends StatefulWidget {
  const CarouselSliderImages({super.key});

  // final List<String> images;

  // const CarouselSliderImages({required this.images, super.key});

  @override
  State<CarouselSliderImages> createState() => _CarouselSliderImagesState();
}

class _CarouselSliderImagesState extends State<CarouselSliderImages> {
  int activeIndex = 0;

  CarouselController carouselController = CarouselController();
  ProductsBloc homeBloc = ProductsBloc()..add(GetSliderImageEvent());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => homeBloc,
      child: Column(
        children: [
          BlocBuilder<ProductsBloc, HomeState>(
            builder: (context, state) {
              if (state is SliderImageErrorState) {
                return Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.message),
                        TextButton(
                            onPressed: () {
                              homeBloc.add(GetSliderImageEvent());
                            },
                            child: Text(
                              'Try Again'.tr(context),
                              style: errorTryAgainStyle,
                            ))
                      ]),
                );
              }
              if (state is GetSliderImageState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CarouselSlider.builder(
                        carouselController: carouselController,
                        itemCount: state.sliderImageModel.images!.length,

                        itemBuilder: (context, index, realIndex) {
                          return InkWell(
                            // onTap: () {
                            //   navigatorKey.currentState!.push(MaterialPageRoute(
                            //     builder: (context) => ViewImagesWidget(
                            //       images: widget.images,
                            //       activeIndex: index,
                            //     ),
                            //   ));
                            // },
                            // child: Container(
                            //   margin: EdgeInsets.symmetric(horizontal: 2.w),
                            //   decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(4.w),
                            //       // color: Colors.white,
                            //       border: Border.all(
                            //           width: 1, color: AppColors.borderColor),
                            //       image: DecorationImage(
                            //           image: NetworkImage(Urls.storage +
                            //               state.sliderImageModel.images![index]
                            //                   .image!),
                            //           fit: BoxFit.fill)),
                            //   height: 25.h,
                            //   width: double.infinity,
                            // ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(3.w),
                              child: CachedNetworkImage(
                                fadeInCurve: Curves.fastEaseInToSlowEaseOut,
                                fit: BoxFit.fill,
                                errorWidget: (context, url, error) {
                                  return Container(
                                    color: Colors.white,
                                    width: double.infinity,
                                    child: Column(
                                      children: [
                                        const Icon(
                                          Icons.error_outline_outlined,
                                          color: Colors.red,
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              homeBloc
                                                  .add(GetSliderImageEvent());
                                            },
                                            child: Text(
                                              'Try Again'.tr(context),
                                              style: errorTryAgainStyle,
                                            ))
                                      ],
                                    ),
                                  );
                                },
                                imageUrl: Urls.storage +
                                    state
                                        .sliderImageModel.images![index].image!,
                                height: 25.h,
                                placeholder: (context, url) {
                                  return Shimmer.fromColors(
                                      baseColor: const Color.fromARGB(
                                          255, 203, 213, 225),
                                      highlightColor: Colors.white,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3.w),
                                          color: Colors.amber,
                                        ),
                                        // margin: EdgeInsets.symmetric(
                                        //     horizontal: 2.w),

                                        height: 25.h,
                                        width: double.infinity,
                                      ));
                                },
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          // scrollPhysics: const NeverScrollableScrollPhysics(),
                          enableInfiniteScroll: false,
                          height: 25.h,
                          enlargeCenterPage: true,
                          autoPlay: true,

                          viewportFraction: 1,

                          onPageChanged: (index, reason) {
                            return setState(() => activeIndex = index);
                          },
                          autoPlayInterval: const Duration(seconds: 5)
                        )),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedSmoothIndicator(
                            activeIndex: activeIndex,
                            count: state.sliderImageModel.images!.length,
                            effect: const ExpandingDotsEffect(
                              dotHeight: 10,
                              dotWidth: 10,
                              dotColor: AppColors.borderColor,
                              activeDotColor: AppColors.primaryColor,
                            ))
                      ],
                    )
                  ],
                );
              } else {
                return Shimmer.fromColors(
                    // baseColor: Colors.white,
                    // highlightColor: const Color.fromARGB(255, 109, 100, 100),
                    baseColor: const Color.fromARGB(255, 203, 213, 225),
                    highlightColor: Colors.white,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 2.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.w),
                        color: Colors.white,
                        border:
                            Border.all(width: 1, color: AppColors.borderColor),
                      ),
                      // height: 25.h,

                      height: 25.h,
                      width: double.infinity,
                    ));
              }
            },
          ),
        ],
      ),
    );
  }
}
