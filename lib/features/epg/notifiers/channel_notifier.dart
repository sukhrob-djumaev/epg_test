import 'dart:async';

import 'package:epg_test/core/exceptions/app_exception.dart';
import 'package:epg_test/core/providers/providers.dart';
import 'package:epg_test/features/epg/models/channel_cache.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'channel_notifier.g.dart';

@riverpod
class ChannelNotifier extends _$ChannelNotifier {
  @override
  Stream<ChannelCache?> build() async* {
    final repository = ref.read(epgRepositoryProvider);

    try {
      // Fetches channels from the repository (local cache first, then network).
      yield* repository.getChannels();
    } catch (e) {
      // Ensures proper error handling.
      yield* Stream.error(e is AppException ? e : AppException("Unexpected error occurred."));
    }
  }
}
