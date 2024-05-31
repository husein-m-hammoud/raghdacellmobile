// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raghadcell/Core/Constants/app_colors.dart';
import 'package:raghadcell/Feature/Home/bloc/products_bloc/products_bloc.dart';
import 'package:raghadcell/Feature/Home/models/products_model.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:sizer/sizer.dart';

class TaggleSwitchWidget extends StatelessWidget {
  TaggleSwitchWidget({super.key, required this.productAdditionalService});
  final List<ProductAdditionalServices> productAdditionalService;

  List<bool> isSelected = [true, false, false];

  // List<String> selectedItem = ["Followers", "Likes", "Comments"];
  final ProductsBloc productsBloc = ProductsBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => productsBloc,
      child: BlocBuilder<ProductsBloc, HomeState>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(productAdditionalService.length, (index) {
              return InkWell(
                  splashColor: AppColors.seconedaryColor,
                  borderRadius: BorderRadius.circular(2.w),
                  onTap: () {
                    //set the toggle logic
                    // setState(() {
                    //   for (int indexBtn = 0;
                    //       indexBtn < isSelected.length;
                    //       indexBtn++) {
                    //     if (indexBtn == index) {
                    //       isSelected[indexBtn] = true;
                    //     } else {
                    //       isSelected[indexBtn] = false;
                    //     }
                    //   }
                    // });
                    productsBloc.add(
                        ProductAdditionalServicesIndexSelectedEvent(
                            index: index));
                  },
                  child: Container(
                      width: 27.w,
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.w),
                        border: Border.all(color: AppColors.borderColor),
                      ),
                      child: GradientText(productAdditionalService[index].type!,
                          style: TextStyle(
                            fontSize: 10.sp,
                          ),
                          colors: productsBloc
                                      .productAdditionalServicesIndexSelected ==
                                  index
                              // ? AppColors.linearPrimaryColor
                              ? [Colors.red, Colors.red]
                              : [AppColors.blackColor, AppColors.blackColor])));
            }),
          );
        },
      ),
    );
  }
}
