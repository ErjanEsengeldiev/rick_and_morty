import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty/features/characters/data/models/character.dart';
import 'package:rick_and_morty/features/characters/presentation/character_detail_page/character_detail_page.dart';
import 'package:rick_and_morty/features/episods/data/models/episode_model.dart';
import 'package:rick_and_morty/features/episods/presentation/episode_detail_page/episode_detail_page.dart';
import 'package:rick_and_morty/features/home/presentation/home_page.dart';

class AppGoRouter {
  static final AppGoRouter appGoRouter = AppGoRouter._internal();

  factory AppGoRouter() {
    return appGoRouter;
  }

  AppGoRouter._internal();

  final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const MyHomePage();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'characterDetailPage',
            builder: (BuildContext context, GoRouterState state) {
              return CharacterDetailPage(
                character: state.extra as Character,
              );
            },
          ),
          GoRoute(
            path: 'episodeDetailPage',
            builder: (BuildContext context, GoRouterState state) {
              return EpisodeDetailPage(
                episode: state.extra as Episode,
              );
            },
          ),
        ],
      ),
    ],
  );
}
