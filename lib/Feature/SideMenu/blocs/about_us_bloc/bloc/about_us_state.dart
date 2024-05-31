part of 'about_us_bloc.dart';

@immutable
class AboutUsState {}

class AboutUsErrorState extends AboutUsState {
  final String? message;

  AboutUsErrorState({
    this.message,
  });
}

class AboutUsLoadingState extends AboutUsState {}

class GetAboutUsState extends AboutUsState {
  final AboutUsModel aboutUsModel;
  GetAboutUsState({required this.aboutUsModel});
}
