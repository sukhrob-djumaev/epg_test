// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'channel_cache.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChannelCache {

 DateTime get lastUpdated; List<Channel> get channels;
/// Create a copy of ChannelCache
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChannelCacheCopyWith<ChannelCache> get copyWith => _$ChannelCacheCopyWithImpl<ChannelCache>(this as ChannelCache, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChannelCache&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&const DeepCollectionEquality().equals(other.channels, channels));
}


@override
int get hashCode => Object.hash(runtimeType,lastUpdated,const DeepCollectionEquality().hash(channels));

@override
String toString() {
  return 'ChannelCache(lastUpdated: $lastUpdated, channels: $channels)';
}


}

/// @nodoc
abstract mixin class $ChannelCacheCopyWith<$Res>  {
  factory $ChannelCacheCopyWith(ChannelCache value, $Res Function(ChannelCache) _then) = _$ChannelCacheCopyWithImpl;
@useResult
$Res call({
 DateTime lastUpdated, List<Channel> channels
});




}
/// @nodoc
class _$ChannelCacheCopyWithImpl<$Res>
    implements $ChannelCacheCopyWith<$Res> {
  _$ChannelCacheCopyWithImpl(this._self, this._then);

  final ChannelCache _self;
  final $Res Function(ChannelCache) _then;

/// Create a copy of ChannelCache
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lastUpdated = null,Object? channels = null,}) {
  return _then(_self.copyWith(
lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,channels: null == channels ? _self.channels : channels // ignore: cast_nullable_to_non_nullable
as List<Channel>,
  ));
}

}


/// @nodoc


class _ChannelCache implements ChannelCache {
  const _ChannelCache({required this.lastUpdated, required final  List<Channel> channels}): _channels = channels;
  

@override final  DateTime lastUpdated;
 final  List<Channel> _channels;
@override List<Channel> get channels {
  if (_channels is EqualUnmodifiableListView) return _channels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_channels);
}


/// Create a copy of ChannelCache
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChannelCacheCopyWith<_ChannelCache> get copyWith => __$ChannelCacheCopyWithImpl<_ChannelCache>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChannelCache&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&const DeepCollectionEquality().equals(other._channels, _channels));
}


@override
int get hashCode => Object.hash(runtimeType,lastUpdated,const DeepCollectionEquality().hash(_channels));

@override
String toString() {
  return 'ChannelCache(lastUpdated: $lastUpdated, channels: $channels)';
}


}

/// @nodoc
abstract mixin class _$ChannelCacheCopyWith<$Res> implements $ChannelCacheCopyWith<$Res> {
  factory _$ChannelCacheCopyWith(_ChannelCache value, $Res Function(_ChannelCache) _then) = __$ChannelCacheCopyWithImpl;
@override @useResult
$Res call({
 DateTime lastUpdated, List<Channel> channels
});




}
/// @nodoc
class __$ChannelCacheCopyWithImpl<$Res>
    implements _$ChannelCacheCopyWith<$Res> {
  __$ChannelCacheCopyWithImpl(this._self, this._then);

  final _ChannelCache _self;
  final $Res Function(_ChannelCache) _then;

/// Create a copy of ChannelCache
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lastUpdated = null,Object? channels = null,}) {
  return _then(_ChannelCache(
lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,channels: null == channels ? _self._channels : channels // ignore: cast_nullable_to_non_nullable
as List<Channel>,
  ));
}


}

// dart format on
