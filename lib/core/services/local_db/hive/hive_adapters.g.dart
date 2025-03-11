// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class ProgrammeCacheAdapter extends TypeAdapter<ProgrammeCache> {
  @override
  final int typeId = 2;

  @override
  ProgrammeCache read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProgrammeCache(
      channelId: fields[0] as String,
      lastUpdated: fields[1] as DateTime,
      programmes: (fields[2] as List).cast<Programme>(),
    );
  }

  @override
  void write(BinaryWriter writer, ProgrammeCache obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.channelId)
      ..writeByte(1)
      ..write(obj.lastUpdated)
      ..writeByte(2)
      ..write(obj.programmes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProgrammeCacheAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ChannelCacheAdapter extends TypeAdapter<ChannelCache> {
  @override
  final int typeId = 3;

  @override
  ChannelCache read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChannelCache(
      lastUpdated: fields[0] as DateTime,
      channels: (fields[1] as List).cast<Channel>(),
    );
  }

  @override
  void write(BinaryWriter writer, ChannelCache obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.lastUpdated)
      ..writeByte(1)
      ..write(obj.channels);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChannelCacheAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ChannelAdapter extends TypeAdapter<Channel> {
  @override
  final int typeId = 4;

  @override
  Channel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Channel(
      id: fields[0] as String,
      displayName: fields[1] as String,
      url: fields[2] as String,
      icon: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Channel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.displayName)
      ..writeByte(2)
      ..write(obj.url)
      ..writeByte(3)
      ..write(obj.icon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChannelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProgrammeAdapter extends TypeAdapter<Programme> {
  @override
  final int typeId = 5;

  @override
  Programme read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Programme(
      channelId: fields[0] as String,
      start: fields[1] as DateTime,
      end: fields[2] as DateTime,
      title: fields[3] as String,
      desc: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Programme obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.channelId)
      ..writeByte(1)
      ..write(obj.start)
      ..writeByte(2)
      ..write(obj.end)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.desc);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProgrammeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
