import 'package:freezed_annotation/freezed_annotation.dart';

part 'channel.freezed.dart';

@freezed
abstract class Channel with _$Channel {
  const factory Channel({required String id, required String displayName, required String url, required String icon}) =
      _Channel;
}
