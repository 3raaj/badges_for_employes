import 'package:badges_for_employes/model/gender.dart';
import 'package:badges_for_employes/model/user.dart';
import 'package:hive_flutter/adapters.dart';

import 'badge.dart';
part 'employee.g.dart';

@HiveType(typeId: 1)
class Employee {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String lastName;
  @HiveField(3)
  final Map<User, Badge>? badgesAwarded;
  @HiveField(4)
  final Gender? gender;

  Employee(
      {required this.gender, 
      required this.id,
      required this.name,
      required this.lastName,
      this.badgesAwarded});
}

// Badge system:
// -Deadline : 8 July
// -state management:bloc. latest version
// -Using both firebase and local db(Hive) -- extra point
// -You should implement both user and admin panel in one app


// Badges:
// Batman/girl
// Spiderman/girl
// Sherlock
// Joker
//  Ironman/girl