import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:raghadcell/Apis/ExceptionsHandle.dart';
import 'package:raghadcell/Apis/Network.dart';
import 'package:raghadcell/Apis/Urls.dart';
import 'package:raghadcell/Feature/SideMenu/Presentation/models/contact_us_info_model.dart';

part 'contact_us_event.dart';
part 'contact_us_state.dart';

class ContactUsBloc extends Bloc<ContactUsEvent, ContactUsState> {
  ContactUsBloc() : super(ContactUsInfoTextLoadingState()) {
    on<GetContactUsInfoTextsEvent>((event, emit) async {
      emit(ContactUsInfoTextLoadingState());
      try {
        final response = await Network.getData(url: Urls.getContactUsInfoText);
        ContactUsInfoTextModel contactUsInfoTextModel =
            ContactUsInfoTextModel.fromJson(response.data);

        emit(GetContactUsInfoTextState(
            contactUsInfoTextModel: contactUsInfoTextModel));
      } catch (error) {
        if (error is DioException) {
          emit(ContactUsInfoTextErrorState(
              message: exceptionsHandle(error: error)));
        } else {
          emit(ContactUsInfoTextErrorState(message: error.toString()));
        }
      }
    });
    on<SendMessageEvent>((event, emit) async {
      emit(SendMessageContactUsState(loadingState: true));
      try {
        await Network.postData(url: Urls.sendMessagesContactUs, data: {
          "name": event.name,
          "phone_number": event.phone,
          "message": event.message
        });

        emit(SendMessageContactUsState(loadingState: false));
      } catch (error) {
        if (error is DioException) {
          emit(SendMessageContactUsState(
              message: exceptionsHandle(error: error)));
        } else {
          emit(SendMessageContactUsState(message: error.toString()));
        }
      }
    });
  }
}
