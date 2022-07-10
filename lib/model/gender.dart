import 'package:hive_flutter/adapters.dart';
part 'gender.g.dart';
@HiveType(typeId: 7)
enum Gender  {
  @HiveField(0)
  man,
  @HiveField(1)
  wooman,
  @HiveField(2)
  notDefined
}
