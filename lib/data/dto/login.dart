class Login {
  final String phone;
  final String password;
  int id;
  bool success;

  Login({
    this.id = -1,
    this.success = false,
    this.phone = '',
    this.password = '',
  });
}
