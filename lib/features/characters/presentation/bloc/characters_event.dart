part of 'characters_bloc.dart';

abstract class CharactersEvent {}

class GetListCharactersEvent extends CharactersEvent {
  final int page;
  final String? nextPageUrl;

  GetListCharactersEvent({
    required this.page,
    this.nextPageUrl,
  });
}

class SortedCharactersEvent extends CharactersEvent {
  final String? name;
  final String? status;
  final String? gender;

  SortedCharactersEvent({this.name, this.status, this.gender});
}
