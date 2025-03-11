import 'package:epg_test/core/exceptions/app_exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:epg_test/features/epg/repositories/epg_repository.dart';
import 'package:epg_test/features/epg/data_sources/epg_rest_client.dart';
import 'package:epg_test/features/epg/data_sources/epg_local_db.dart';
import 'package:epg_test/core/services/network/connectivity_service.dart';
import 'package:epg_test/features/epg/models/channel_cache.dart';
import 'package:epg_test/features/epg/models/programme_cache.dart';
import 'package:epg_test/features/epg/models/channel.dart';
import 'package:epg_test/features/epg/models/programme.dart';
import 'dart:io';

// ✅ Register Fakes
class FakeChannelCache extends Fake implements ChannelCache {}

class FakeProgrammeCache extends Fake implements ProgrammeCache {}

class MockEPGRestClient extends Mock implements IEPGRestClient {}

class MockEPGLocalDB extends Mock implements IEPGLocalDB {}

class MockConnectivityService extends Mock implements IConnectivityService {}

void main() {
  late MockEPGRestClient mockRestClient;
  late MockEPGLocalDB mockLocalDB;
  late MockConnectivityService mockConnectivityService;
  late EpgRepository repository;

  setUpAll(() {
    registerFallbackValue(FakeChannelCache());
    registerFallbackValue(FakeProgrammeCache());
  });

  setUp(() {
    mockRestClient = MockEPGRestClient();
    mockLocalDB = MockEPGLocalDB();
    mockConnectivityService = MockConnectivityService();
    repository = EpgRepository(
      restClient: mockRestClient,
      connectivityService: mockConnectivityService,
      localDB: mockLocalDB,
    );
  });

  group('getChannels', () {
    test('should return cached channels first and then fetch from API', () async {
      final cachedChannels = ChannelCache(
        lastUpdated: DateTime.now(),
        channels: [Channel(id: '1', displayName: 'Channel One', url: '', icon: '')],
      );
      final apiChannels = [Channel(id: '2', displayName: 'Channel Two', url: '', icon: '')];
      final updatedCache = ChannelCache(lastUpdated: DateTime.now(), channels: apiChannels);

      when(() => mockLocalDB.getCachedChannels()).thenReturn(cachedChannels);
      when(() => mockConnectivityService.hasInternetConnection).thenAnswer((_) async => true);
      when(() => mockRestClient.fetchChannels()).thenAnswer((_) async => apiChannels);
      when(() => mockLocalDB.cacheChannels(any())).thenAnswer((_) async => updatedCache);

      final result = repository.getChannels().asBroadcastStream();

      expect(await result.first, equals(cachedChannels));
      expect(await result.last, equals(updatedCache));

      verify(() => mockLocalDB.getCachedChannels()).called(1);
      verify(() => mockRestClient.fetchChannels()).called(1);
      verify(() => mockLocalDB.cacheChannels(apiChannels)).called(1);
    });

    test('should return cached channels if offline', () async {
      final cachedChannels = ChannelCache(
        lastUpdated: DateTime.now(),
        channels: [Channel(id: '1', displayName: 'Channel One', url: '', icon: '')],
      );

      when(() => mockLocalDB.getCachedChannels()).thenReturn(cachedChannels);
      when(() => mockConnectivityService.hasInternetConnection).thenAnswer((_) async => false);

      final result = repository.getChannels();
      expect(await result.first, equals(cachedChannels));

      verify(() => mockLocalDB.getCachedChannels()).called(1);
      verifyNever(() => mockRestClient.fetchChannels());
    });

    test('should throw NetworkException if API fails due to connectivity', () async {
      when(() => mockLocalDB.getCachedChannels()).thenReturn(null);
      when(() => mockConnectivityService.hasInternetConnection).thenAnswer((_) async => true);
      when(() => mockRestClient.fetchChannels()).thenThrow(SocketException("No Internet"));

      final result = repository.getChannels();
      expect(() => result.first, throwsA(isA<NetworkException>()));
    });
    test('should throw CacheException when local database fails', () async {
      when(() => mockLocalDB.getCachedChannels()).thenThrow(HiveError("Hive error"));

      final result = repository.getChannels();

      expect(() => result.first, throwsA(isA<CacheException>()));
    });

    test('should throw ServerException when API response is invalid', () async {
      when(() => mockConnectivityService.hasInternetConnection).thenAnswer((_) async => true);
      when(() => mockRestClient.fetchChannels()).thenThrow(Exception("Server Error"));

      final result = repository.getChannels();

      expect(() => result.first, throwsA(isA<ServerException>()));
    });
  });

  group('getProgrammes', () {
    test('should return cached programmes first and then fetch from API', () async {
      final cachedProgrammes = ProgrammeCache(
        channelId: '1',
        lastUpdated: DateTime.now(),
        programmes: [
          Programme(channelId: '1', title: 'Morning Show', start: DateTime.now(), end: DateTime.now(), desc: ''),
        ],
      );
      final apiProgrammes = [
        Programme(channelId: '1', title: 'Evening Show', start: DateTime.now(), end: DateTime.now(), desc: ''),
      ];
      final updatedCache = ProgrammeCache(channelId: '1', lastUpdated: DateTime.now(), programmes: apiProgrammes);

      when(() => mockLocalDB.getCachedProgrammes(any(), any())).thenReturn(cachedProgrammes);
      when(() => mockConnectivityService.hasInternetConnection).thenAnswer((_) async => true);
      when(
        () => mockRestClient.fetchProgrammes(channelId: any(named: 'channelId'), day: any(named: 'day')),
      ).thenAnswer((_) async => apiProgrammes);
      when(() => mockLocalDB.cacheProgrammes(any(), any(), any())).thenAnswer((_) async => updatedCache);

      final result = repository.getProgrammes(channelId: '1', day: DateTime.now()).asBroadcastStream();

      expect(await result.first, equals(cachedProgrammes));
      expect(await result.last, equals(updatedCache));

      verify(() => mockLocalDB.getCachedProgrammes('1', any())).called(1);
      verify(() => mockRestClient.fetchProgrammes(channelId: '1', day: any(named: 'day'))).called(1);
      verify(() => mockLocalDB.cacheProgrammes('1', any(), apiProgrammes)).called(1);
    });

    test('should return cached programmes if offline', () async {
      final cachedProgrammes = ProgrammeCache(
        channelId: '1',
        lastUpdated: DateTime.now(),
        programmes: [
          Programme(channelId: '1', title: 'Morning Show', start: DateTime.now(), end: DateTime.now(), desc: ''),
        ],
      );

      when(() => mockLocalDB.getCachedProgrammes(any(), any())).thenReturn(cachedProgrammes);
      when(() => mockConnectivityService.hasInternetConnection).thenAnswer((_) async => false);

      final result = repository.getProgrammes(channelId: '1', day: DateTime.now());

      expect(await result.first, equals(cachedProgrammes));

      verify(() => mockLocalDB.getCachedProgrammes('1', any())).called(1);
      verifyNever(() => mockRestClient.fetchProgrammes(channelId: any(named: 'channelId'), day: any(named: 'day')));
    });

    test('should throw NetworkException if API fails due to connectivity', () async {
      when(() => mockLocalDB.getCachedProgrammes(any(), any())).thenReturn(null);
      when(() => mockConnectivityService.hasInternetConnection).thenAnswer((_) async => true);
      when(
        () => mockRestClient.fetchProgrammes(channelId: any(named: 'channelId'), day: any(named: 'day')),
      ).thenThrow(SocketException("No Internet"));

      final result = repository.getProgrammes(channelId: '1', day: DateTime.now());
      expect(() => result.first, throwsA(isA<NetworkException>()));
    });
    test('should throw CacheException when local database fails', () async {
      when(() => mockLocalDB.getCachedProgrammes(any(), any())).thenThrow(HiveError("Hive error"));

      final result = repository.getProgrammes(channelId: '1', day: DateTime.now());

      expect(() => result.first, throwsA(isA<CacheException>()));
    });

    test('should throw ServerException when API response is invalid', () async {
      when(() => mockConnectivityService.hasInternetConnection).thenAnswer((_) async => true);
      when(
        () => mockRestClient.fetchProgrammes(channelId: any(named: 'channelId'), day: any(named: 'day')),
      ).thenThrow(Exception("Server Error"));

      final result = repository.getProgrammes(channelId: '1', day: DateTime.now());

      expect(() => result.first, throwsA(isA<ServerException>()));
    });
  });
}
