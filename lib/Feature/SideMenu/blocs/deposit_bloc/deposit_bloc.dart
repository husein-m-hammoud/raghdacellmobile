import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:raghadcell/Apis/ExceptionsHandle.dart';
import 'package:raghadcell/Apis/Network.dart';
import 'package:raghadcell/Apis/Urls.dart';
import 'package:raghadcell/Core/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:raghadcell/Feature/SideMenu/Presentation/models/deposit_information_model.dart';

part 'deposit_event.dart';
part 'deposit_state.dart';

class DepositBloc extends Bloc<DepositEvent, DepositState> {
  DepositBloc() : super(GetDepositInformationLoadingAndErrorState()) {
    on<DepositEvent>((event, emit) async {
      if (event is GetDepositInformationEvent) {
        emit(GetDepositInformationLoadingAndErrorState());

        try {
          final response = await Network.getData(url: Urls.depositInformation);
          DepositInformationModel depositInformationModel =
              DepositInformationModel.fromJson(response.data);

          emit(GetDepositInformationState(
              depositInformationModel: depositInformationModel));
        } catch (error) {
          if (error is DioException) {
            emit(GetDepositInformationErrorState(
                message: exceptionsHandle(error: error)));
          } else {
            emit(GetDepositInformationErrorState(message: error.toString()));
          }
        }
      } else if (event is UDSTAndWishMonyChargingWalletEvent) {
        emit(GetDepositInformationLoadingAndErrorState(isLoading: true));

        FormData formData = FormData.fromMap({
          "name": event.type,
          "value": event.value,
          "image": await MultipartFile.fromFile(event.image),
        });
        try {
          await Network.postData(
              url:
                  "${Urls.baseUrl}/charging-processes?local=${AppSharedPreferences.getArLang}",
              data: formData);
          emit(GetDepositInformationLoadingAndErrorState(isLoading: false));
        } catch (error) {
          if (error is DioException) {
            emit(GetDepositInformationLoadingAndErrorState(
                message: exceptionsHandle(error: error)));
          } else {
            emit(GetDepositInformationLoadingAndErrorState(
                message: error.toString()));
          }
        }
        //
      } else if (event is PromoCodeChargingWalletEvent) {
        emit(GetDepositInformationLoadingAndErrorState(isLoading: true));

        try {
          await Network.postData(
              url: "${Urls.baseUrl}/charging-processes?name=PROMO_CODE",
              data: {
                "promo_code": event.value,
              });
          emit(GetDepositInformationLoadingAndErrorState(isLoading: false));
        } catch (error) {
          if (error is DioException) {
            emit(GetDepositInformationLoadingAndErrorState(
                message: exceptionsHandle(error: error)));
          } else {
            emit(GetDepositInformationLoadingAndErrorState(
                message: error.toString()));
          }
        }
      }
    });
  }
}
