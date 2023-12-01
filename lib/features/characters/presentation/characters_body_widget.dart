import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/core/app_theme/text_helper.dart';
import 'package:rick_and_morty/features/characters/data/models/character.dart';
import 'package:rick_and_morty/features/characters/domain/repository/characters_repository.dart';
import 'package:rick_and_morty/features/characters/domain/repository/characters_repository_impl.dart';
import 'package:rick_and_morty/features/characters/presentation/bloc/characters_bloc.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/characters_card_widget.dart';

class CharavtersBodyWidget extends StatefulWidget {
  const CharavtersBodyWidget({
    super.key,
  });

  @override
  State<CharavtersBodyWidget> createState() => _CharavtersBodyWidgetState();
}

class _CharavtersBodyWidgetState extends State<CharavtersBodyWidget> {
  late final CharactersBloc charactersBloc;
  final ScrollController _scrollController = ScrollController();
  bool isListEnd = false;
  String? nextPageUrl;
  int _totalPage = 0;
  int _currentPage = 1;
  final List<Character> _listOfCharacters = [];

  void _loadMore() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (!isListEnd) {
        charactersBloc.add(
          GetListCharactersEvent(
            page: _currentPage,
            nextPageUrl: nextPageUrl,
          ),
        );
      }
    }
  }

  @override
  void initState() {
    charactersBloc = context.read<CharactersBloc>();
    charactersBloc.add(GetListCharactersEvent(page: 1));
    _scrollController.addListener(_loadMore);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: charactersBloc,
      listener: (context, state) {
        if (state is CharactersFetchedState) {
          if (state.isFiltered == true) {
            _listOfCharacters.clear();
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

          _listOfCharacters.addAll(Iterable.castFrom(state.listOfCharacters));
        }
      },
      builder: (context, state) {
        if (state is CharactersErrorState) {
          return Center(
            child: Text(state.error),
          );
        }
        if (state is CharactersFetchedState) {
          return ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(8),
            itemCount: isListEnd
                ? _listOfCharacters.length
                : _listOfCharacters.length + 1,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              if (index == _listOfCharacters.length) {
                return const Padding(
                  padding: EdgeInsets.all(8),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return CharactersCardWidget(
                  character: _listOfCharacters[index],
                );
              }
            },
          );
        }
        if (state is LoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const Center(
            child: Text('uncknown state'),
          );
        }
      },
    );
  }
}
