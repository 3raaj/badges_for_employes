import 'package:badges_for_employes/model/badge.dart';
import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'employee.dart';

/// An object to set the employee collection data source to the datagrid. This
/// is used to map the employee data to the datagrid widget.
class EmployeeDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  EmployeeDataSource(
      {required List<Employee> employeeData, required List<Badge> badgeList}) {
    _employeeData = employeeData.map<DataGridRow>((e) {
      final List<DataGridCell> datagrid = [];
      for (var badge in badgeList) {
        datagrid.add(DataGridCell<int>(
            columnName: badge.name,
            value: e.badgesAwarded?.values
                    .where((element) => element == badge)
                    .length ??
                0));
      }
      final DataGridRow dataGridRow = DataGridRow(cells: [
        DataGridCell<int>(columnName: 'id', value: e.id),
        DataGridCell<String>(columnName: 'name', value: e.name),
        DataGridCell<String>(columnName: 'lastName', value: e.lastName),
        DataGridCell<String>(
            columnName: 'gender', value: e.gender?.name ?? 'unknown'),
        DataGridCell<int>(
            columnName: 'badgeCount',
            value: e.badgesAwarded?.values.length ?? 0),
      ]);
      datagrid.forEach((element) {dataGridRow.getCells().add(element);}); 
      return dataGridRow;
    }).toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}
