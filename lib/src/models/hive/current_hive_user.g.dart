// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_hive_user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrentHiveUserAdapter extends TypeAdapter<CurrentHiveUser> {
  @override
  final int typeId = 1;

  @override
  CurrentHiveUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrentHiveUser(
      email: fields[0] as String,
      token: fields[1] as String,
      userId: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CurrentHiveUser obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.token)
      ..writeByte(2)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrentHiveUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
