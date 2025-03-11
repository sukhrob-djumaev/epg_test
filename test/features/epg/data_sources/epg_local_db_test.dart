import 'package:epg_test/core/constants/boxes.dart';
import 'package:epg_test/core/services/local_db/box_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:epg_test/features/epg/data_sources/epg_local_db.dart';
import 'package:epg_test/features/epg/models/channel.dart';
import 'package:epg_test/features/epg/models/programme.dart';
import 'package:epg_test/features/epg/models/channel_cache.dart';
import 'package:epg_test/features/epg/models/programme_cache.dart';

/// Fake implementation of `ChannelCache` for mocktail.
class FakeChannelCache extends Fake implements ChannelCache {}

/// Fake implementation of `ProgrammeCache` for mocktail.
class FakeProgrammeCache extends Fake implements ProgrammeCache {}

/// Mock implementation of `IBoxService` to simulate local storage.
class MockBoxService extends Mock implements IBoxService {}

void main() {
  late MockBoxService mockBoxService;
  late EPGLocalDB epgLocalDB;

  setUpAll(() {
    registerFallbackValue(FakeChannelCache());
    registerFallbackValue(FakeProgrammeCache());
  });

  setUp(() {
    mockBoxService = MockBoxService();
    epgLocalDB = EPGLocalDB(mockBoxService);
  });

  group('cacheChannels', () {
    test('should save channels to local storage', () async {
      final testChannels = [
        Channel(id: '1', displayName: 'Channel One', url: '', icon: ''),
        Channel(id: '2', displayName: 'Channel Two', url: '', icon: ''),
      ];

      when(() => mockBoxService.put<ChannelCache>(channelsBox, any(), any())).thenAnswer((_) async {});

      final result = await epgLocalDB.cacheChannels(testChannels);

      // Ensure the correct data was stored
      expect(result.channels, equals(testChannels));
      verify(() => mockBoxService.put<ChannelCache>(channelsBox, 'cached_channels', any())).called(1);
    });

    test('should retrieve cached channels from local storage', () {
      final testChannels = [
        Channel(id: '1', displayName: 'Channel One', url: '', icon: ''),
        Channel(id: '2', displayName: 'Channel Two', url: '', icon: ''),
      ];
      final channelCache = ChannelCache(lastUpdated: DateTime.now(), channels: testChannels);

      when(() => mockBoxService.get<ChannelCache>(channelsBox, any())).thenReturn(channelCache);

      final result = epgLocalDB.getCachedChannels();

      // Ensure retrieved data matches the stored cache
      expect(result, equals(channelCache));
      verify(() => mockBoxService.get<ChannelCache>(channelsBox, 'cached_channels')).called(1);
    });

    test('should return null if no cached channels exist', () {
      when(() => mockBoxService.get<ChannelCache>(channelsBox, any())).thenReturn(null);

      final result = epgLocalDB.getCachedChannels();

      // Ensure null is returned when no cache exists
      expect(result, isNull);
      verify(() => mockBoxService.get<ChannelCache>(channelsBox, 'cached_channels')).called(1);
    });
  });

  group('cacheProgrammes', () {
    test('should save programmes to local storage', () async {
      final testProgrammes = [
        Programme(channelId: '1', title: 'Morning Show', start: DateTime.now(), end: DateTime.now(), desc: ''),
        Programme(channelId: '1', title: 'News', start: DateTime.now(), end: DateTime.now(), desc: ''),
      ];
      final key = 'programmes_1_${DateTime.now().toIso8601String().split("T")[0]}';

      when(() => mockBoxService.put<ProgrammeCache>(programmesBox, key, any())).thenAnswer((_) async {});

      final result = await epgLocalDB.cacheProgrammes('1', DateTime.now(), testProgrammes);

      // Ensure programmes are saved correctly
      expect(result.programmes, equals(testProgrammes));
      verify(() => mockBoxService.put<ProgrammeCache>(programmesBox, key, any())).called(1);
    });

    test('should retrieve cached programmes from local storage', () {
      final testProgrammes = [
        Programme(channelId: '1', title: 'Morning Show', start: DateTime.now(), end: DateTime.now(), desc: ''),
        Programme(channelId: '1', title: 'News', start: DateTime.now(), end: DateTime.now(), desc: ''),
      ];
      final programmeCache = ProgrammeCache(channelId: '1', lastUpdated: DateTime.now(), programmes: testProgrammes);
      final key = 'programmes_1_${DateTime.now().toIso8601String().split("T")[0]}';

      when(() => mockBoxService.get<ProgrammeCache>(programmesBox, key)).thenReturn(programmeCache);

      final result = epgLocalDB.getCachedProgrammes('1', DateTime.now());

      // Ensure retrieved programmes match stored cache
      expect(result, equals(programmeCache));
      verify(() => mockBoxService.get<ProgrammeCache>(programmesBox, key)).called(1);
    });

    test('should return null if no cached programmes exist', () {
      final key = 'programmes_1_${DateTime.now().toIso8601String().split("T")[0]}';

      when(() => mockBoxService.get<ProgrammeCache>(programmesBox, key)).thenReturn(null);

      final result = epgLocalDB.getCachedProgrammes('1', DateTime.now());

      // Ensure null is returned when no cache exists
      expect(result, isNull);
      verify(() => mockBoxService.get<ProgrammeCache>(programmesBox, key)).called(1);
    });
  });
}
