// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:raghadcell/App/app_localizations.dart';
import 'package:raghadcell/Core/function/functions.dart';
import 'package:sizer/sizer.dart';

class SelectStartAndEndDate extends StatelessWidget {
  const SelectStartAndEndDate({
    super.key,
    required this.isvisible,
    required this.startDateController,
    required this.endDateController,
    required this.onValue,
  });

  final bool isvisible;
  final TextEditingController startDateController;

  final TextEditingController endDateController;
  final Function(Either<String, String>) onValue;

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: isvisible,
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(3.w)),
                  margin: EdgeInsets.symmetric(horizontal: 3.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          enabled: false,
                          controller: startDateController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 3.w),
                            hintText: "Start Date".tr(context),
                            border: const UnderlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.date_range_outlined),
                        onPressed: () {
                          selectedTime(
                                  changeDateStartAndEnd: () {},
                                  context: context,
                                  type: "start")
                              .then((value) {
                            onValue(value);
                          });
                        },
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(3.w)),
                  margin: EdgeInsets.symmetric(horizontal: 3.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          enabled: false,
                          controller: endDateController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 3.w),
                            hintText: "End Date".tr(context),
                            border: const UnderlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.date_range_outlined),
                        onPressed: () {
                          selectedTime(
                                  changeDateStartAndEnd: () {},
                                  context: context,
                                  type: "end")
                              .then((value) {
                            onValue(value);
                          });
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
