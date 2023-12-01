import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:rick_and_morty/core/data/info.dart';
import 'package:rick_and_morty/features/characters/data/models/character.dart';
import 'package:rick_and_morty/features/episods/data/models/episode_model.dart';
import 'package:rick_and_morty/features/episods/domain/repository/episods_repository.dart';

part 'episods_event.dart';
part 'episods_state.dart';

class EpisodsBloc extends Bloc<EpisodsEvent, EpisodsState> {
  final EpisodsRepository repository;
  EpisodsBloc(this.repository) : super(InitialEpisodsState()) {
    on<GetListEpisodsEvent>(
      (event, emit) async {
        await repository
            .getListEpisode(event.page.toString(), event.nextPageUrl)
            .then(
              (value) => emit(EpisodsFetchedState(
                info: value.info,
                listOfEpisods:
                    value.results.map((e) => Episode.fromJson(e)).toList(),
              )),
            )
            .onError((error, stackTrace) {
          emit(EpisodsErrorState(error: error.toString()));
        });
      },
      transformer: droppable(),
    );
    on<SortedEpisodsEvent>(
      (event, emit) async {
        print('object');
        await repository
            .getEpisodeFilter(name: event.name, episode: event.episode)
            .then(
              (value) => emit(EpisodsFetchedState(
                info: value.info,
                isFiltered: true,
                listOfEpisods:
                    value.results.map((e) => Episode.fromJson(e)).toList(),
              )),
            )
            .onError((error, stackTrace) {
          emit(EpisodsErrorState(error: error.toString()));
        });
      },
      transformer: droppable(),
    );
  }
}
