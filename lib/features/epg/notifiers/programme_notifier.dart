import 'dart:async';

import 'package:epg_test/core/exceptions/app_exception.dart';
import 'package:epg_test/core/providers/providers.dart';
import 'package:epg_test/features/epg/models/programme_cache.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'programme_notifier.g.dart';

@riverpod
class ProgrammeNotifier extends _$ProgrammeNotifier {
  @override
  Stream<ProgrammeCache?> build({required String channelId, required DateTime day}) async* {
    final repository = ref.read(epgRepositoryProvider);

    try {
      // Fetches programmes for the given channel and day.
      yield* repository.getProgrammes(channelId: channelId, day: day);
    } catch (e) {
      // Ensures proper error handling.
      yield* Stream.error(e is AppException ? e : AppException("Unexpected error occurred."));
    }
  }
}
