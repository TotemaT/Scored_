// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameStateAdapter extends TypeAdapter<GameState> {
  @override
  final int typeId = 1;

  @override
  GameState read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return GameState.SETUP;
      case 1:
        return GameState.RUNNING;
      case 2:
        return GameState.PAUSED;
      case 3:
        return GameState.SAVED;
      default:
        return GameState.SETUP;
    }
  }

  @override
  void write(BinaryWriter writer, GameState obj) {
    switch (obj) {
      case GameState.SETUP:
        writer.writeByte(0);
        break;
      case GameState.RUNNING:
        writer.writeByte(1);
        break;
      case GameState.PAUSED:
        writer.writeByte(2);
        break;
      case GameState.SAVED:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameStateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GameAdapter extends TypeAdapter<Game> {
  @override
  final int typeId = 0;

  @override
  Game read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Game()
      ..date = fields[0] as DateTime
      ..name = fields[1] as String
      ..players = (fields[2] as List).cast<Player>()
      ..state = fields[3] as GameState;
  }

  @override
  void write(BinaryWriter writer, Game obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.players)
      ..writeByte(3)
      ..write(obj.state);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
