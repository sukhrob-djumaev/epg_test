import 'package:auto_route/auto_route.dart';
import 'package:epg_test/core/widgets/app_async_data_empty.dart';
import 'package:epg_test/core/widgets/app_async_error.dart';
import 'package:epg_test/core/widgets/app_async_loading.dart';
import 'package:epg_test/features/epg/notifiers/channel_notifier.dart';
import 'package:epg_test/features/epg/widgets/channel_item.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class ChannelsPage extends HookConsumerWidget {
  const ChannelsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final channelState = ref.watch(channelNotifierProvider);
    final channelNotifier = ref.read(channelNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('TV Channels')),
      body: channelState.when(
        data:
            (channelCache) =>
                channelCache == null || channelCache.channels.isEmpty
                    ? AppAsyncDataEmpty()
                    : RefreshIndicator(
                      onRefresh: () async => channelNotifier.ref.invalidateSelf(),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                        itemCount: channelCache.channels.length,
                        itemBuilder: (context, index) => ChannelItem(item: channelCache.channels[index]),
                      ),
                    ),
        loading: () => AppAsyncLoading(),
        error: (err, _) => AppAsyncError(text: 'Error: $err', onRetry: channelNotifier.ref.invalidateSelf),
      ),
    );
  }
}
