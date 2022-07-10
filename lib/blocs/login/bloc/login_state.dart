part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  final bool isClientLoginMode;
  LoginState(this.isClientLoginMode);

  @override
  List<Object> get props => [isClientLoginMode];
}

class LoginInitial extends LoginState {
  LoginInitial(bool isClientLoginMode) : super(isClientLoginMode);
}

class LoginLoading extends LoginState {
  LoginLoading(bool isClientLoginMode) : super(isClientLoginMode);
}

class LoginSuccess extends LoginState {
  final User? user;
  final List<Employee>? employesList;
  LoginSuccess(bool isClientLoginMode, {required this.user, this.employesList})
      : super(isClientLoginMode);
}

class LoginFailed extends LoginState {
  final String loginExceptionMessage;
  LoginFailed(bool isClientLoginMode, {required this.loginExceptionMessage})
      : super(isClientLoginMode);
}

class InformationSettingState extends LoginState {
  InformationSettingState(bool isClientLoginMode) : super(isClientLoginMode);
}

class ShowSignUpPage extends LoginState{
  ShowSignUpPage(super.isClientLoginMode);

}
class ErrorCreateNewUser extends LoginState{
  ErrorCreateNewUser(super.isClientLoginMode);

}
class SignUpSuccess extends LoginState{
  SignUpSuccess(super.isClientLoginMode);
}

