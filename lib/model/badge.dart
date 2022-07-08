import 'package:badges_for_employes/model/employee.dart';
import 'package:hive_flutter/adapters.dart';
part 'badge.g.dart';

@HiveType(typeId: 6)
enum Badge {
  @HiveField(0)
  batman,
  @HiveField(1)
  batgirl,
  @HiveField(2)
  spiderMan,
  @HiveField(3)
  spiderGirl,
  @HiveField(4)
  sherlock,
  @HiveField(5)
  joker,
  @HiveField(6)
  ironman,
  @HiveField(7)
  irongirl,
}

class EbEntity {
  final Employee? employee;
  final int? badgeCount;

  EbEntity({this.employee, this.badgeCount});
}
