import 'package:epg_test/core/exceptions/app_exception.dart';
import 'package:epg_test/core/providers/providers.dart';
import 'package:epg_test/core/widgets/app_async_data_empty.dart';
import 'package:epg_test/core/widgets/app_async_error.dart';
import 'package:epg_test/core/widgets/app_async_loading.dart';
import 'package:epg_test/features/epg/models/channel.dart';
import 'package:epg_test/features/epg/models/channel_cache.dart';
import 'package:epg_test/features/epg/pages/channels_page.dart';
import 'package:epg_test/features/epg/repositories/epg_repository.dart';
import 'package:epg_test/features/epg/widgets/channel_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// A fake implementation of `IEPGRepository` that simulates fetching channels.
class FakeIEPGRepository extends Fake implements IEPGRepository {
  @override
  Stream<ChannelCache?> getChannels() async* {
    final channels = [
      Channel(id: '1', displayName: 'Channel One', url: '', icon: ''),
      Channel(id: '2', displayName: 'Channel Two', url: '', icon: ''),
    ];
    final channelCache = ChannelCache(lastUpdated: DateTime.now(), channels: channels);
    yield channelCache;
    yield channelCache; // Simulate an update
  }
}

/// A fake implementation of `IEPGRepository` that returns an empty list.
class FakeEmptyEPGRepository extends Fake implements IEPGRepository {
  @override
  Stream<ChannelCache?> getChannels() async* {
    yield ChannelCache(lastUpdated: DateTime.now(), channels: []);
  }
}

/// A fake implementation of `IEPGRepository` that throws a `NetworkException`.
class FakeErrorEPGRepository extends Fake implements IEPGRepository {
  @override
  Stream<ChannelCache?> getChannels() async* {
    throw NetworkException();
  }
}

void main() {
  group('ChannelNotifier UI Tests', () {
    testWidgets('Displays a loading indicator initially', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [epgRepositoryProvider.overrideWithValue(FakeIEPGRepository())],
          child: MaterialApp(home: ChannelsPage()),
        ),
      );

      // Verify that the loading state is displayed
      expect(find.byType(AppAsyncLoading), findsOneWidget);

      await tester.pump(); // Wait for UI rebuild

      // Verify that the loading state disappears after data loads
      expect(find.byType(AppAsyncLoading), findsNothing);
    });

    testWidgets('Displays channel items after repository returns values', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [epgRepositoryProvider.overrideWithValue(FakeIEPGRepository())],
          child: MaterialApp(home: ChannelsPage()),
        ),
      );

      await tester.pump();
      await tester.pump();

      // Verify that the correct number of channels are displayed
      expect(find.byType(ChannelItem), findsNWidgets(2));
    });

    testWidgets('Displays an empty state when no channels are available', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [epgRepositoryProvider.overrideWithValue(FakeEmptyEPGRepository())],
          child: MaterialApp(home: ChannelsPage()),
        ),
      );

      await tester.pump();
      await tester.pump();

      // Verify that the empty state widget is displayed
      expect(find.byType(AppAsyncDataEmpty), findsOneWidget);
    });

    testWidgets('Displays an error widget when repository throws an exception', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [epgRepositoryProvider.overrideWithValue(FakeErrorEPGRepository())],
          child: MaterialApp(home: ChannelsPage()),
        ),
      );

      await tester.pump();
      await tester.pump();

      // Verify that the error state is displayed
      expect(find.byType(AppAsyncError), findsOneWidget);
      expect(find.textContaining('Error'), findsOneWidget);
    });

    testWidgets('Updates UI when the stream updates data', (tester) async {
      final repository = FakeIEPGRepository();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [epgRepositoryProvider.overrideWithValue(repository)],
          child: MaterialApp(home: ChannelsPage()),
        ),
      );

      await tester.pump();

      // Verify initial state with channels
      expect(find.byType(ChannelItem), findsNWidgets(2));

      await tester.pump(); // Simulate stream update

      // Verify UI updates correctly after stream emits new data
      expect(find.byType(ChannelItem), findsNWidgets(2));
    });
  });
}
