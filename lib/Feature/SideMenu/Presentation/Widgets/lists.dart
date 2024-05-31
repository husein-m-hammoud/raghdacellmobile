import 'package:flutter/material.dart';
import 'package:raghadcell/App/app_localizations.dart';

class RequestsLists {
  static List<String> days(BuildContext context) {
    return <String>[
      'All'.tr(context),
      'Today'.tr(context),
      'Last week'.tr(context),
      'Last Month'.tr(context),
      'Specific date'.tr(context),
    ];
  }

  static List<String> status(BuildContext context) {
    return <String>[
      'All'.tr(context),
      'Completed'.tr(context),
      'Canceled'.tr(context),
      'Waiting'.tr(context),
    ];
  }
}
