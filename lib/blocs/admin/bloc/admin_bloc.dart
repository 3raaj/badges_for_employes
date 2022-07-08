import 'package:badges_for_employes/data/repo/client_repository.dart';
import 'package:badges_for_employes/model/badge.dart';
import 'package:badges_for_employes/model/employee.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../model/user.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final IUserRepository iUserRepository;
  AdminBloc({required this.iUserRepository}) : super(AdminInitial()) {
    on<AdminEvent>((event, emit) async {
      final Map<Badge, EbEntity> eachEmployeeWithAll = {};
      if (event is AdminPageStarted) {
        await iUserRepository
            .getEmployes(user: event.user)
            .then((employeeList) {
          Badge.values.forEach((element) {
            employeeList.forEach((currentEmployee) {
              final int? count = currentEmployee.badgesAwarded!.values
                  .toList()
                  .where((e) => e == element)
                  .length;
                  
              eachEmployeeWithAll[element] = EbEntity(
                  badgeCount: count, employee: currentEmployee);
            });
          });
        });
        emit(ShowInFormationToAdmin(
            currentAdmin: event.user, topEmployes: eachEmployeeWithAll));
      }
    });
  }
}
