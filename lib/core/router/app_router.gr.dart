// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:epg_test/features/epg/models/channel.dart' as _i5;
import 'package:epg_test/features/epg/pages/channels_page.dart' as _i1;
import 'package:epg_test/features/epg/pages/programmes_page.dart' as _i2;
import 'package:flutter/material.dart' as _i4;

/// generated route for
/// [_i1.ChannelsPage]
class ChannelsRoute extends _i3.PageRouteInfo<void> {
  const ChannelsRoute({List<_i3.PageRouteInfo>? children})
    : super(ChannelsRoute.name, initialChildren: children);

  static const String name = 'ChannelsRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i1.ChannelsPage();
    },
  );
}

/// generated route for
/// [_i2.ProgrammesPage]
class ProgrammesRoute extends _i3.PageRouteInfo<ProgrammesRouteArgs> {
  ProgrammesRoute({
    _i4.Key? key,
    required _i5.Channel channel,
    List<_i3.PageRouteInfo>? children,
  }) : super(
         ProgrammesRoute.name,
         args: ProgrammesRouteArgs(key: key, channel: channel),
         initialChildren: children,
       );

  static const String name = 'ProgrammesRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProgrammesRouteArgs>();
      return _i2.ProgrammesPage(key: args.key, channel: args.channel);
    },
  );
}

class ProgrammesRouteArgs {
  const ProgrammesRouteArgs({this.key, required this.channel});

  final _i4.Key? key;

  final _i5.Channel channel;

  @override
  String toString() {
    return 'ProgrammesRouteArgs{key: $key, channel: $channel}';
  }
}
