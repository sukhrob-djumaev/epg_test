// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'programme_cache.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProgrammeCache {

 String get channelId; DateTime get lastUpdated; List<Programme> get programmes;
/// Create a copy of ProgrammeCache
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProgrammeCacheCopyWith<ProgrammeCache> get copyWith => _$ProgrammeCacheCopyWithImpl<ProgrammeCache>(this as ProgrammeCache, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProgrammeCache&&(identical(other.channelId, channelId) || other.channelId == channelId)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&const DeepCollectionEquality().equals(other.programmes, programmes));
}


@override
int get hashCode => Object.hash(runtimeType,channelId,lastUpdated,const DeepCollectionEquality().hash(programmes));

@override
String toString() {
  return 'ProgrammeCache(channelId: $channelId, lastUpdated: $lastUpdated, programmes: $programmes)';
}


}

/// @nodoc
abstract mixin class $ProgrammeCacheCopyWith<$Res>  {
  factory $ProgrammeCacheCopyWith(ProgrammeCache value, $Res Function(ProgrammeCache) _then) = _$ProgrammeCacheCopyWithImpl;
@useResult
$Res call({
 String channelId, DateTime lastUpdated, List<Programme> programmes
});




}
/// @nodoc
class _$ProgrammeCacheCopyWithImpl<$Res>
    implements $ProgrammeCacheCopyWith<$Res> {
  _$ProgrammeCacheCopyWithImpl(this._self, this._then);

  final ProgrammeCache _self;
  final $Res Function(ProgrammeCache) _then;

/// Create a copy of ProgrammeCache
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? channelId = null,Object? lastUpdated = null,Object? programmes = null,}) {
  return _then(_self.copyWith(
channelId: null == channelId ? _self.channelId : channelId // ignore: cast_nullable_to_non_nullable
as String,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,programmes: null == programmes ? _self.programmes : programmes // ignore: cast_nullable_to_non_nullable
as List<Programme>,
  ));
}

}


/// @nodoc


class _ProgrammeCache implements ProgrammeCache {
  const _ProgrammeCache({required this.channelId, required this.lastUpdated, required final  List<Programme> programmes}): _programmes = programmes;
  

@override final  String channelId;
@override final  DateTime lastUpdated;
 final  List<Programme> _programmes;
@override List<Programme> get programmes {
  if (_programmes is EqualUnmodifiableListView) return _programmes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_programmes);
}


/// Create a copy of ProgrammeCache
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProgrammeCacheCopyWith<_ProgrammeCache> get copyWith => __$ProgrammeCacheCopyWithImpl<_ProgrammeCache>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProgrammeCache&&(identical(other.channelId, channelId) || other.channelId == channelId)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&const DeepCollectionEquality().equals(other._programmes, _programmes));
}


@override
int get hashCode => Object.hash(runtimeType,channelId,lastUpdated,const DeepCollectionEquality().hash(_programmes));

@override
String toString() {
  return 'ProgrammeCache(channelId: $channelId, lastUpdated: $lastUpdated, programmes: $programmes)';
}


}

/// @nodoc
abstract mixin class _$ProgrammeCacheCopyWith<$Res> implements $ProgrammeCacheCopyWith<$Res> {
  factory _$ProgrammeCacheCopyWith(_ProgrammeCache value, $Res Function(_ProgrammeCache) _then) = __$ProgrammeCacheCopyWithImpl;
@override @useResult
$Res call({
 String channelId, DateTime lastUpdated, List<Programme> programmes
});




}
/// @nodoc
class __$ProgrammeCacheCopyWithImpl<$Res>
    implements _$ProgrammeCacheCopyWith<$Res> {
  __$ProgrammeCacheCopyWithImpl(this._self, this._then);

  final _ProgrammeCache _self;
  final $Res Function(_ProgrammeCache) _then;

/// Create a copy of ProgrammeCache
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? channelId = null,Object? lastUpdated = null,Object? programmes = null,}) {
  return _then(_ProgrammeCache(
channelId: null == channelId ? _self.channelId : channelId // ignore: cast_nullable_to_non_nullable
as String,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,programmes: null == programmes ? _self._programmes : programmes // ignore: cast_nullable_to_non_nullable
as List<Programme>,
  ));
}


}

// dart format on
