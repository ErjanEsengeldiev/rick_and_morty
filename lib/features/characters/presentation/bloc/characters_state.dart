part of 'characters_bloc.dart';

abstract class CharactersState {}

class InitialCharactersState extends CharactersState {}

class CharactersFetchedState extends CharactersState {
  final bool isFiltered;
  final Info info;
  final List<Character> listOfCharacters;

  CharactersFetchedState({
    required this.info,
    required this.listOfCharacters,
    this.isFiltered = false,
  });
}

class LoadingState extends CharactersState {}

class CharactersErrorState extends CharactersState {
  final String error;

  CharactersErrorState({required this.error});
}
