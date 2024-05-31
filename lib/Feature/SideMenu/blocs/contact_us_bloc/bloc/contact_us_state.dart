part of 'contact_us_bloc.dart';

@immutable
class ContactUsState {}

class ContactUsInfoTextErrorState extends ContactUsState {
  final String? message;

  ContactUsInfoTextErrorState({
    this.message,
  });
}

class ContactUsInfoTextLoadingState extends ContactUsState {}

class GetContactUsInfoTextState extends ContactUsState {
  final ContactUsInfoTextModel contactUsInfoTextModel;
  GetContactUsInfoTextState({required this.contactUsInfoTextModel});
}

class SendMessageContactUsState extends ContactUsState {
  final bool loadingState;
  final String? message;
  SendMessageContactUsState({
    this.loadingState = false,
    this.message,
  });
}
