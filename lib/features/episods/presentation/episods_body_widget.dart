import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty/features/episods/data/models/episode_model.dart';
import 'package:rick_and_morty/features/episods/presentation/bloc/episods_bloc.dart';

class EpisodsBodyWidget extends StatefulWidget {
  const EpisodsBodyWidget({
    super.key,
  });

  @override
  State<EpisodsBodyWidget> createState() => _EpisodsBodyWidgetState();
}

class _EpisodsBodyWidgetState extends State<EpisodsBodyWidget> {
  late final EpisodsBloc bloc;
  final ScrollController _scrollController = ScrollController();
  bool isListEnd = false;
  String? nextPageUrl;
  int _totalPage = 0;
  int _currentPage = 1;
  final List<Episode> _listOfEpisods = [];

  void _loadMore() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (!isListEnd) {
        bloc.add(
          GetListEpisodsEvent(
            page: _currentPage,
            nextPageUrl: nextPageUrl,
          ),
        );
      }
    }
  }

  @override
  void initState() {
    bloc = context.read<EpisodsBloc>();
    bloc.add(GetListEpisodsEvent(page: 1));
    _scrollController.addListener(_loadMore);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      listener: (context, state) {
        if (state is EpisodsFetchedState) {
          if (state.isFiltered == true) {
            _listOfEpisods.clear();
            _currentPage = 1;
          }
          nextPageUrl = state.info.next;
          _totalPage = state.info.pages;

          if (_currentPage == _totalPage) {
            isListEnd = true;
          } else {
            isListEnd = false;
            _currentPage++;
          }

          _listOfEpisods.addAll(Iterable.castFrom(state.listOfEpisods));
        }
      },
      bloc: bloc,
      builder: (context, state) {
        if (state is EpisodsFetchedState) {
          return ListView.builder(
            controller: _scrollController,
            itemCount:
                isListEnd ? _listOfEpisods.length : _listOfEpisods.length + 1,
            itemBuilder: (context, index) {
              if (index == _listOfEpisods.length) {
                return const Padding(
                  padding: EdgeInsets.all(8),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return Card(
                  child: InkWell(
                    onTap: () {
                      context.go('/episodeDetailPage',
                          extra: _listOfEpisods[index]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(_listOfEpisods[index].name),
                    ),
                  ),
                );
              }
            },
          );
        } else if (state is EpisodsErrorState) {
          return Center(
            child: Text(state.error),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
