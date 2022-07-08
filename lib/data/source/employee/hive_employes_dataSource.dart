import 'package:badges_for_employes/model/badge.dart';
import 'package:badges_for_employes/model/employee.dart';
import 'package:badges_for_employes/model/user.dart';
import 'package:hive_flutter/adapters.dart';

class HiveEmployesDataSource {
  final Box<Employee> hiveEmployeeBox;

  HiveEmployesDataSource(this.hiveEmployeeBox);
  Future<void> deleteOrUpdateBadge(
      {required int employeeId,
      required Badge badge,
      required User user}) async {
    (hiveEmployeeBox.values.toList() as List<Employee>)
        .forEach((employee) async {
      if (employee.id == employeeId) {
        //It is possible that the badge is empty, so we will check
        if (employee.badgesAwarded != null) {
          //It may not be null, but only this user is not among the votes.

          if (employee.badgesAwarded!.containsKey(user)) {
            employee.badgesAwarded!.update(user, (value) {
              return value = badge;
            });
            await hiveEmployeeBox.put(employee.id,employee);
            print(employee.badgesAwarded);
          }
        } else {
          final Map<User, Badge> map = {};
          map[user] = badge;
          print(map);
          await hiveEmployeeBox.delete(employee.id);
          print(hiveEmployeeBox.values.toList());
          final Employee newemployee = Employee(
              gender: employee.gender,
              id: employee.id,
              name: employee.name,
              lastName: employee.lastName,
              badgesAwarded: map);
          await hiveEmployeeBox.add(newemployee);
        }
      }
    });
  }
}
