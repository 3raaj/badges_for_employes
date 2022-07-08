part of 'client_bloc.dart';

abstract class ClientEvent extends Equatable {
  const ClientEvent();

  @override
  List<Object> get props => [];
}

class ClientPageStarted extends ClientEvent {
  final User user;

  const ClientPageStarted(this.user);
}

class AwardBadgeClicked extends ClientEvent {
  // ** Which user has awarded which badge to which employee **
  final User user;
  final Employee employee;
  final Badge badge;
  const AwardBadgeClicked(
      {required this.badge, required this.user, required this.employee});
}

