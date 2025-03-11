// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'programme.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Programme {

 String get channelId; DateTime get start; DateTime get end; String get title; String get desc;
/// Create a copy of Programme
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProgrammeCopyWith<Programme> get copyWith => _$ProgrammeCopyWithImpl<Programme>(this as Programme, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Programme&&(identical(other.channelId, channelId) || other.channelId == channelId)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.title, title) || other.title == title)&&(identical(other.desc, desc) || other.desc == desc));
}


@override
int get hashCode => Object.hash(runtimeType,channelId,start,end,title,desc);

@override
String toString() {
  return 'Programme(channelId: $channelId, start: $start, end: $end, title: $title, desc: $desc)';
}


}

/// @nodoc
abstract mixin class $ProgrammeCopyWith<$Res>  {
  factory $ProgrammeCopyWith(Programme value, $Res Function(Programme) _then) = _$ProgrammeCopyWithImpl;
@useResult
$Res call({
 String channelId, DateTime start, DateTime end, String title, String desc
});




}
/// @nodoc
class _$ProgrammeCopyWithImpl<$Res>
    implements $ProgrammeCopyWith<$Res> {
  _$ProgrammeCopyWithImpl(this._self, this._then);

  final Programme _self;
  final $Res Function(Programme) _then;

/// Create a copy of Programme
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? channelId = null,Object? start = null,Object? end = null,Object? title = null,Object? desc = null,}) {
  return _then(_self.copyWith(
channelId: null == channelId ? _self.channelId : channelId // ignore: cast_nullable_to_non_nullable
as String,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc


class _Programme implements Programme {
  const _Programme({required this.channelId, required this.start, required this.end, required this.title, required this.desc});
  

@override final  String channelId;
@override final  DateTime start;
@override final  DateTime end;
@override final  String title;
@override final  String desc;

/// Create a copy of Programme
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProgrammeCopyWith<_Programme> get copyWith => __$ProgrammeCopyWithImpl<_Programme>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Programme&&(identical(other.channelId, channelId) || other.channelId == channelId)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.title, title) || other.title == title)&&(identical(other.desc, desc) || other.desc == desc));
}


@override
int get hashCode => Object.hash(runtimeType,channelId,start,end,title,desc);

@override
String toString() {
  return 'Programme(channelId: $channelId, start: $start, end: $end, title: $title, desc: $desc)';
}


}

/// @nodoc
abstract mixin class _$ProgrammeCopyWith<$Res> implements $ProgrammeCopyWith<$Res> {
  factory _$ProgrammeCopyWith(_Programme value, $Res Function(_Programme) _then) = __$ProgrammeCopyWithImpl;
@override @useResult
$Res call({
 String channelId, DateTime start, DateTime end, String title, String desc
});




}
/// @nodoc
class __$ProgrammeCopyWithImpl<$Res>
    implements _$ProgrammeCopyWith<$Res> {
  __$ProgrammeCopyWithImpl(this._self, this._then);

  final _Programme _self;
  final $Res Function(_Programme) _then;

/// Create a copy of Programme
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? channelId = null,Object? start = null,Object? end = null,Object? title = null,Object? desc = null,}) {
  return _then(_Programme(
channelId: null == channelId ? _self.channelId : channelId // ignore: cast_nullable_to_non_nullable
as String,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
