// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clipboard_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClipboardItemAdapter extends TypeAdapter<ClipboardItem> {
  @override
  final int typeId = 0;

  @override
  ClipboardItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClipboardItem(
      content: fields[0] as String,
      timestamp: fields[1] as DateTime,
      isFavorite: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ClipboardItem obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.content)
      ..writeByte(1)
      ..write(obj.timestamp)
      ..writeByte(2)
      ..write(obj.isFavorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClipboardItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
