// ignore: depend_on_referenced_packages
import 'package:badges_for_employes/common/exception.dart';
import 'package:badges_for_employes/data/repo/client_repository.dart';
import 'package:badges_for_employes/model/employee.dart';
import 'package:badges_for_employes/model/user.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  bool isClientLoginMode;
  LoginBloc({required this.userRepository, this.isClientLoginMode = true})
      : super(LoginInitial(isClientLoginMode)) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginStarted) {
        emit(LoginLoading(isClientLoginMode));
        isClientLoginMode = true;
        emit(InformationSettingState(isClientLoginMode));
      } else if (event is SetRoleToAmdinClicked) {
        isClientLoginMode = false;
        emit(InformationSettingState(isClientLoginMode));
      } else if (event is SetRoleToClientClicked) {
        isClientLoginMode = true;
        emit(InformationSettingState(isClientLoginMode));
      } else if (event is AuthButtonClicked) {
        emit(LoginLoading(isClientLoginMode));
        try {
          final User? user = await userRepository.loginUser(
              isClientLoginMode: isClientLoginMode,
              userName: event.userName,
              password: event.password);
          if (user == null) {
            emit(LoginFailed(isClientLoginMode,
                loginExceptionMessage: 'userName or password is incorrect'));
          } else {
            emit(LoginSuccess(
              isClientLoginMode,
              user: user,
            ));
          }
        } catch (e) {
          throw Exception(AppException(message: 'loginFailed'));
        }
      } else if (event is MakeAnAccountBottonClicked) {
        emit(ShowSignUpPage(isClientLoginMode));
      } else if (event is RegisterAccountClicked) {
        if (hiveUserBox.isEmpty ||
            !hiveUserBox.values
                .any((element) => element.userName == event.user.userName)) {
          // I dont use ISINBOX
          await hiveUserBox.add(event.user);
          emit(SignUpSuccess(isClientLoginMode));
        } else {
          emit(ErrorCreateNewUser(isClientLoginMode));
        }
      }
    });
  }
}
