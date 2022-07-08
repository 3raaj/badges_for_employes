part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginStarted extends LoginEvent {}

class SetRoleToAmdinClicked extends LoginEvent {}

class SetRoleToClientClicked extends LoginEvent {}

class AuthButtonClicked extends LoginEvent {
  final String userName;
  final String password;

  const AuthButtonClicked({required this.userName, required this.password});
 
}
