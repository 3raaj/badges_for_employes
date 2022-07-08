import 'package:badges_for_employes/data/repo/client_repository.dart';
import 'package:badges_for_employes/model/badge.dart';
import 'package:badges_for_employes/model/employee.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

import '../../../model/user.dart';

part 'client_event.dart';
part 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  final IUserRepository iUserRepository;
  ClientBloc(this.iUserRepository) : super(ClientInitial()) {
    on<ClientEvent>((event, emit) async {
      if (event is ClientPageStarted) {
        emit(LoadingClientInformation());
        final List<Employee> employesList =
            await iUserRepository.getEmployes(user: event.user);
        emit(ShowEmployesToUser(employes: employesList));
      } else if (event is AwardBadgeClicked) {
        emit(LoadingClientInformation());
        await iUserRepository.awardBadge(
            user: event.user, employee: event.employee, badge: event.badge);
        emit(BadgeSuccessfulAwarded(
            badge: event.badge, employee: event.employee));
           final List<Employee> employesListAfterUpdate =
            await iUserRepository.getEmployes(user: event.user);
        emit(ShowEmployesToUser(employes: employesListAfterUpdate));
      }
    });
  }
}
