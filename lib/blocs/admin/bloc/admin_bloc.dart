
import 'package:badges_for_employes/data/repo/client_repository.dart';
import 'package:badges_for_employes/model/badge.dart';
import 'package:badges_for_employes/model/employee.dart';
import 'package:badges_for_employes/model/employesDataSourceModel.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../model/user.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final IUserRepository iUserRepository;
  AdminBloc({required this.iUserRepository}) : super(AdminInitial()) {
    on<AdminEvent>((event, emit) async {
      final Map<Badge, EbEntity> eachEmployeeWithAll = {};
      final List<GridColumn> gridColumn = getGridColumn();

      if (event is AdminPageStarted) {
        final List<Employee> finalEmployeeList = [];
        final List<Badge> badgeList=[]; 
        for (var element in Badge.values) { 
          badgeList.add(element); 
        } 
        await iUserRepository
            .getEmployes(user: event.user)
            .then((employeeList) {
          for (var element in employeeList) {
            finalEmployeeList.add(element);
          }
          for (var element in Badge.values) {
            for (var currentEmployee in employeeList) {
              if (currentEmployee.badgesAwarded != null) {
                final int count = getCountOfBadgesAwarded(currentEmployee)
                    .where((e) => e == element)
                    .length;
                eachEmployeeWithAll[element] =
                    EbEntity(badgeCount: count, employee: currentEmployee);
              }
            }
          }
        });
        
        final EmployeeDataSource employeeDataSource =
            EmployeeDataSource(employeeData: finalEmployeeList,badgeList: badgeList);
        
        for (var badge in Badge.values) {
          gridColumn.add(
            GridColumn(
              columnName: badge.name,
              label: Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: Text(badge.name),
              ),
            ),
          );
        }

        emit(ShowInFormationToAdmin(
          employes: finalEmployeeList,
            employeeDataSource: employeeDataSource,
            currentAdmin: event.user,
            
            gridColumn: gridColumn));
      }
    });
  }

  List<Badge> getCountOfBadgesAwarded(Employee currentEmployee) {
    return currentEmployee.badgesAwarded!.values
                  .toList();
  }

  List<GridColumn> getGridColumn() {
    final List<GridColumn> baseGridColumn = <GridColumn>[
      //some Base Details Added here such as id, name , etc.
      GridColumn(
          columnName: 'id',
          columnWidthMode: ColumnWidthMode.fitByColumnName,
          label: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: const Text(
                'ID',
              ))),
      GridColumn(
          columnName: 'name',
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text('Name'))),
      GridColumn(
          columnName: 'lastName',
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Last Name',
                overflow: TextOverflow.ellipsis,
              ))),
      GridColumn(
        columnName: 'gender',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text('Gender'),
        ),
      ),
      GridColumn(
        columnName: 'badgeCount',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text('All Badges'),
        ),
      ),
    ];
    return baseGridColumn;
  }
}
