import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rick_and_morty/core/navigation/go_router.dart';
import 'package:rick_and_morty/features/home/presentation/home_page.dart';

import 'package:rick_and_morty/generated/l10n.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppGoRouter appGoRouter = AppGoRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appGoRouter.router,
      title: 'Rick&Morty',
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
    );
  }
}
