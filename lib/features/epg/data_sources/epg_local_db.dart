import 'package:epg_test/core/constants/boxes.dart';
import 'package:epg_test/core/services/local_db/box_service.dart';
import 'package:epg_test/features/epg/models/channel_cache.dart';
import 'package:epg_test/features/epg/models/programme_cache.dart';
import '../models/channel.dart';
import '../models/programme.dart';

/// Interface for local EPG database storage.
abstract class IEPGLocalDB {
  /// Caches the list of channels and returns the saved data.
  Future<ChannelCache> cacheChannels(List<Channel> channels);

  /// Retrieves cached channels, returns `null` if not found.
  ChannelCache? getCachedChannels();

  /// Caches programmes for a given channel and day, then returns the saved data.
  Future<ProgrammeCache> cacheProgrammes(String channelId, DateTime day, List<Programme> programmes);

  /// Retrieves cached programmes for a given channel and day, returns `null` if not found.
  ProgrammeCache? getCachedProgrammes(String channelId, DateTime day);
}

/// Implementation of local EPG storage using Hive.
class EPGLocalDB implements IEPGLocalDB {
  final IBoxService _boxService;
  static const _channelsKey = 'cached_channels';

  EPGLocalDB(this._boxService);

  @override
  Future<ChannelCache> cacheChannels(List<Channel> channels) async {
    final channelCache = ChannelCache(lastUpdated: DateTime.now(), channels: channels);
    await _boxService.put<ChannelCache>(channelsBox, _channelsKey, channelCache);
    return channelCache;
  }

  @override
  ChannelCache? getCachedChannels() {
    return _boxService.get<ChannelCache>(channelsBox, _channelsKey);
  }

  @override
  Future<ProgrammeCache> cacheProgrammes(String channelId, DateTime day, List<Programme> programmes) async {
    final key = 'programmes_${channelId}_${day.toIso8601String().split("T")[0]}';
    final programmeCache = ProgrammeCache(channelId: channelId, lastUpdated: DateTime.now(), programmes: programmes);
    await _boxService.put<ProgrammeCache>(programmesBox, key, programmeCache);
    return programmeCache;
  }

  @override
  ProgrammeCache? getCachedProgrammes(String channelId, DateTime day) {
    final key = 'programmes_${channelId}_${day.toIso8601String().split("T")[0]}';
    return _boxService.get<ProgrammeCache>(programmesBox, key);
  }
}
