import 'package:raghadcell/Core/Constants/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SharedPreferencesProvider.dart';

class AppSharedPreferences {
  static SharedPreferencesProvider? sharedPreferencesProvider;
  static late SharedPreferences preferences;
  static init() async {
    sharedPreferencesProvider = await SharedPreferencesProvider.getInstance();
    preferences = await SharedPreferences.getInstance();
    // preferences.setBool("remmember_me_value", false);
  }

  //currency
  static String get getCurrency =>
      preferences.getString("currency") == "LBP" ? "LBP" : "USD";
  static saveCurrency(String currency) =>
      preferences.setString("currency", currency);
  static bool get isUSD => preferences.getString("currency") == "USD";
  //apptoken

  //token
  static String get getToken =>
      sharedPreferencesProvider!.read(AppStrings.token) ?? '';
  static saveToken(String value) =>
      sharedPreferencesProvider!.save(AppStrings.token, value);
  static bool get hasToken =>
      sharedPreferencesProvider!.contains(AppStrings.token);
  static removeToken() => sharedPreferencesProvider!.remove(AppStrings.token);

  //lang
  static String get getArLang =>
      sharedPreferencesProvider!.read(AppStrings.language) ?? "en";
  static saveArLang(String value) =>
      sharedPreferencesProvider!.save(AppStrings.language, value);
  static bool get hasArLang =>
      sharedPreferencesProvider!.contains(AppStrings.language);
  static removeArLang() =>
      sharedPreferencesProvider!.remove(AppStrings.language);


  //Account type
  static String get getType =>
      sharedPreferencesProvider!.read('type') ?? '';
  static saveType(String value) =>
      sharedPreferencesProvider!.save('type', value);
  static bool get hasType =>
      sharedPreferencesProvider!.contains('type');
  static removeType() => sharedPreferencesProvider!.remove('type');


  //theme
  // static bool get getDarkTheme => sharedPreferencesProvider!.read(AppStrings.darkTheme) ??  false ;
  // static saveDarkTheme(bool value) => sharedPreferencesProvider!.save(AppStrings.darkTheme, value);
  // static bool get hasDarkTheme => sharedPreferencesProvider!.contains(AppStrings.darkTheme);
  // static removeDarkTheme() => sharedPreferencesProvider!.remove(AppStrings.darkTheme);
}
