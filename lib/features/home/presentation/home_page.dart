import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/core/app_theme/text_helper.dart';
import 'package:rick_and_morty/core/constans/app_constans.dart';
import 'package:rick_and_morty/features/characters/domain/repository/characters_repository.dart';
import 'package:rick_and_morty/features/characters/domain/repository/characters_repository_impl.dart';
import 'package:rick_and_morty/features/characters/presentation/bloc/characters_bloc.dart';
import 'package:rick_and_morty/features/characters/presentation/characters_body_widget.dart';
import 'package:rick_and_morty/features/episods/domain/repository/episods_repository.dart';
import 'package:rick_and_morty/features/episods/domain/repository/episods_repository_impl.dart';
import 'package:rick_and_morty/features/episods/presentation/bloc/episods_bloc.dart';
import 'package:rick_and_morty/features/episods/presentation/episods_body_widget.dart';
import 'package:rick_and_morty/features/home/presentation/bloc/home_bloc.dart';
import 'package:rick_and_morty/main_widgets/bottom_navigation_bar/bottom_navigation_bat.dart';
import 'package:rick_and_morty/main_widgets/bottomsheets/filter_bottomsheet.dart';

import '../../../generated/l10n.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final CharactersRepository charactersRepository;
  late final CharactersBloc charactersBloc;
  late final EpisodsRepository episodsRepository;
  late final EpisodsBloc episodsBloc;
  late final HomeBloc _homeBloc;

  @override
  void initState() {
    charactersRepository = CharactersRepositoryImpl();
    charactersBloc = CharactersBloc(charactersRepository);
    episodsRepository = EpisodsRepositoryImpl();
    episodsBloc = EpisodsBloc(episodsRepository);
    _homeBloc = HomeBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<CharactersRepository>(create: (_) => charactersRepository),
        Provider<CharactersBloc>(create: (_) => charactersBloc),
        Provider<EpisodsRepository>(create: (_) => episodsRepository),
        Provider<EpisodsBloc>(create: (_) => episodsBloc),
        Provider<HomeBloc>(create: (_) => _homeBloc),
      ],
      child: BlocBuilder(
          bloc: _homeBloc,
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text(S.of(context).rickMorty),
                actions: [
                  IconButton(
                    onPressed: () {
                      switch ((state as HomeScreenChangedState).currentIndex) {
                        case 0:
                          FilterBottomsheet.showCharactersModalBottomsheet(
                            context,
                            charactersBloc: charactersBloc,
                          );
                          break;
                        case 1:
                          FilterBottomsheet.showEpisodeModalBottomsheet(
                            context,
                            episodsBloc: episodsBloc,
                          );
                          break;
                        default:
                      }
                    },
                    icon: Icon(Icons.sort),
                  ),
                ],
              ),
              body: BlocBuilder(
                bloc: _homeBloc,
                builder: (context, state) {
                  if (state is HomeScreenChangedState) {
                    switch (state.currentIndex) {
                      case 0:
                        return const CharavtersBodyWidget();

                      case 1:
                        return const EpisodsBodyWidget();

                      default:
                        return const CharavtersBodyWidget();
                    }
                  } else {
                    return const CharavtersBodyWidget();
                  }
                },
              ),
              bottomNavigationBar: AppBottomNavigationBar(
                currentIndex: (state as HomeScreenChangedState).currentIndex,
                onTap: (currentPageIndex) => _homeBloc.add(
                  ChangePageEvent(currentPageIndex),
                ),
              ),
            );
          }),
    );
  }
}
