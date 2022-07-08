import 'package:badges_for_employes/common/constants.dart';
import 'package:badges_for_employes/data/source/employee/hive_employes_dataSource.dart';
import 'package:badges_for_employes/data/source/user/hive_user_dataSource.dart';
import 'package:badges_for_employes/data/source/user/user_data_source.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../model/badge.dart';
import '../../model/employee.dart';
import '../../model/user.dart';

final Box<User> hiveUserBox = Hive.box<User>(usersBoxName);
final Box<Employee> hiveEmployesBox = Hive.box<Employee>(employesBoxName);
final HiveEmployesDataSource hiveEmployesDataSource =
    HiveEmployesDataSource(hiveEmployesBox);
final HiveUserDataSource hiveUserDataSource = HiveUserDataSource(hiveUserBox);
final UserRepository userRepository = UserRepository(
    LocalUserDataSource(hiveUserDataSource, hiveEmployesDataSource));

abstract class IUserRepository {
  Future<User?> loginUser(
      {required String userName,
      required String password,
      required bool isClientLoginMode});
  Future<List<Employee>> getEmployes({required User user});
  Future<void> awardBadge(
      {required User user, required Employee employee, required Badge badge});
}

class UserRepository implements IUserRepository {
  final IUserDataSource _iUserDataSource;

  UserRepository(this._iUserDataSource);
  @override
  Future<List<Employee>> getEmployes({required User user}) async {
    final employesList = await _iUserDataSource.getEmployes(user: user);
    return employesList;
  }

  @override
  Future<User?> loginUser(
      {required String userName,
      required String password,
      required bool isClientLoginMode}) async {
    return await _iUserDataSource.loginUser(
      userName: userName,
      password: password,
      isClientLoginMode: isClientLoginMode,
    );
  }

  @override
  Future<void> awardBadge(
      {required User user,
      required Employee employee,
      required Badge badge}) async {
    return await _iUserDataSource.awardBadge(
        user: user, employee: employee, badge: badge);
  }
}
