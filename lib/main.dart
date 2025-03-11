import 'package:epg_test/core/app/app.dart';
import 'package:epg_test/core/constants/boxes.dart';
import 'package:epg_test/core/router/app_router.dart';
import 'package:epg_test/core/services/local_db/box_service.dart';
import 'package:epg_test/core/services/local_db/hive/hive_registrar.g.dart';
import 'package:epg_test/features/epg/models/channel_cache.dart';
import 'package:epg_test/features/epg/models/programme_cache.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  Hive
    ..init(directory.path)
    ..registerAdapters();

  final boxService = BoxService();
  await boxService.initBox<ChannelCache>(channelsBox);
  await boxService.initBox<ProgrammeCache>(programmesBox);
  final appRouter = AppRouter();

  runApp(App(boxService: boxService, appRouter: appRouter));
}
