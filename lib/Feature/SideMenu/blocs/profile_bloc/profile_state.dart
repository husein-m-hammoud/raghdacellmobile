part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileErrorState extends ProfileState {
  final String? message;
  final int? code;

  ProfileErrorState({
    this.message,
    this.code
  });
}


class ProfileLoadingState extends ProfileState {}

class GetProfileState extends ProfileState {
  final ProfileModel profileModel;
  GetProfileState({required this.profileModel});
}
