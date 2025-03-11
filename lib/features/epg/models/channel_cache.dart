import 'package:epg_test/features/epg/models/channel.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'channel_cache.freezed.dart';

@freezed
abstract class ChannelCache with _$ChannelCache {
  const factory ChannelCache({required DateTime lastUpdated, required List<Channel> channels}) = _ChannelCache;
}
