import 'package:badges_for_employes/model/badge.dart';
import 'package:badges_for_employes/model/employee.dart';
import 'package:badges_for_employes/model/user.dart';
import 'package:hive_flutter/adapters.dart';

class HiveEmployesDataSource {
  final Box<Employee> hiveEmployeeBox;

  HiveEmployesDataSource(this.hiveEmployeeBox);
  Future<Employee> deleteOrUpdateBadge(
      {required Employee employee,
      required Badge badge,
      required User user}) async {
    if (badgesAwarded(employee) != null &&
        badgesAwarded(employee)!.containsKey(user)) {
      badgesAwarded(employee)!.update(user, (value) {
        {
          return badge;
        }
      });
      employee.save();
      return employee;
    } else if (badgesAwarded(employee) != null &&
        !badgesAwarded(employee)!.containsKey(user)) {
      badgesAwarded(employee)![user] = badge;
      employee.save();
      return employee;
    } else {
      // employee.badgesAwarded!.addAll(<User, Badge>{user: badge});
      final Employee newEmployeeWithBadgeAwardedNotNull = Employee(
          gender: employee.gender,
          id: employee.id,
          lastName: employee.lastName,
          name: employee.name,
          badgesAwarded: <User, Badge>{user: badge});
      employee.delete();
      hiveEmployeeBox.add(newEmployeeWithBadgeAwardedNotNull);
      newEmployeeWithBadgeAwardedNotNull.save();

      return newEmployeeWithBadgeAwardedNotNull;
    }
  }

  Map<User, Badge>? badgesAwarded(Employee employee) => hiveEmployeeBox.values
      .firstWhere((element) => element.id == employee.id)
      .badgesAwarded;
}
