import 'dart:developer';

import 'package:rick_and_morty/core/client/client.dart';
import 'package:rick_and_morty/core/constans/app_constans.dart';
import 'package:rick_and_morty/core/data/info.dart';
import 'package:rick_and_morty/features/characters/data/models/character.dart';
import 'package:rick_and_morty/features/characters/domain/repository/characters_repository.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  final Api api = Api();

  @override
  Future<Character> getCharacterByID(String id) async {
    return await api.dio.get('${AppConstans.baseUrl}/character/$id').then(
      (value) {
        final Character character = Character.fromJson(value.data);

        return character;
      },
    ).onError((error, stackTrace) {
      throw Exception('error: ${error} \n\nstackTrace ${stackTrace}');
    });
  }

  @override
  Future<ResponseWrapper> getCharacterFilter({
    String? name,
    String? gender,
    String? status,
  }) async {
    return await api.dio
        .get(
      '${AppConstans.baseUrl}/character/?name=$name&status=$status&gender=$gender',
    )
        .then(
      (value) {
        log(value.data.toString());
        final ResponseWrapper character = ResponseWrapper.fromJson(value.data);

        return character;
      },
    ).onError((error, stackTrace) {
      throw Exception('error: ${error} \n\nstackTrace ${stackTrace}');
    });
  }

  @override
  Future<ResponseWrapper> getListCharacter(
      String page, String? nextPageUrl) async {
    if (nextPageUrl != null) {
      return await api.dio.get(nextPageUrl).then(
        (value) {
          log((value.data['results'] as List).length.toString());
          final ResponseWrapper character =
              ResponseWrapper.fromJson(value.data);

          return character;
        },
      ).onError((error, stackTrace) {
        throw Exception('error: ${error} \n\nstackTrace ${stackTrace}');
      });
    }
    return await api.dio
        .get('${AppConstans.baseUrl}/character/?page=$page')
        .then(
      (value) {
        log((value.data['results'] as List).length.toString());
        final ResponseWrapper character = ResponseWrapper.fromJson(value.data);

        return character;
      },
    ).onError((error, stackTrace) {
      throw Exception('error: ${error} \n\nstackTrace ${stackTrace}');
    });
  }
}
