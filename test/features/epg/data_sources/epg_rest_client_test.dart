import 'package:epg_test/core/services/network/dio_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:epg_test/features/epg/data_sources/epg_rest_client.dart';
import 'package:epg_test/features/epg/models/channel.dart';
import 'package:epg_test/features/epg/models/programme.dart';
import 'package:xml/xml_events.dart';
import 'dart:async';

/// Mock implementation of `DioService` to simulate network responses.
class MockDioService extends Mock implements DioService {}

void main() {
  late MockDioService mockDioService;
  late EPGRestClient epgRestClient;

  setUp(() {
    mockDioService = MockDioService();
    epgRestClient = EPGRestClient(dioService: mockDioService);
  });

  group('fetchChannels', () {
    test('should return a list of parsed channels', () async {
      // Mock XML Stream Data
      final xmlData = '''
        <tv>
          <channel id="channel1">
            <display-name>Channel One</display-name>
            <icon src="http://example.com/icon1.png"/>
            <url>http://example.com/channel1</url>
          </channel>
          <channel id="channel2">
            <display-name>Channel Two</display-name>
            <icon src="http://example.com/icon2.png"/>
            <url>http://example.com/channel2</url>
          </channel>
        </tv>
      ''';

      // Simulating a Stream of XML events
      final xmlStream = Stream.fromIterable(parseEvents(xmlData));

      when(() => mockDioService.fetchXmlStream(any())).thenAnswer((_) async => xmlStream);

      final result = await epgRestClient.fetchChannels();

      // Verify result type
      expect(result, isA<List<Channel>>());
      expect(result.length, 2);

      // Verify first channel
      expect(result[0].id, 'channel1');
      expect(result[0].displayName, 'Channel One');
      expect(result[0].icon, 'http://example.com/icon1.png');
      expect(result[0].url, 'http://example.com/channel1');
    });

    test('should return an empty list when no channels found', () async {
      final xmlData = '<tv></tv>';
      final xmlStream = Stream.fromIterable(parseEvents(xmlData));

      when(() => mockDioService.fetchXmlStream(any())).thenAnswer((_) async => xmlStream);

      final result = await epgRestClient.fetchChannels();

      // Ensure the result is empty
      expect(result, isEmpty);
    });

    test('should throw an exception when XML parsing fails', () async {
      when(() => mockDioService.fetchXmlStream(any())).thenThrow(Exception("Network error"));

      // Ensure an exception is thrown
      expect(() => epgRestClient.fetchChannels(), throwsException);
    });
  });

  group('fetchProgrammes', () {
    test('should return a list of parsed programmes', () async {
      final xmlData = '''
        <tv>
          <programme start="20240310120000 +0000" stop="20240310130000 +0000" channel="channel1">
            <title>Morning Show</title>
            <desc>News and entertainment</desc>
          </programme>
          <programme start="20240310130000 +0000" stop="20240310140000 +0000" channel="channel1">
            <title>Midday News</title>
            <desc>Latest updates</desc>
          </programme>
        </tv>
      ''';

      final xmlStream = Stream.fromIterable(parseEvents(xmlData));

      when(() => mockDioService.fetchXmlStream(any())).thenAnswer((_) async => xmlStream);

      final result = await epgRestClient.fetchProgrammes(channelId: 'channel1', day: DateTime(2024, 3, 10));

      // Verify result type
      expect(result, isA<List<Programme>>());
      expect(result.length, 2);

      // Verify first programme
      expect(result[0].title, 'Morning Show');
      expect(result[0].desc, 'News and entertainment');
    });

    test('should return an empty list when no programmes match the date', () async {
      final xmlData = '''
        <tv>
          <programme start="20240309120000 +0000" stop="20240309130000 +0000" channel="channel1">
            <title>Old Show</title>
            <desc>Past program</desc>
          </programme>
        </tv>
      ''';

      final xmlStream = Stream.fromIterable(parseEvents(xmlData));

      when(() => mockDioService.fetchXmlStream(any())).thenAnswer((_) async => xmlStream);

      final result = await epgRestClient.fetchProgrammes(channelId: 'channel1', day: DateTime(2024, 3, 10));

      // Ensure the result is empty
      expect(result, isEmpty);
    });

    test('should throw an exception when fetching fails', () async {
      when(() => mockDioService.fetchXmlStream(any())).thenThrow(Exception("Network error"));

      // Ensure an exception is thrown
      expect(() => epgRestClient.fetchProgrammes(channelId: 'channel1', day: DateTime(2024, 3, 10)), throwsException);
    });
  });
}
