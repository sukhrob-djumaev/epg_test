import 'package:freezed_annotation/freezed_annotation.dart';
import 'programme.dart';

part 'programme_cache.freezed.dart';

@freezed
abstract class ProgrammeCache with _$ProgrammeCache {
  const factory ProgrammeCache({
    required String channelId,
    required DateTime lastUpdated,
    required List<Programme> programmes,
  }) = _ProgrammeCache;
}
