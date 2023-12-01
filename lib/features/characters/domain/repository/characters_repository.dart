import 'package:rick_and_morty/core/data/info.dart';
import 'package:rick_and_morty/features/characters/data/models/character.dart';

abstract class CharactersRepository {
  Future<Character> getCharacterByID(String id);
  Future<ResponseWrapper> getCharacterFilter({
    String? name,
    String? gender,
    String? status,
  });
  Future<ResponseWrapper> getListCharacter(String page,String? nextPageUrl);
}
