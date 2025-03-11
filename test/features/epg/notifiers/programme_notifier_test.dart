import 'package:epg_test/core/exceptions/app_exception.dart';
import 'package:epg_test/core/providers/providers.dart';
import 'package:epg_test/core/widgets/app_async_data_empty.dart';
import 'package:epg_test/core/widgets/app_async_error.dart';
import 'package:epg_test/core/widgets/app_async_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:epg_test/features/epg/widgets/programme_list.dart';
import 'package:epg_test/features/epg/repositories/epg_repository.dart';
import 'package:epg_test/features/epg/models/programme_cache.dart';
import 'package:epg_test/features/epg/models/programme.dart';

/// A fake implementation of `IEPGRepository` that simulates fetching programmes.
class FakeIEPGRepository extends Fake implements IEPGRepository {
  @override
  Stream<ProgrammeCache?> getProgrammes({required String channelId, required DateTime day}) async* {
    final programmes = [
      Programme(
        channelId: channelId,
        title: 'Morning Show',
        start: DateTime.now(),
        end: DateTime.now().add(Duration(hours: 1)),
        desc: 'A morning news show.',
      ),
    ];
    final programmeCache = ProgrammeCache(channelId: channelId, lastUpdated: DateTime.now(), programmes: programmes);
    yield programmeCache;
    yield programmeCache; // Simulate an update
  }
}

/// A fake implementation of `IEPGRepository` that returns an empty programme list.
class FakeEmptyEPGRepository extends Fake implements IEPGRepository {
  @override
  Stream<ProgrammeCache?> getProgrammes({required String channelId, required DateTime day}) async* {
    yield ProgrammeCache(channelId: channelId, lastUpdated: DateTime.now(), programmes: []);
  }
}

/// A fake implementation of `IEPGRepository` that throws a `NetworkException`.
class FakeErrorEPGRepository extends Fake implements IEPGRepository {
  @override
  Stream<ProgrammeCache?> getProgrammes({required String channelId, required DateTime day}) async* {
    throw NetworkException();
  }
}

void main() {
  group('ProgrammeNotifier UI Tests', () {
    const testChannelId = '1';
    final testDay = DateTime.now();

    testWidgets('Displays a loading indicator initially', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [epgRepositoryProvider.overrideWithValue(FakeIEPGRepository())],
          child: MaterialApp(home: ProgrammeList(channelId: testChannelId, day: testDay)),
        ),
      );

      // Verify that the loading state is displayed
      expect(find.byType(AppAsyncLoading), findsOneWidget);

      await tester.pump(); // Wait for UI rebuild

      // Verify that the loading state disappears after data loads
      expect(find.byType(AppAsyncLoading), findsNothing);
    });

    testWidgets('Displays programme items after repository returns values', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [epgRepositoryProvider.overrideWithValue(FakeIEPGRepository())],
          child: MaterialApp(home: ProgrammeList(channelId: testChannelId, day: testDay)),
        ),
      );

      await tester.pump();
      await tester.pump();

      // Verify that the correct programme is displayed
      expect(find.text('Morning Show'), findsOneWidget);
      expect(find.text('A morning news show.'), findsOneWidget);
    });

    testWidgets('Displays an empty state when no programmes are available', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [epgRepositoryProvider.overrideWithValue(FakeEmptyEPGRepository())],
          child: MaterialApp(home: ProgrammeList(channelId: testChannelId, day: testDay)),
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
          child: MaterialApp(home: ProgrammeList(channelId: testChannelId, day: testDay)),
        ),
      );

      await tester.pump();
      await tester.pump();

      // Verify that the error state is displayed
      expect(find.byType(AppAsyncError), findsOneWidget);
      expect(find.textContaining('Error'), findsOneWidget);
    });

    testWidgets('Updates UI when the stream updates data', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [epgRepositoryProvider.overrideWithValue(FakeIEPGRepository())],
          child: MaterialApp(home: ProgrammeList(channelId: testChannelId, day: testDay)),
        ),
      );
      await tester.pump();
      expect(find.text('Morning Show'), findsOneWidget);

      await tester.pump(); // Simulate stream update
      expect(find.text('Morning Show'), findsOneWidget);
    });
  });
}
