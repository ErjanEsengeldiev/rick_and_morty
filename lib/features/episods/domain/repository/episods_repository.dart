import 'package:rick_and_morty/core/data/info.dart';
import 'package:rick_and_morty/features/characters/data/models/character.dart';
import 'package:rick_and_morty/features/episods/data/models/episode_model.dart';

abstract class EpisodsRepository {
  Future<Episode> getEpisodeByID(String id);
  Future<ResponseWrapper> getEpisodeFilter({
    String? name,
    String? episode,
  });
  Future<ResponseWrapper> getListEpisode(String page,String? nextPageUrl);
}
