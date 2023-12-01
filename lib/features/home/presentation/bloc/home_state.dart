part of 'home_bloc.dart';

abstract class HomeState {}

class HomeScreenChangedState extends HomeState {
  final int currentIndex;

  HomeScreenChangedState({this.currentIndex = 1});
}
