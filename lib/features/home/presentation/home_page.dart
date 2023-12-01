import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/features/characters/presentation/characters_body_widget.dart';
import 'package:rick_and_morty/features/episods/presentation/bloc/home_bloc.dart';
import 'package:rick_and_morty/features/episods/presentation/episods_body_widget.dart';
import 'package:rick_and_morty/main_widgets/bottom_navigation_bar/bottom_navigation_bat.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _homeBloc,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Rick & Morty'),
        ),
        // body: CharavtersBodyWidget(),
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
          onTap: (currentPageIndex) => _homeBloc.add(
            ChangePageEvent(currentPageIndex),
          ),
        ),
      ),
    );
  }
}
