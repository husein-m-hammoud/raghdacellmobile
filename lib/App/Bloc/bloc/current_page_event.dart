part of 'current_page_bloc.dart';

@immutable
class ChangePageColorEvent {
  final PagesEnum currentPage;
 const ChangePageColorEvent({required this.currentPage});
}
