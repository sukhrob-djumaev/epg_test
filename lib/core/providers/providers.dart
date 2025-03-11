import 'package:epg_test/core/services/local_db/box_service.dart';
import 'package:epg_test/core/services/network/connectivity_service.dart';
import 'package:epg_test/core/services/network/dio_service.dart';
import 'package:epg_test/features/epg/data_sources/epg_local_db.dart';
import 'package:epg_test/features/epg/data_sources/epg_rest_client.dart';
import 'package:epg_test/features/epg/repositories/epg_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final dioServiceProvider = Provider.autoDispose<DioService>((ref) => DioService());
final connectivityServiceProvider = Provider.autoDispose<IConnectivityService>((ref) => ConnectivityService());
final epgRestClientProvider = Provider.autoDispose<IEPGRestClient>(
  (ref) => EPGRestClient(dioService: ref.read(dioServiceProvider)),
);
final boxServiceProvider = Provider.autoDispose<IBoxService>((ref) {
  return BoxService();
});

final epgLocalDBProvider = Provider.autoDispose<IEPGLocalDB>((ref) {
  final boxService = ref.read(boxServiceProvider);
  return EPGLocalDB(boxService);
});

final epgRepositoryProvider = Provider.autoDispose<IEPGRepository>((ref) {
  final epgRestClient = ref.read(epgRestClientProvider);
  final connectivityService = ref.read(connectivityServiceProvider);
  final epgLocalDB = ref.read(epgLocalDBProvider);
  return EpgRepository(restClient: epgRestClient, connectivityService: connectivityService, localDB: epgLocalDB);
});
