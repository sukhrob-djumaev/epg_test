import 'package:epg_test/core/services/network/dio_service.dart';
import 'package:epg_test/core/utils/xml.dart';
import 'package:epg_test/features/epg/models/channel.dart';
import 'package:epg_test/features/epg/models/programme.dart';
import 'package:xml/xml_events.dart';

/// Interface for fetching EPG data from a remote source.
abstract interface class IEPGRestClient {
  /// Fetches a list of available TV channels.
  Future<List<Channel>> fetchChannels();

  /// Fetches TV programmes for a given channel and day.
  Future<List<Programme>> fetchProgrammes({required String channelId, required DateTime day});
}

/// Implementation of `IEPGRestClient` using Dio for network requests.
class EPGRestClient implements IEPGRestClient {
  final DioService _dioService;

  EPGRestClient({required DioService dioService}) : _dioService = dioService;

  /// Fetches and parses the list of TV channels from XML data.
  @override
  Future<List<Channel>> fetchChannels() async {
    final channels = <Channel>[];
    final xmlStream = await _dioService.fetchXmlStream('epg_tvprofil.net.xml');

    String? currentTag;
    Map<String, String>? currentChannel;
    String? currentValue;

    await for (final event in xmlStream) {
      if (event is XmlStartElementEvent) {
        if (event.name == 'channel') {
          currentChannel = {};
        }

        if (currentChannel != null) {
          for (final attr in event.attributes) {
            currentChannel['${event.name}-${attr.localName}'] = attr.value;
          }
        }

        currentTag = event.name;
        currentValue = '';
      } else if (event is XmlEndElementEvent && event.name == 'channel') {
        if (currentChannel != null) {
          channels.add(
            Channel(
              id: currentChannel['channel-id'] ?? '',
              displayName: currentChannel['display-name'] ?? '',
              icon: currentChannel['icon-src'] ?? '',
              url: currentChannel['url'] ?? '',
            ),
          );
        }
        currentChannel = null;
      } else if (event is XmlEndElementEvent && event.name == currentTag && currentChannel != null) {
        currentChannel[currentTag!] = currentValue ?? '';
        currentTag = null;
      } else if (event is XmlTextEvent && currentTag != null && currentChannel != null) {
        currentValue = (currentValue ?? '') + event.value;
      }
    }

    return channels;
  }

  /// Fetches and parses TV programmes for a specific channel and day.
  @override
  Future<List<Programme>> fetchProgrammes({required String channelId, required DateTime day}) async {
    final programmes = <Programme>[];
    final xmlStream = await _dioService.fetchXmlStream('epg_tvprofil.net.xml');

    final dayBounds = getDayTimeBounds(day);
    final dayStartStr = dayBounds['start']!;
    final dayEndStr = dayBounds['end']!;

    String? currentTag;
    Map<String, String>? currentProgramme;
    String? currentValue;
    bool isProgrammeForRequestedChannel = false;
    bool isProgrammeInRequestedTimeframe = false;

    await for (final event in xmlStream) {
      if (event is XmlStartElementEvent) {
        if (event.name == 'programme') {
          currentProgramme = {};
        }

        if (currentProgramme != null) {
          for (final attr in event.attributes) {
            currentProgramme['${event.name}-${attr.localName}'] = attr.value;
          }
        }

        currentTag = event.name;
        currentValue = '';
      } else if (event is XmlEndElementEvent && event.name == 'programme') {
        if (currentProgramme != null) {
          isProgrammeForRequestedChannel = (currentProgramme['programme-channel'] == channelId);
          isProgrammeInRequestedTimeframe = false;

          final startTime = currentProgramme['programme-start'] ?? '';
          if (startTime.isNotEmpty) {
            final startDatePart = startTime.substring(0, 14);
            isProgrammeInRequestedTimeframe =
                startDatePart.compareTo(dayStartStr) >= 0 && startDatePart.compareTo(dayEndStr) < 0;
          }

          if (isProgrammeForRequestedChannel && isProgrammeInRequestedTimeframe) {
            programmes.add(
              Programme(
                channelId: currentProgramme['programme-channel'] ?? '',
                title: currentProgramme['title'] ?? '',
                start: parseEPGDateTime(currentProgramme['programme-start']!),
                end: parseEPGDateTime(currentProgramme['programme-stop']!),
                desc: currentProgramme['desc'] ?? '',
              ),
            );
          }
        }
        currentProgramme = null;
      } else if (event is XmlEndElementEvent && event.name == currentTag && currentProgramme != null) {
        currentProgramme[currentTag!] = currentValue ?? '';
        currentTag = null;
      } else if (event is XmlTextEvent && currentTag != null && currentProgramme != null) {
        currentValue = (currentValue ?? '') + event.value;
      }
    }

    return programmes;
  }
}
