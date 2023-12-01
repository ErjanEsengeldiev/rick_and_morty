part of 'episods_bloc.dart';

abstract class EpisodsEvent {}

class GetListEpisodsEvent extends EpisodsEvent {
  final int page;
  final String? nextPageUrl;

  GetListEpisodsEvent({
    required this.page,
    this.nextPageUrl,
  });
}

class SortedEpisodsEvent extends EpisodsEvent {
  final String? name;
  final String? episode;

  SortedEpisodsEvent({this.name, this.episode});
}
