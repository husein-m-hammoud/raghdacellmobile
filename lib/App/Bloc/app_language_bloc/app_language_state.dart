part of 'app_language_bloc.dart';

@immutable
abstract class LanguageState{}
class InitialLanguageState extends LanguageState{
  final Locale locale;
  InitialLanguageState({required this.locale});
}


class LanguageLoadingState extends LanguageState{}

class LanguageErrorState extends LanguageState{}

class ChangLanguageState extends LanguageState{
  final Locale locale;
  ChangLanguageState({required this.locale});
}

