part of 'view_notification_bloc.dart';

@immutable
class ViewNotificationEvent {}

class GetNotificationEvent extends ViewNotificationEvent {}

class DeleteNotificationEvent extends ViewNotificationEvent {
  final int notificationNumber;
  final Notifications notification;
  final int index;
  DeleteNotificationEvent(
    this.index, {
    required this.notificationNumber,
    required this.notification,
  });
}
