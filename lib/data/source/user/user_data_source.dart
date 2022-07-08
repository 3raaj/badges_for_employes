import 'package:badges_for_employes/common/constants.dart';
import 'package:badges_for_employes/common/exception.dart';
import 'package:badges_for_employes/common/validateLogin.dart';
import 'package:badges_for_employes/data/source/employee/hive_employes_dataSource.dart';
import 'package:badges_for_employes/data/source/user/hive_user_dataSource.dart';
import 'package:badges_for_employes/model/badge.dart';
import 'package:badges_for_employes/model/employee.dart';
import 'package:badges_for_employes/model/roles/userRole.dart';
import 'package:badges_for_employes/model/user.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class IUserDataSource {
  //login user - both admin and client
  Future<User?> loginUser(
      {required String userName,
      required String password,
      required bool isClientLoginMode});
  Future<List<Employee>> getEmployes({required User user});
  Future<void> awardBadge(
      {required User user, required Employee employee, required Badge badge});
}

class LocalUserDataSource with ValidateLogin implements IUserDataSource {
  final HiveUserDataSource _hiveUserDataSource;
  final HiveEmployesDataSource _hiveEmployesDataSource;
  LocalUserDataSource(this._hiveUserDataSource, this._hiveEmployesDataSource);

  @override
  Future<User?> loginUser(
      {required String userName,
      required String password,
      required bool isClientLoginMode}) async {
    final List<User> clientsList = getDataByUserRole(userRole: UserRole.client);
    final List<User> adminsList =
        getDataByUserRole(userRole: UserRole.admin).toList();
    final User? user = validateLogin(
        userName: userName,
        dataBaseUserList: isClientLoginMode ? clientsList : adminsList,
        password: password);
  return user;
  }

  List<User> getDataByUserRole({required UserRole userRole}) {
    return _hiveUserDataSource.hiveUserBox.values
        .where((element) => element.userRole == userRole)
        .toList();
  }

  

@override
Future<void> awardBadge(
    {required User user,
    required Employee employee,
    required Badge badge}) async {
 await  HiveEmployesDataSource(Hive.box<Employee>(employesBoxName))
      .deleteOrUpdateBadge(employeeId: employee.id, badge: badge, user: user);
}

  @override
  Future<List<Employee>> getEmployes({required User user})async {
     // optional , I havent any online dataBase so I can Remove some details after send in to UserLayer such as employee all badges.
    final List<Employee> employesList =
      await   _hiveEmployesDataSource.hiveEmployeeBox.values.toList();
    // TODO: implement awardBadge
     return employesList;
  }
}