import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:raghadcell/App/app_localizations.dart';
import 'package:raghadcell/Core/Widgets/custom_scaffold.dart';
import 'package:raghadcell/Feature/Home/bloc/products_bloc/products_bloc.dart';
import 'package:raghadcell/Feature/Products/Presentation/Widgets/products_list.dart';
import 'package:sizer/sizer.dart';

import '../../../../App/app.dart';
import '../../../../Core/Constants/app_colors.dart';
import '../../../../Core/Util/debouncer.dart';

class SearchProductPage extends StatefulWidget {
  const SearchProductPage({super.key});

  @override
  State<SearchProductPage> createState() => _SearchProductPageState();
}

class _SearchProductPageState extends State<SearchProductPage> {
  final _debouncer = Debouncer(milliseconds: 500);
  FocusNode focusNode = FocusNode();
  final TextEditingController searchController = TextEditingController();
  ProductsBloc productsBloc = ProductsBloc();
  @override
  void initState() {
    focusNode.requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(
              AppBar().preferredSize.height + 9.h,
            ),
            child: SafeArea(
              child: Container(
                color: AppColors.logoRed,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBar(
                      elevation: 0.0,
                      backgroundColor: AppColors.logoRed,
                      title: Text(
                        'Search'.tr(context),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp),
                      ),
                      centerTitle: true,
                    
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 4.w),
                    //   child: Text(
                    //     'Search'.tr(context),
                    //     style: TextStyle(
                    //         color: Colors.white,
                    //         fontWeight: FontWeight.bold,
                    //         fontSize: 18.sp),
                    //   ),
                    // ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 2.w),
                      child: TextFormField(
                        focusNode: focusNode,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            suffixIcon: IconButton(
                              iconSize: 25.sp,
                              style: ButtonStyle(
                                  shape: MaterialStatePropertyAll<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(3.w),
                                              topRight: Radius.circular(3.w)))),
                                  backgroundColor:
                                      const MaterialStatePropertyAll<Color>(
                                          AppColors.logoRed)),
                              icon: const Icon(Icons.search),
                              color: Colors.white,
                              onPressed: () {},
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 2.w),
                            hintText: "Search...".tr(context),
                            hintStyle: const TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(3.w),
                                borderSide: BorderSide(
                                    color: AppColors.whiteColor, width: 2.h))),
                        controller: searchController,
                        onChanged: (String input) {
                          _debouncer.run(() {
                            productsBloc.page = 1;
                            productsBloc.refreshController.resetNoData();
                            productsBloc.add(GetProductsEvent(
                                params: '&search=${searchController.text}'));
                          });
                        },
                        textInputAction: TextInputAction.search,
                      ),
                    ),
                  ],
                ),
              ),
            )),
        body: BlocProvider(
          create: (context) => productsBloc..add(GetProductsEvent()),
          child:
              BlocBuilder<ProductsBloc, HomeState>(builder: (context, state) {
            return SafeArea(
              child: Column(
                children: [
                  Expanded(
                      child: state is ProductsLoadingState &&
                              productsBloc.productsModel == null
                          ? const Center(
                              child: CircularProgressIndicator(
                              color: AppColors.logoRed,
                            ))
                          : state is ProductsErrorState
                              ? TextButton(
                                  onPressed: () {
                                    productsBloc.add(GetProductsEvent(
                                        params:
                                            '&search=${searchController.text}'));
                                  },
                                  child: Text(
                                    'Try Again'.tr(context),
                                    style: errorTryAgainStyle,
                                  ))
                              : SmartRefresher(
                                  controller: productsBloc.refreshController,
                                  enablePullUp: true,
                                  onLoading: () {
                                    productsBloc.add(GetProductsEvent(
                                        params:
                                            '&search=${searchController.text}'));
                                  },
                                  child: productsList(
                                      productsModel:
                                          productsBloc.productsModel!),
                                ))
                ],
              ),
            );
          }),
        ));
  }
}
