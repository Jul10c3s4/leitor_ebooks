// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorito.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoritoAdapter extends TypeAdapter<Favorito> {
  @override
  final int typeId = 1;

  @override
  Favorito read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Favorito()..id = fields[0] as String;
  }

  @override
  void write(BinaryWriter writer, Favorito obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoritoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
