import 'package:badges_for_employes/model/badge.dart';
import 'package:badges_for_employes/model/employee.dart';
import 'package:badges_for_employes/model/roles/userRole.dart';
import 'package:badges_for_employes/model/user.dart';

import '../../model/gender.dart';

class ExampleData {
  final List<User> usersList;
  final List<Employee> employeeList;

  ExampleData({required this.usersList, required this.employeeList});
}

final ExampleData exampleData = ExampleData(
  usersList: usersList,
  employeeList: [
    Employee(
     gender:  Gender.wooman,      
      id: 0,
      name: 'zahra',
      lastName: 'haashemi',
    ),
    Employee(
      gender:  Gender.man,
      id: 1,
      name: 'mohammad',
      lastName: 'soltani',
    ),
    Employee(
      gender:  Gender.wooman,
      id: 2,
      name: 'fateme',
      lastName: 'moradi',
    ),
    Employee(
      gender: Gender.wooman,
      id: 3,
      name: 'asraa',
      lastName: 'Jabbarian',
    ),
    Employee(
     gender: Gender.man,
      id: 4,
      name: 'AmirAli',
      lastName: 'Torabi',
    ),
    Employee(
     gender: Gender.wooman,
      id: 5,
      name: 'elhaam',
      lastName: 'Paayeste',
    ),
    Employee(
     gender: Gender.wooman,
      id: 6,
      name: 'Nazanin',
      lastName: 'Moraadi',
    ),
    Employee(
     gender: Gender.man,
      id: 7,
      name: 'Haadi',
      lastName: 'Babaian',
    ),
      Employee(
     gender: Gender.wooman,
      id: 8,
      name: 'Asma',
      lastName: 'kheiri',
    ),
      Employee(
     gender: Gender.man,
      id: 9,
      name: 'Ebrahim',
      lastName: 'Khodadadi',
    ),
     Employee(
     gender: Gender.wooman,
      id: 10,
      name: 'Atena',
      lastName: 'Moradi',
    ),
  ],
);
final List<User> usersList = [
  //client users test
  User(
      userRole: UserRole.client,
      id: 0,
      userName: 'ali',
      name: 'sadegh',
      lastName: 'mohammadi',
      password: '123456'),
  User(
      userRole: UserRole.client,
      id: 1,
      userName: 'pia',
      name: 'sohrab',
      lastName: 'mohebbi',
      password: '123456'),
  User(
      userRole: UserRole.client,
      id: 2,
      userName: 'dfdd',
      name: 'hamed',
      lastName: 'alipour',
      password: '123456'),
  User(
      userRole: UserRole.client,
      id: 3,
      userName: 'testUserName',
      name: 'zahra',
      lastName: 'sharafi',
      password: '123456'),
  //admin user test
  User(
      userRole: UserRole.admin,
      id: 4,
      userName: 'admin',
      name: 'test AdminName',
      lastName: 'Text Admin LastName',
      password: '1234567'),
];
