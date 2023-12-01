import 'dart:developer';

import 'package:rick_and_morty/core/client/client.dart';
import 'package:rick_and_morty/core/constans/app_constans.dart';
import 'package:rick_and_morty/core/data/info.dart';
import 'package:rick_and_morty/features/episods/data/models/episode_model.dart';
import 'package:rick_and_morty/features/episods/domain/repository/episods_repository.dart';

class EpisodsRepositoryImpl implements EpisodsRepository {
  final Api api = Api();

  @override
  Future<Episode> getEpisodeByID(String id) async {
    return await api.dio.get('${AppConstans.baseUrl}/Episode/$id').then(
      (value) {
        final Episode episode = Episode.fromJson(value.data);

        return episode;
      },
    ).onError((error, stackTrace) {
      throw Exception('error: ${error} \n\nstackTrace ${stackTrace}');
    });
  }

  @override
  Future<ResponseWrapper> getEpisodeFilter({
    String? name,
    String? episode,
  }) async {
    return await api.dio
        .get(
      '${AppConstans.baseUrl}/episode/?name=$name&episode=$episode',
    )
        .then(
      (value) {
        log(value.data.toString());
        final ResponseWrapper episode = ResponseWrapper.fromJson(value.data);

        return episode;
      },
    ).onError((error, stackTrace) {
      throw Exception('error: ${error} \n\nstackTrace ${stackTrace}');
    });
  }

  @override
  Future<ResponseWrapper> getListEpisode(
      String page, String? nextPageUrl) async {
    if (nextPageUrl != null) {
      return await api.dio.get(nextPageUrl).then(
        (value) {
          log((value.data['results'] as List).length.toString());
          final ResponseWrapper episode = ResponseWrapper.fromJson(value.data);

          return episode;
        },
      ).onError((error, stackTrace) {
        throw Exception('error: ${error} \n\nstackTrace ${stackTrace}');
      });
    }
    return await api.dio.get('${AppConstans.baseUrl}/episode/?page=$page').then(
      (value) {
        log((value.data['results'] as List).length.toString());
        final ResponseWrapper Episode = ResponseWrapper.fromJson(value.data);

        return Episode;
      },
    ).onError((error, stackTrace) {
      throw Exception('error: ${error} \n\nstackTrace ${stackTrace}');
    });
  }
}
