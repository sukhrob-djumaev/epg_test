import 'package:epg_test/core/providers/providers.dart';
import 'package:epg_test/core/router/app_router.dart';
import 'package:epg_test/core/services/local_db/box_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends StatelessWidget {
  final AppRouter appRouter;
  final IBoxService boxService;
  const App({super.key, required this.appRouter, required this.boxService});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [boxServiceProvider.overrideWithValue(boxService)],
      child: MaterialApp.router(routerConfig: appRouter.config(), title: 'EPG Viewer', theme: ThemeData.dark()),
    );
  }
}
