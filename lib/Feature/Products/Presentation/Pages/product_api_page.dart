// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raghadcell/Apis/Urls.dart';
import 'package:raghadcell/App/app_localizations.dart';
import 'package:raghadcell/Core/Constants/app_colors.dart';
import 'package:raghadcell/Core/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:raghadcell/Core/Widgets/coustom_button.dart';
import 'package:raghadcell/Core/Widgets/header_title_widget.dart';
import 'package:raghadcell/Core/Widgets/single_image_widget.dart';
import 'package:raghadcell/Core/Widgets/text_falid_with_title_widget.dart';
import 'package:raghadcell/Core/function/functions.dart';
import 'package:raghadcell/Feature/Home/Presentation/Pages/home_page.dart';
import 'package:raghadcell/Feature/Home/bloc/products_bloc/products_bloc.dart';
import 'package:raghadcell/Feature/Home/models/products_packages_model.dart';
import 'package:raghadcell/Feature/SideMenu/blocs/profile_bloc/profile_bloc.dart';
import 'package:sizer/sizer.dart';
//import 'package:dio/dio.dart' as dio;

// class FormData {
//   String name;
//   String value;

//   FormData({required this.name, required this.value});

//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'value': value,
//     };
//   }
// }

class ProductApiPage extends StatefulWidget {
  //var package;
  ProductApiPage({super.key, required this.product, this.package});

  final product;
  final Package? package;

  @override
  State<ProductApiPage> createState() => _ProductApiPageState();
}

class _ProductApiPageState extends State<ProductApiPage> {
  dynamic selectedPackage;
  late final Completer<void> _loadingCompleter;
  List<FormData> formData = [];
  late ProductsBloc packages;
  bool _isLoading = true;
  late Map<dynamic, dynamic> requirementsData = {};

  @override
  void initState() {
    super.initState();
    if (widget.package != null) {
      selectedPackage = widget.package;
      if (selectedPackage.requirements != null) {
        selectedPackage.requirements =
            json.decode(selectedPackage.requirements);
      }
      setState(() {
        _isLoading = false;
      });
    } else {
      _loadingCompleter = Completer<void>();

      _loadPackages;
      packages =
          context.read<ProductsBloc>(); // Assuming you're using BlocProvider

      packages = ProductsBloc()
        ..add(GetProductsPackagesEvent(productId: widget.product.id!));
      // Fetch packages from API
      // For demonstration purpose, I'm assuming you're using GetProductsPackagesEvent
      // You need to replace this with your actual API call
      // Assuming GetProductsPackagesEvent returns a list of packages
      print('selectedPackage1');
      print(packages);
      packages.stream.listen((state) {
        print('selectedPackage2');
        print(state);
        if (state is GetProductsPackagesState) {
          print('selectedPackage3');
          print(state.productsPackagesModel.data![0].id);
          setState(() {
            selectedPackage = state.productsPackagesModel.data != null
                ? state.productsPackagesModel.data![0]
                : null;

            // selectedPackage.requirement = selectedPackage.requirement != null
            //     ? json.decode(selectedPackage.requirement)
            //     : null;
            try {
              // Attempt to decode the JSON string
              selectedPackage.requirements =
                  selectedPackage.requirements != null
                      ? json.decode(selectedPackage.requirements)
                      : null;
            } catch (e) {
              // Handle any errors that occur during decoding
              print('Error decoding JSON: $e');
              // Optionally, set selectedPackage.requirement to null or another default value
            }
          });

          setState(() {
            _isLoading = false;
          });
        }
      });
      print('selectedPackage');
      print(selectedPackage);
    }
    if (selectedPackage != null && selectedPackage.requirements.isEmpty) {
      setState(() {
        requirementsData = {};
        selectedPackage.requirements.forEach((req) {
          requirementsData[req.name] = {
            'name': req.name,
            'label': req.label,
            // Add other properties as needed
          };
        });
      });
    }
  }

  Future<void> _loadPackages() async {
    final bloc = context.read<ProductsBloc>();
    bloc.add(GetProductsPackagesEvent(productId: widget.product.id!));

    // Wait for the packages to be fetched
    await bloc.stream.where((state) => state is GetProductsPackagesState).first;
    print('bloc');
    print(bloc);
    _loadingCompleter.complete();
    setState(() {
      _isLoading = false;
    });
  }

  late final TextEditingController quantityController =
      TextEditingController(text: "${selectedPackage.minimumQut}");

  final FocusNode quantityNode = FocusNode();

  late final TextEditingController totalController = TextEditingController(
      text: formatNumber(
          (int.parse(quantityController.text) * selectedPackage.userPrice)));

  final FocusNode totalNode = FocusNode();

  final TextEditingController playerNumberController = TextEditingController();

  final FocusNode playerNumberNode = FocusNode();

  final TextEditingController playerNameController = TextEditingController();

  final FocusNode playerNameNode = FocusNode();

  final GlobalKey<FormState> formKey = GlobalKey();

  ProductsBloc homeBloc = ProductsBloc();
  void printFormData() {
    for (var data in formData) {
      print('Name: ${data.name}, Value: ${data.value}');
    }
  }

  @override
  Widget build(BuildContext context) {
    print('hussein1');
    print(requirementsData);
    if (_isLoading) {
        print('hussein loading');
      return Scaffold(
        appBar: AppBar(
          title: Text('Product API Page'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }else if (selectedPackage.isAvailable == 0 || selectedPackage.forceUnavailable == 1) {
       print('hussein222');
         Future.delayed(Duration.zero, () {
    showDialog(
      context: context,
        barrierDismissible: false,
      builder: (BuildContext context) {
        return ProductAvailabilityPopup();
      },
    );
         });
  }else {
      print('hussein33 ');
      print(selectedPackage.requirements);
      formData.add(FormData(
          name: 'product_reference',
          value: selectedPackage.productReference.toString()));
      formData.add(
          FormData(name: 'product_id', value: selectedPackage.id.toString()));
      formData.add(
          FormData(name: 'qty', value: selectedPackage.minimumQut.toString()));
    }
    return BlocProvider(
      create: (context) => homeBloc,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              HeaderTitleWidget(
                title: selectedPackage.name!,
              ),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  children: [
                    SingleImageWidget(
                        image: Urls.storage + selectedPackage.image!),
                    Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Row(
                              textDirection: TextDirection.ltr,
                              children: [
                                Expanded(
                                  child: TextFalidWithTilteWidget(
                                      onChanged: (p0) {
                                        String p0 = quantityController.text
                                            .replaceAll(RegExp(r'[^0-9]'), '');

                                        if (p0 != "") {
                                          if (selectedPackage.maximumQut > 0 &&
                                              int.parse(p0!) >
                                                  selectedPackage.maximumQut!) {
                                            quantityController.text =
                                                selectedPackage.maximumQut
                                                    .toString();
                                            p0 = selectedPackage.maximumQut
                                                .toString();
                                          }

                                          if (selectedPackage.userPercentage >
                                              0) {
                                            totalController
                                                .text = formatNumber((int.parse(
                                                        p0) *
                                                    selectedPackage.userPrice) *
                                                (1 +
                                                    (selectedPackage
                                                            .userPercentage /
                                                        100)));
                                          } else {
                                            totalController.text = formatNumber(
                                                (int.parse(p0) *
                                                    selectedPackage.userPrice));
                                          }

                                          formData.add(
                                              FormData(name: 'qyt', value: p0));
                                        }
                                      },
                                      validator: (p0) {
                                        if (double.parse(p0!) <
                                            selectedPackage.minimumQut!) {
                                          quantityController.text =
                                              selectedPackage.minimumQut
                                                  .toString();

                                          return 'Minimum quantity is' +
                                              selectedPackage.minimumQut
                                                  .toString();
                                        }
                                        if (selectedPackage.maximumQut > 0 &&
                                            int.parse(p0!) >
                                                selectedPackage.maximumQut!) {
                                          quantityController.text =
                                              selectedPackage.maximumQut
                                                  .toString();

                                          return 'Maximum quantity is' +
                                              selectedPackage.maximumQut
                                                  .toString();
                                        }
                                        return null;
                                      },
                                      title: "Quantity".tr(context),
                                      hintText:
                                          "${"Enter Your".tr(context)} ${"Quantity".tr(context)}",
                                      validatorMessage:
                                          "Please enter your quantity"
                                              .tr(context),
                                      isValidator: true,
                                      textInputType: TextInputType.number,
                                      focusNode: quantityNode,
                                      controller: quantityController),
                                ),
                                Expanded(
                                  child: TextFalidWithTilteWidget(
                                      fillColor: AppColors.borderColor,
                                      textColor: AppColors.whiteColor,
                                      title: "Total".tr(context),
                                      enable: false,
                                      focusNode: totalNode,
                                      controller: totalController),
                                ),
                              ],
                            ),

                            // TextFalidWithTilteWidget(
                            //     validator: (p0) {
                            //       if (p0!.isEmpty) {
                            //         return "this field is required";
                            //       }
                            //       return null;
                            //     },
                            //     title: "Player number".tr(context),
                            //     hintText:
                            //         "${"Enter Your".tr(context)} ${"Player number".tr(context)}",
                            //     validatorMessage:
                            //         "Please enter player number".tr(context),
                            //     isValidator: true,
                            //     textInputType: TextInputType.number,
                            //     focusNode: playerNumberNode,
                            //     controller: playerNumberController),
                            selectedPackage.requirements != null &&
                                    selectedPackage.requirements.isNotEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:
                                        selectedPackage.requirements.length,
                                    itemBuilder: (context, index) {
                                      final requirement =
                                          selectedPackage.requirements[index];
                                      final label = requirement['label'];
                                      final name = requirement['name'];
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 3.w,
                                                vertical: .5.h),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  label,
                                                  // Label text color
                                                ),
                                                SizedBox(
                                                    height:
                                                        8), // Add some space between the label and the TextField
                                                TextField(
                                                  decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    hintText:
                                                        'Enter your $label',
                                                  ),
                                                  onChanged: (value) {
                                                    if (name == 'player_id' ||
                                                        name == 'playerId' ||
                                                        name == 'playerid') {
                                                      playerNumberController
                                                          .text = value;
                                                    }
                                                    print(playerNumberController
                                                        .text);

                                                    formData.add(FormData(
                                                        name: requirement[
                                                            'name']!,
                                                        value: value!));

                                                    // Handle value change
                                                    printFormData();
                                                    //print(formData);
                                                  },
                                                  // You can add validators, controller, etc. as needed
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    })
                                : Container(),

                            // selectedPackage.thPartyApiId != null ||
                            //         selectedPackage.requirePlayerNumber == 1
                            //     ? TextFalidWithTilteWidget(
                            //         onChanged: (p0) {
                            //           playerNameController.text = "";
                            //         },
                            //         validator: (p0) {
                            //           // if (hasName == false || hasName == null) {
                            //           //   return "The player number must be correct.";
                            //           // } else
                            //           if (p0!.isEmpty) {
                            //             return "Please enter player number";
                            //           }
                            //           return null;
                            //         },
                            //         title: "Player number".tr(context),
                            //         hintText:
                            //             "${"Enter Your".tr(context)} ${"Player number".tr(context)}",
                            //         isValidator: true,
                            //         textInputType: TextInputType.number,
                            //         focusNode: playerNumberNode,
                            //         controller: playerNumberController)
                            //     : Container(),
                            BlocConsumer<ProductsBloc, HomeState>(
                              listener: (context, state) {
                                if (state is PlayerNumberState) {
                                  if (state.message != "") {
                                    playerNameController.text = state.message;
                                    formData.add(FormData(
                                        name: 'player_number',
                                        value: state.message));
                                  }
                                }
                              },
                              builder: (context, state) {
                                return Visibility(
                                    visible: (selectedPackage.thPartyApiId !=
                                                null ||
                                            selectedPackage.thPartyAs7abApi !=
                                                null) &&
                                        selectedPackage.requirePlayerNumber ==
                                            0,
                                    child: TextFalidWithTilteWidget(
                                        validator: (p0) {
                                          if (p0!.isEmpty) {
                                            return "please enter correct player number"
                                                .tr(context);
                                          }
                                          if (!homeBloc.hasName!) {
                                            return "please enter correct player number"
                                                .tr(context);
                                          }
                                          return null;
                                        },
                                        widget: MaterialButton(
                                          minWidth: 40.w,
                                          onPressed: () {
                                            if (playerNumberController.text !=
                                                "") {
                                              if (selectedPackage
                                                      .thPartyAs7abApi !=
                                                  null) {
                                                homeBloc.add(PlayerNumberEvent(
                                                    playerNumber: int.parse(
                                                        playerNumberController
                                                            .text
                                                            .trim()),
                                                    productPartyApi:
                                                        selectedPackage
                                                            .thPartyAs7abApi,
                                                    isAs7ab: true));
                                              } else {
                                                homeBloc.add(PlayerNumberEvent(
                                                    playerNumber: int.parse(
                                                        playerNumberController
                                                            .text
                                                            .trim()),
                                                    productPartyApi:
                                                        selectedPackage
                                                            .thPartyApiId
                                                            .toString()));
                                              }
                                            }
                                          },
                                          height: 6.h,
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                  color: AppColors.myRed),
                                              borderRadius:
                                                  BorderRadius.circular(3.w)),
                                          child: Row(
                                            children: [
                                              Text(
                                                state is PlayerNumberState &&
                                                        state.isLoading
                                                    ? "Loading...".tr(context)
                                                    : "Search player name"
                                                        .tr(context),
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: Colors.black87),
                                              ),
                                              SizedBox(
                                                width: 3.w,
                                              ),
                                              const Icon(Icons.search)
                                            ],
                                          ),
                                        ),
                                        title: "Player name".tr(context),
                                        enable: false,
                                        textInputType: TextInputType.name,
                                        focusNode: playerNameNode,
                                        controller: playerNameController));
                              },
                            ),

                            SizedBox(
                              height: 2.h,
                            ),
                            BlocConsumer<ProductsBloc, HomeState>(
                              listener: (context, state) {
                                if (state is OrderSuccessfulState) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    backgroundColor: Colors.green,
                                    duration: const Duration(seconds: 5),
                                    content: Text(
                                      "the order has been sent successfully"
                                          .tr(context),
                                    ),
                                  ));
                                  // Navigator.pushAndRemoveUntil(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => HomePage(),
                                  //     ),
                                  //     (route) => false);
                                  BlocProvider.of<ProfileBloc>(context)
                                    ..add(ProfileEvent());
                                  Navigator.pop(context);
                                }
                                if (state is OrderErrorState) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    backgroundColor: Colors.red,
                                    duration: const Duration(seconds: 5),
                                    content: Text(state.message!),
                                  ));
                                }
                              },
                              builder: (context, state) {
                                return Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 3.w),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: state is OrderLoadingState
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : CoustomButton(
                                            onPressed: () {
                                              if (formKey.currentState!
                                                  .validate())

                                              // &&
                                              // (selectedPackage
                                              //             .thPartyApiId ==
                                              //         null ||
                                              //     homeBloc.hasName!) &&
                                              // (selectedPackage
                                              //             .thPartyAs7abApi ==
                                              //         null ||
                                              //     homeBloc.hasName!))
                                              {
                                                homeBloc.add(OrderSixEvent(
                                                    jsonData: formData));
                                              }
                                            },
                                            buttonText: "Buy".tr(context)),
                                  ),
                                );
                              },
                            )
                          ],
                        )),
                    SizedBox(
                      height: 5.h,
                    )
                  ],
                ),
                // shrinkWrap: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class ProductAvailabilityPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Product Not Available'),
      content: Text('Sorry, the product is not available at the moment.'),
      actions: <Widget>[
        CoustomButton(
          onPressed: () {
            Navigator.of(context).pop();
            // Navigate back to home screen
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
           buttonText: "Ok",
        ),
      ],
    );
  }
}
/*
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class FormData {
  String name;
  String value;

  FormData({required this.name, required this.value});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'value': value,
    };
  }
}

class MyApp extends StatelessWidget {
  final List<Map<String, String>> fields = [
    {"name": "player_id", "label": "Player Number"},
    {"name": "email", "label": "Email"},
    {"name": "phone", "label": "Phone"},
    // Add more fields as needed
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Form Example'),
        ),
        body: FormScreen(fields: fields),
      ),
    );
  }
}


class FormScreen extends StatefulWidget {
  final List<Map<String, String>> fields;

  FormScreen({required this.fields});

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  List<FormData> formData = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var field in widget.fields)
                TextFormField(
                  decoration: InputDecoration(labelText: field['label']),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter ${field['label']}';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    formData.add(FormData(name: field['name']!, value: value!));
                  },
                ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _submitForm();
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    // Convert formData to JSON
    List<Map<String, dynamic>> jsonData =
        formData.map((data) => data.toJson()).toList();

    // Send data to API
    var response = await http.post(
      Uri.parse('YOUR_API_ENDPOINT'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(jsonData),
    );

    // Handle response
    if (response.statusCode == 200) {
      // Handle successful submission
      print('Form submitted successfully');
    } else {
      // Handle error
      print('Failed to submit form: ${response.statusCode}');
    }
  }
}
*/
