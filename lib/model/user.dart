import 'package:badges_for_employes/model/roles/userRole.dart';
import 'package:hive_flutter/adapters.dart';
part 'user.g.dart';
@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  final UserRole userRole;
  @HiveField(1)
  final int id;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String userName;
  @HiveField(4)
  final String lastName;
  @HiveField(5)
  final String password;

  User({
    required this.userRole,
    required this.id,
    required this.userName,
    required this.name,
    required this.lastName,
    required this.password,
  });
}
