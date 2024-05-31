import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Util/SharedPreferences/SharedPreferencesHelper.dart';

Future<Either<String, String>> selectedTime(
    {required BuildContext context,
    required String type,
    required Function() changeDateStartAndEnd}) async {
  DateTime? picker = await showDatePicker(
      initialDate: DateTime.now(),
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100));
  String date = picker.toString().substring(0, 10);

  changeDateStartAndEnd();
  if (type == "start") {
    return Left(date);
  } else {
    return Right(date);
  }
}

String getDateToday() {
  DateTime now = DateTime.now();
  String date = now.toString().substring(0, 10);
  return date;
}

DateTime getLastWeek() {
  DateTime time = DateTime.now();

  return time.copyWith(year: time.year, month: time.month, day: time.day - 7);
}

// DateTime getLastMonth() {
//   DateTime time = DateTime.now();

//   DateTime monthe =
//       time.copyWith(year: time.year, month: (time.month - 1), day: time.day);
//   print("time ==========================  ${monthe.month}");
//   return monthe;
// }
DateTime getLastMonth() {
  DateTime time = DateTime.now();

  int newYear = time.year;
  int newMonth = time.month - 1;

  if (newMonth == 0) {
    newYear--;
    newMonth = 12;
  }

  // Handle the case where day > number of days in the new month
  int newDay = time.day;
  if (newDay > DateTime(newYear, newMonth + 1, 0).day) {
    newDay = DateTime(newYear, newMonth + 1, 0).day;
  }

  DateTime lastMonth = DateTime(newYear, newMonth, newDay);

  if (kDebugMode) {
    print("Last month: $lastMonth");
  }
  return lastMonth;
}

String formatNumber(dynamic number) {
  if (number is String) {
    return number;
  }
  if (AppSharedPreferences.isUSD) {
    String preString = number.toStringAsFixed(3);
    String fractionalPart = '.${preString.split('.').last}';
    if (int.parse(fractionalPart.characters.elementAt(3)) < 5) {
      fractionalPart = fractionalPart.substring(0, 3);
      if (int.parse(fractionalPart.characters.elementAt(2)) == 0) {
        fractionalPart = fractionalPart.substring(0, 2);
        if (int.parse(fractionalPart.characters.elementAt(1)) == 0) {
          fractionalPart = '';
        }
      }
    }
    String firstPart = preString.split('.').first.replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');

    return "$firstPart$fractionalPart USD";
  } else {
    String result = number.toString().split('.').isNotEmpty
        ? number.toString().split('.').first
        : number.toString();
    result = result.replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
    return "$result LBP";
  }
}

double deformatNumber(String formattedNumber) {
  final arr = formattedNumber.split(' ');

  arr.removeAt(arr.length - 1);
  formattedNumber = arr.join(',').split(',').join();
  return double.parse(arr.join());
}
