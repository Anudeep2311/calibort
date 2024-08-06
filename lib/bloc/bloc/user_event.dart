part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchUsers extends UserEvent {
  final int page;

  FetchUsers(this.page);
}

class Logout extends UserEvent {}
