import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ColorAdapter extends TypeAdapter<Color> {
  @override
  Color read(BinaryReader reader) => Color(reader.readInt());

  @override
  int get typeId => 200;

  @override
  void write(BinaryWriter writer, Color obj) => writer.writeInt(obj.value);
}
