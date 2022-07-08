part of 'admin_bloc.dart';

abstract class AdminState extends Equatable {
  const AdminState();
  
  @override
  List<Object> get props => [];
}

class AdminInitial extends AdminState {}

class ShowInFormationToAdmin extends AdminState{
  final  Map<Badge,EbEntity>? topEmployes; 
  final User currentAdmin;

  ShowInFormationToAdmin({ this.topEmployes,required this.currentAdmin}); 
}