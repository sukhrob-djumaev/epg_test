import 'package:epg_test/core/widgets/app_async_data_empty.dart';
import 'package:epg_test/core/widgets/app_async_error.dart';
import 'package:epg_test/core/widgets/app_async_loading.dart';
import 'package:epg_test/features/epg/notifiers/programme_notifier.dart';
import 'package:epg_test/features/epg/widgets/programme_item.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProgrammeList extends HookConsumerWidget {
  final String channelId;
  final DateTime day;
  const ProgrammeList({super.key, required this.channelId, required this.day});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final programmeState = ref.watch(programmeNotifierProvider(channelId: channelId, day: day));
    final programmeNotifier = ref.read(programmeNotifierProvider(channelId: channelId, day: day).notifier);

    return programmeState.when(
      data:
          (programmeCache) =>
              programmeCache == null || programmeCache.programmes.isEmpty
                  ? AppAsyncDataEmpty()
                  : RefreshIndicator(
                    onRefresh: () async => programmeNotifier.ref.invalidateSelf(),
                    child: ListView.builder(
                      itemCount: programmeCache.programmes.length,
                      itemBuilder: (context, index) => ProgrammeItem(item: programmeCache.programmes[index]),
                    ),
                  ),
      loading: () => AppAsyncLoading(),
      error: (err, _) => AppAsyncError(text: 'Error: $err', onRetry: programmeNotifier.ref.invalidateSelf),
    );
  }
}
