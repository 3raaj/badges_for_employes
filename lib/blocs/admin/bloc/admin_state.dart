part of 'admin_bloc.dart';

abstract class AdminState extends Equatable {
  const AdminState();
  
  @override
  List<Object> get props => [];
}

class AdminInitial extends AdminState {}

class ShowInFormationToAdmin extends AdminState{
  final User currentAdmin;
  final List<Employee>? employes ; 
  final List<GridColumn> gridColumn; 
  final EmployeeDataSource employeeDataSource; 
  const ShowInFormationToAdmin( {this.employes,  required this.currentAdmin, required this.gridColumn,required this.employeeDataSource, }); 

}