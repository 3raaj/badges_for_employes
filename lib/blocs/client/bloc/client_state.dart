part of 'client_bloc.dart';

abstract class ClientState extends Equatable {
  const ClientState();
  
  @override
  List<Object> get props => [];
}

class ClientInitial extends ClientState {}
class LoadingClientInformation extends ClientState{}
class ShowEmployesToUser extends ClientState{ 
  final List<Employee>? employes ;

  const ShowEmployesToUser({this.employes}); 
}
class BadgeSuccessfulAwarded extends ClientState{
  final Employee employee; 
  final Badge badge;

  const BadgeSuccessfulAwarded({required this.employee,required this.badge}); 
}