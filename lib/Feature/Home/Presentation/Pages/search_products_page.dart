// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:raghadcell/App/app_localizations.dart';
// import 'package:raghadcell/Core/Constants/app_colors.dart';
// import 'package:raghadcell/Core/Widgets/card_design_widget.dart';
// import 'package:raghadcell/Feature/Home/bloc/products_search_bloc/product_search_bloc.dart';
// import 'package:sizer/sizer.dart';

// class SearchProducts extends StatelessWidget {
//   SearchProducts({super.key});
//   final TextEditingController searchController = TextEditingController();
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   final ProductSearchBloc productSearchBloc = ProductSearchBloc();
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => productSearchBloc,
//       child: Scaffold(
//         body: SafeArea(
//             child: Column(
//           // shrinkWrap: true,
//           // physics: const NeverScrollableScrollPhysics(),
//           children: [
//             SizedBox(
//               height: 3.h,
//             ),
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 2.w),
//               decoration: BoxDecoration(
//                   border: Border.all(color: AppColors.blueColor, width: 1.w),
//                   borderRadius: BorderRadius.circular(4.w)),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Form(
//                       key: formKey,
//                       child: TextFormField(
//                         decoration: InputDecoration(
//                             contentPadding:
//                                 EdgeInsets.symmetric(horizontal: 2.w),
//                             hintText: "Search...".tr(context),
//                             border: const UnderlineInputBorder(
//                                 borderSide: BorderSide.none)),
//                         controller: searchController,
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     iconSize: 25.sp,
//                     style: ButtonStyle(
//                         shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
//                             RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.only(
//                                     bottomRight: Radius.circular(3.w),
//                                     topRight: Radius.circular(3.w)))),
//                         backgroundColor: const MaterialStatePropertyAll<Color>(
//                             AppColors.blueColor)),
//                     onPressed: () {
//                       if (formKey.currentState!.validate()) {
//                         // BlocProvider.of<ProductSearchBloc>(context)
//                         productSearchBloc.add(GetProductsSearchEvent(
//                             searchResault: searchController.text.trim()));
//                       }
//                     },
//                     icon: const Icon(Icons.search),
//                     color: Colors.white,
//                   )
//                 ],
//               ),
//             ),
//             BlocBuilder<ProductSearchBloc, ProductSearchState>(
//               builder: (context, state) {
//                 print("state ======================== $state");
//                 if (state is GetProductsSearchState) {
//                   print(state.productsSearchResaultModel);
//                   return GridView.builder(
//                     shrinkWrap: true,
//                     physics: const AlwaysScrollableScrollPhysics(),
//                     padding: EdgeInsets.symmetric(horizontal: 2.w),
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 3, // Number of items per row
//                       childAspectRatio: 0.9, // Aspect ratio for grid items
//                       crossAxisSpacing: 5, // Spacing between items horizontally
//                       mainAxisSpacing: 10, // Spacing between items vertically
//                     ),
//                     itemCount:
//                         state.productsSearchResaultModel.productResault!.length,
//                     itemBuilder: (context, index) {
//                       return CardDesignWidget(
//                         imageHeight: 10.h,
//                         isAvilable: state.productsSearchResaultModel
//                             .productResault![index].available,
//                         image: state.productsSearchResaultModel
//                             .productResault![index].image!,
//                         title: state.productsSearchResaultModel
//                             .productResault![index].name!,
//                         onPressed: () {},
//                       );
//                     },
//                   );
//                 } else if (state is ProductsSearchLoadingState) {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 } else if (state is ProductsSearchErrorState) {
//                   return Center(
//                       child: Text(
//                     state.message,
//                     style: TextStyle(fontSize: 12.sp),
//                   ));
//                 } else if (state is InitProductsSearch) {
//                   return Center(child: Text(state.message.tr(context)));
//                 } else {
//                   return Text("Error".tr(context));
//                 }
//               },
//             ),
//           ],
//         )),
//       ),
//     );
//   }
// }
