part of 'contact_us_bloc.dart';

@immutable
class ContactUsEvent {}

class GetContactUsInfoTextsEvent extends ContactUsEvent {}

class SendMessageEvent extends ContactUsEvent {
  final String name;
  final String phone;
  final String message;
  SendMessageEvent(
      {required this.message, required this.name, required this.phone});
}

