part of 'view_notification_bloc.dart';

@immutable
class NotificationState {}

class NotificationLoadingState extends NotificationState {}

class NotificationLoadingDeleteState extends NotificationState {}

class NotificationErrorState extends NotificationState {
  final String message;
  NotificationErrorState({required this.message});
}

class GetNotificationState extends NotificationState {
  final ViewNotificationModel viewNotificationModel;
  GetNotificationState({required this.viewNotificationModel});
}

class NotificationSuccessfulState extends NotificationState {}
