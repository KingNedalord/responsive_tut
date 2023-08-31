// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatsAdapter extends TypeAdapter<Chats> {
  @override
  final int typeId = 0;

  @override
  Chats read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Chats(
      ava_photo: fields[0] as String,
      nickName: fields[1] as String,
      message: (fields[2] as List).cast<String>(),
      isSelected: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Chats obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.ava_photo)
      ..writeByte(1)
      ..write(obj.nickName)
      ..writeByte(2)
      ..write(obj.message)
      ..writeByte(3)
      ..write(obj.isSelected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
