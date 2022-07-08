import 'package:badges_for_employes/common/constants.dart';
import 'package:badges_for_employes/data/exampleUsers/Exampledata.dart';
import 'package:badges_for_employes/model/badge.dart';
import 'package:badges_for_employes/model/employee.dart';
import 'package:badges_for_employes/model/gender.dart';
import 'package:badges_for_employes/model/user.dart';
import 'package:badges_for_employes/ui/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'model/roles/userRole.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(EmployeeAdapter());
  Hive.registerAdapter(UserRoleAdapter());
  Hive.registerAdapter(BadgeAdapter()); 
  Hive.registerAdapter(GenderAdapter()); 
  final usersBox = await Hive.openBox<User>(usersBoxName);
  final employesBox = await Hive.openBox<Employee>(employesBoxName);
  // Test Some Data from ExampleUsers class
  // For Test Some Data we have a Example Data with test users and employes
 
  exampleData.employeeList.forEach((employee) async {
    if (employesBox.isEmpty || !employesBox.values.any((element) => element.id == employee.id)) {
      
      //add test data - >This is to avoid repeating the same process in subsequent executions
      await employesBox.add(employee);
    }
  });
  exampleData.usersList.forEach((element) async {
    if (usersBox.isEmpty || !usersBox.values.any((element) => element.id==element.id)) {
      await usersBox.add(element);
    }
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}
