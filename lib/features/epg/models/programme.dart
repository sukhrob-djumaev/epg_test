import 'package:freezed_annotation/freezed_annotation.dart';

part 'programme.freezed.dart';

@freezed
abstract class Programme with _$Programme {
  const factory Programme({
    required String channelId,
    required DateTime start,
    required DateTime end,
    required String title,
    required String desc,
  }) = _Programme;
}
