// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'files.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CreatedFileAdapter extends TypeAdapter<CreatedFile> {
  @override
  final int typeId = 0;

  @override
  CreatedFile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CreatedFile()
      ..title = fields[0] as String?
      ..time = fields[1] as DateTime?
      ..method = fields[2] as String?
      ..paths = fields[3] as String?;
  }

  @override
  void write(BinaryWriter writer, CreatedFile obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.method)
      ..writeByte(3)
      ..write(obj.paths);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreatedFileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
