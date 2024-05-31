part of 'main_bloc.dart';

@immutable
abstract class MainEvent {}

class HideBottomNavigationBar extends MainEvent {}

class ShowBottomNavigationBar extends MainEvent {}

class SelectBottomNavigationBarItem extends MainEvent {
 final int index;
  SelectBottomNavigationBarItem({required this.index});
}
