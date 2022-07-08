// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BadgeAdapter extends TypeAdapter<Badge> {
  @override
  final int typeId = 6;

  @override
  Badge read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Badge.batman;
      case 1:
        return Badge.batgirl;
      case 2:
        return Badge.spiderMan;
      case 3:
        return Badge.spiderGirl;
      case 4:
        return Badge.sherlock;
      case 5:
        return Badge.joker;
      case 6:
        return Badge.ironman;
      case 7:
        return Badge.irongirl;
      default:
        return Badge.batman;
    }
  }

  @override
  void write(BinaryWriter writer, Badge obj) {
    switch (obj) {
      case Badge.batman:
        writer.writeByte(0);
        break;
      case Badge.batgirl:
        writer.writeByte(1);
        break;
      case Badge.spiderMan:
        writer.writeByte(2);
        break;
      case Badge.spiderGirl:
        writer.writeByte(3);
        break;
      case Badge.sherlock:
        writer.writeByte(4);
        break;
      case Badge.joker:
        writer.writeByte(5);
        break;
      case Badge.ironman:
        writer.writeByte(6);
        break;
      case Badge.irongirl:
        writer.writeByte(7);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BadgeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
