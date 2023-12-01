part of 'home_bloc.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeScreenChangedState extends HomeState {
  final int currentIndex;

  HomeScreenChangedState({required this.currentIndex});
}
