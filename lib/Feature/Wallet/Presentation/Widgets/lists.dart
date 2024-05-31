import 'package:flutter/material.dart';
import 'package:raghadcell/App/app_localizations.dart';

class WalletLists {
  static List<String> days(BuildContext context) {
    return <String>[
      'All'.tr(context),
      'Today'.tr(context),
      'Last week'.tr(context),
      'Last Month'.tr(context),
      'Specific date'.tr(context),
    ];
  }

  static List<String> filter(BuildContext context) {
    return <String>[
      'All'.tr(context),
      'Imports'.tr(context),
      'Exports'.tr(context),
    ];
  }
}
