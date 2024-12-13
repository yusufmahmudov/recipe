part of 'user_bloc.dart';

class UserState extends Equatable {
  final AuthenticationStatus statusAuth;
  final FormzSubmissionStatus statusUser;
  final List<Users> users;
  final Login? login;
  final Register? register;
  final int selUser;

  const UserState({
    this.statusAuth = AuthenticationStatus.loading,
    this.statusUser = FormzSubmissionStatus.initial,
    this.users = const [],
    this.login,
    this.register,
    this.selUser = -1,
  });

  @override
  List<Object?> get props =>
      [statusAuth, statusUser, users, selUser, login, register];

  UserState copyWith({
    AuthenticationStatus? statusAuth,
    FormzSubmissionStatus? statusUser,
    List<Users>? users,
    Login? login,
    Register? register,
    int? selUser,
  }) {
    return UserState(
      statusAuth: statusAuth ?? this.statusAuth,
      statusUser: statusUser ?? this.statusUser,
      users: users ?? this.users,
      login: login ?? this.login,
      register: register ?? this.register,
      selUser: selUser ?? this.selUser,
    );
  }
}
