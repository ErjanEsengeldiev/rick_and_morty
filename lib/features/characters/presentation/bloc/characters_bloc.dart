import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/foundation.dart';
import 'package:rick_and_morty/core/client/client.dart';
import 'package:rick_and_morty/core/data/info.dart';
import 'package:rick_and_morty/features/characters/data/models/character.dart';
import 'package:rick_and_morty/features/characters/domain/repository/characters_repository.dart';

part 'characters_event.dart';
part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final CharactersRepository repository;
  CharactersBloc(this.repository) : super(InitialCharactersState()) {
    on<GetListCharactersEvent>(
      (event, emit) async {
        await repository
            .getListCharacter(event.page.toString(), event.nextPageUrl)
            .then(
              (value) => emit(CharactersFetchedState(
                info: value.info,
                listOfCharacters:
                    value.results.map((e) => Character.fromJson(e)).toList(),
              )),
            )
            .onError((error, stackTrace) {
          emit(CharactersErrorState(error: error.toString()));
        });
      },
      transformer: droppable(),
    );
    on<SortedCharactersEvent>(
      (event, emit) async {
        print('object');
        await repository
            .getCharacterFilter(
                name: event.name, gender: event.gender, status: event.status)
            .then(
              (value) => emit(CharactersFetchedState(
                info: value.info,
                isFiltered: true,
                listOfCharacters:
                    value.results.map((e) => Character.fromJson(e)).toList(),
              )),
            )
            .onError((error, stackTrace) {
          emit(CharactersErrorState(error: error.toString()));
        });
      },
      transformer: droppable(),
    );
  }
}
