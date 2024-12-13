part of 'user_bloc.dart';

sealed class UserEvent {}

class GetAllUsersEvent extends UserEvent {
  final int id;

  GetAllUsersEvent({required this.id});
}

class GetUserById extends UserEvent {}

class CreateUserEvent extends UserEvent {
  final UserModelG users;
  final VoidCallback onSuccess;

  CreateUserEvent({
    required this.users,
    required this.onSuccess,
  });
}

class UpdateUserEvent extends UserEvent {
  final Users users;
  final VoidCallback onSuccess;

  UpdateUserEvent({
    required this.users,
    required this.onSuccess,
  });
}

class SelUserEvent extends UserEvent {
  final int index;

  SelUserEvent({required this.index});
}

class LogOutUserEvent extends UserEvent {}

class CheckLoginEvent extends UserEvent {
  final Login login;

  CheckLoginEvent({
    required this.login,
  });
}

class CheckRegisterEvent extends UserEvent {
  final Register register;

  CheckRegisterEvent({
    required this.register,
  });
}
