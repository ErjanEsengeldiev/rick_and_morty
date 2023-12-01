import 'package:rick_and_morty/features/characters/data/models/character.dart';

abstract class CharactersRepository {
  Future<Character> getCharacterByID(String id);
  Future<Character> getCharacterFilter(String id);
  Future<List<Character>> getListCharacter(String page);
}
