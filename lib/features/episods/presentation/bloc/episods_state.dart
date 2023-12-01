part of 'episods_bloc.dart';

abstract class EpisodsState {}

class InitialEpisodsState extends EpisodsState {}

class EpisodsFetchedState extends EpisodsState {
  final bool isFiltered;
  final Info info;
  final List<Episode> listOfEpisods;

  EpisodsFetchedState({
    required this.info,
    required this.listOfEpisods,
    this.isFiltered = false,
  });
}

class LoadingState extends EpisodsState {}

class EpisodsErrorState extends EpisodsState {
  final String error;

  EpisodsErrorState({required this.error});
}
