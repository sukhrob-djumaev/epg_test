import 'package:epg_test/features/epg/models/channel.dart';
import 'package:epg_test/features/epg/models/channel_cache.dart';
import 'package:epg_test/features/epg/models/programme.dart';
import 'package:epg_test/features/epg/models/programme_cache.dart';
import 'package:hive_ce/hive.dart';

@GenerateAdapters([
  AdapterSpec<ChannelCache>(),
  AdapterSpec<Channel>(),
  AdapterSpec<Programme>(),
  AdapterSpec<ProgrammeCache>(),
])
part 'hive_adapters.g.dart';
