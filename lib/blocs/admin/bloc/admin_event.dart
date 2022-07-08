part of 'admin_bloc.dart';

abstract class AdminEvent extends Equatable {
  const AdminEvent();

  @override
  List<Object> get props => [];
}


class AdminPageStarted extends AdminEvent{
  final User user;
  

  const AdminPageStarted({required this.user,});  
}
