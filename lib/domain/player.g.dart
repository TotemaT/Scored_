// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayerAdapter extends TypeAdapter<Player> {
  @override
  final int typeId = 1;

  @override
  Player read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Player(
      fields[3] as int,
      fields[0] as Color,
    )
      ..name = fields[1] as String
      ..score = fields[2] as int;
  }

  @override
  void write(BinaryWriter writer, Player obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.color)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.score)
      ..writeByte(3)
      ..write(obj.index);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
