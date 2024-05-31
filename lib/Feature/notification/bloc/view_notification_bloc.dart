import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:raghadcell/Apis/ExceptionsHandle.dart';
import 'package:raghadcell/Apis/Network.dart';
import 'package:raghadcell/Apis/Urls.dart';
import 'package:raghadcell/Core/Util/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:raghadcell/Feature/notification/models/view_notification_model.dart';
part 'view_notification_event.dart';
part 'view_notification_state.dart';

class ViewNotificationBloc extends Bloc<ViewNotificationEvent, NotificationState> {
  int page = 1;
  ViewNotificationModel? viewNotificationModel;
  RefreshController refreshController = RefreshController();
  ViewNotificationBloc() : super(NotificationLoadingState()) {
    on<ViewNotificationEvent>((event, emit) async {
      if (page == 1) {
        emit(NotificationLoadingState());
      }
      try {
        await Network.getData(
                url:
                    "${Urls.baseUrl}/notifications?local=${AppSharedPreferences.getArLang}&page=$page")
            .then((response) {
          if (page == 1) {
            viewNotificationModel =
                ViewNotificationModel.fromJson(response.data);
            emit(GetNotificationState(
                viewNotificationModel: viewNotificationModel!));
          } else {
            viewNotificationModel!.data!.notifications!.addAll(
                ViewNotificationModel.fromJson(response.data)
                    .data!
                    .notifications!);
            emit(GetNotificationState(
                viewNotificationModel: viewNotificationModel!));
          }
        });
      } catch (error) {
        if (error is DioException) {
          emit(NotificationErrorState(message: exceptionsHandle(error: error)));
        } else {
          NotificationErrorState(message: error.toString());
        }
      }
    });
    on<DeleteNotificationEvent>((event, emit) async {
      emit(NotificationLoadingDeleteState());

      try {
        await Network.deleteData(
            url: "${Urls.baseUrl}/notifications/${event.notificationNumber}");
        viewNotificationModel!.data!.notifications!.removeAt(event.index);
        emit(NotificationSuccessfulState());
        // Future.delayed(const Duration(seconds: 2));
        // emit(GetNotificationState(
        //     viewNotificationModel: viewNotificationModel!));
      } catch (error) {
        if (error is DioException) {
          emit(NotificationErrorState(message: exceptionsHandle(error: error)));
        } else {
          NotificationErrorState(message: error.toString());
        }
      }
    });
  }
}
