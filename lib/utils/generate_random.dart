import 'dart:math';

String generateRandomPassword(int length) {
  const chars =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!_@#%*.,';
  final random = Random();

  return List.generate(length, (index) => chars[random.nextInt(chars.length)])
      .join();
}

String generateRandomString(int length) {
  const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
  final random = Random();

  return List.generate(length, (index) => chars[random.nextInt(chars.length)])
      .join();
}

String generateRandomNumber(int length) {
  const chars = '0123456789';
  final random = Random();

  return List.generate(length, (index) => chars[random.nextInt(chars.length)])
      .join();
}

String generatePassword({int length = 12}) {
  length > 12 ? length = 12 : null;
  bool hasUpperCase = false;
  bool hasLowerCase = false;
  bool hasNumber = false;

  const chars =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final random = Random();
  String temp = '';

  while (!hasUpperCase || !hasLowerCase || !hasNumber) {
    temp = List.generate(length, (index) => chars[random.nextInt(chars.length)])
        .join();
    hasUpperCase = temp.contains(RegExp(r'[A-Z]'));
    hasLowerCase = temp.contains(RegExp(r'[a-z]'));
    hasNumber = temp.contains(RegExp(r'[0-9]'));
  }

  return temp;
}
