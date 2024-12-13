class Register {
  final String name;
  final String phone;
  final String password;
  int id;
  bool success;

  Register({
    this.id = -1,
    this.success = false,
    this.name = '',
    this.phone = '',
    this.password = '',
  });
}
