import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
          // GoRoute(
          //   path: 'details',
          //   builder: (BuildContext context, GoRouterState state) {
          //     return const DetailsScreen();
          //   },
          // ),
        ],
      ),
    ],
  );
}
