import 'dart:async';
import 'dart:io';

import 'package:epg_test/core/exceptions/app_exception.dart';
import 'package:epg_test/core/services/network/connectivity_service.dart';
import 'package:epg_test/features/epg/data_sources/epg_local_db.dart';
import 'package:epg_test/features/epg/data_sources/epg_rest_client.dart';
import 'package:epg_test/features/epg/models/channel_cache.dart';
import 'package:epg_test/features/epg/models/programme_cache.dart';
import 'package:hive_ce/hive.dart';

/// Repository interface for fetching EPG data.
abstract interface class IEPGRepository {
  /// Fetches channels from cache first, then updates from API if online.
  Stream<ChannelCache?> getChannels();

  /// Fetches programmes for a specific channel and day.
  Stream<ProgrammeCache?> getProgrammes({required String channelId, required DateTime day});
}

/// Handles fetching and caching of EPG data, following an offline-first approach.
final class EpgRepository implements IEPGRepository {
  final IEPGRestClient _restClient;
  final IConnectivityService _connectivityService;
  final IEPGLocalDB _localDB;

  EpgRepository({
    required IEPGRestClient restClient,
    required IConnectivityService connectivityService,
    required IEPGLocalDB localDB,
  }) : _restClient = restClient,
       _connectivityService = connectivityService,
       _localDB = localDB;

  @override
  Stream<ChannelCache?> getChannels() async* {
    try {
      final cachedChannels = _localDB.getCachedChannels();
      if (cachedChannels != null) yield cachedChannels;

      if (await _connectivityService.hasInternetConnection) {
        final channels = await _restClient.fetchChannels();
        yield await _localDB.cacheChannels(channels);
      }
    } catch (e) {
      _handleException(e);
    }
  }

  @override
  Stream<ProgrammeCache?> getProgrammes({required String channelId, required DateTime day}) async* {
    try {
      final cachedProgramme = _localDB.getCachedProgrammes(channelId, day);
      if (cachedProgramme != null) yield cachedProgramme;

      if (await _connectivityService.hasInternetConnection) {
        final programmes = await _restClient.fetchProgrammes(channelId: channelId, day: day);
        yield await _localDB.cacheProgrammes(channelId, day, programmes);
      }
    } catch (e) {
      _handleException(e);
    }
  }

  void _handleException(dynamic e) {
    if (e is SocketException) throw NetworkException();
    if (e is HiveError) throw CacheException();
    throw ServerException();
  }
}
