import 'dart:convert';

import 'package:crypto/crypto.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:recipe/application/user/user_bloc.dart';
import 'package:recipe/assets/colors/colors.dart';
import 'package:recipe/data/model/user_model.dart';
import 'package:recipe/presentation/widgets/custom_text_field.dart';
import 'package:recipe/utils/custom_toast_bar.dart';
import 'package:recipe/utils/formatters.dart';
import 'package:recipe/utils/generate_random.dart';

class ProfileEdit extends StatefulWidget {
  final Users users;
  const ProfileEdit({super.key, required this.users});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  late TextEditingController controllerName;
  late TextEditingController controllerPassword;
  late TextEditingController controllerPhone;

  bool _showPassword = false;
  bool hasUpperCase = false;
  bool hasLowerCase = false;
  bool hasMinLength = false;
  bool hasCorrectText = false;

  @override
  void initState() {
    controllerName = TextEditingController(text: widget.users.name);
    controllerPassword =
        TextEditingController(text: widget.users.salt!.substring(16));
    controllerPhone = TextEditingController(text: widget.users.phone);
    super.initState();
  }

  @override
  void dispose() {
    controllerName.dispose();
    controllerPassword.dispose();
    controllerPhone.dispose();
    super.dispose();
  }

  void validatePassword(String value) {
    setState(() {
      hasUpperCase = value.contains(RegExp(r'[A-Z]'));
      hasLowerCase = value.contains(RegExp(r'[a-z]'));
      hasMinLength = value.length >= 8;
      hasCorrectText = value.contains(' ') == true ? false : true;
    });
  }

  int _submitForm() {
    if (controllerPassword.text.isEmpty ||
        controllerPhone.text.isEmpty ||
        controllerName.text.isEmpty) {
      return -1; // -1 Ba'zi maydonlar bo'sh
    } else if (controllerPassword.text.isNotEmpty &&
        controllerPhone.text.isNotEmpty) {
      if (!hasUpperCase && !hasLowerCase && !hasMinLength) {
        return -2; // -2 - Password talablari bajarilmagan
      } else if (!hasUpperCase) {
        return -3; // -3 - hasUpperCase
      } else if (!hasLowerCase) {
        return -4; // -4 - hasLowerCase
      } else if (!hasMinLength) {
        return -5; // -5 - minLength
      } else if (!hasCorrectText) {
        return -7;
      }
      if (controllerPhone.text.length != 19) {
        return -6; // -6 telefon raqamni to'g'riligini tekshirish
      }
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: redOrange,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: white,
            size: 28,
          ),
        ),
      ),
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state.statusUser == FormzSubmissionStatus.success) {
            showCustomToast(
              context: context,
              message: "Barcha o'zgarishlar saqlandi!",
              time: 4,
              color: green,
            );
          } else if (state.statusUser == FormzSubmissionStatus.failure) {
            showCustomToast(
                context: context,
                message:
                    "Qo‘shishda xatolik yuz berdi, keyinroq qayta urinib ko‘ring!");
          } else if (state.statusUser == FormzSubmissionStatus.canceled) {
            showCustomToast(
                context: context, message: "Bu raqam allaqachon mavjud!");
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 100,
                decoration: const BoxDecoration(
                  color: redOrange,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(120, 120),
                  ),
                ),
                child: const Center(
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Profilni tahrirlash",
                          style: TextStyle(
                            fontSize: 30,
                            color: white,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: redOrange,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.elliptical(10, 10),
                      topRight: Radius.elliptical(80, 80),
                      bottomLeft: Radius.elliptical(80, 80),
                      bottomRight: Radius.elliptical(10, 10),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: 8),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 42, bottom: 8),
                        child: CustomTextField(
                          controller: controllerName,
                          hintText: "Ismingizni kiriting",
                          borderRadius: 20,
                          borderColor: white,
                          enableBorderColor: white,
                          fillColor: white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 8, top: 8),
                        child: CustomTextField(
                          controller: controllerPhone,
                          keyboardType: TextInputType.phone,
                          formatter: [Formatters.phoneFormatter],
                          hintText: "+998 (**) *** ** **",
                          borderRadius: 20,
                          borderColor: white,
                          enableBorderColor: white,
                          fillColor: white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 40, top: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextField(
                            obscureText: !_showPassword,
                            controller: controllerPassword,
                            onChanged: validatePassword,
                            decoration: InputDecoration(
                              fillColor: white,
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(12),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _showPassword = !_showPassword;
                                  });
                                },
                                icon: Icon(
                                  Icons.remove_red_eye_outlined,
                                  color: _showPassword ? redOrange : grey,
                                ),
                              ),
                              hintText: "Parolingizni kiriting",
                              hintStyle: const TextStyle(
                                color: greyText,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      //   Padding(
                      //     padding: const EdgeInsets.only(
                      //         left: 32, right: 16, bottom: 8, top: 0),
                      //     child: TextButton(
                      //       onPressed: () {
                      //         setState(() {
                      //           controllerPassword.text = generatePassword();
                      //         });
                      //       },
                      //       child: const Text(
                      //         "Password generator",
                      //         style: TextStyle(
                      //           color: white,
                      //           fontSize: 16,
                      //           fontWeight: FontWeight.w500,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 6),
              GestureDetector(
                onTap: () {
                  int i = _submitForm();
                  if (i == -1) {
                    showCustomToast(
                        context: context,
                        message: "Barcha maydonlarni to'ldiring!");
                  } else if (i == -2) {
                    showCustomToast(
                        context: context,
                        message:
                            "Katta va kichik harflar va kamida 8 ta belgidan iborat bo'lishi kerak");
                  } else if (i == -3) {
                    showCustomToast(
                        context: context,
                        message: "Parolga kamida 1ta katta harf kirgazing!");
                  } else if (i == -4) {
                    showCustomToast(
                        context: context,
                        message: "Parolga kamida 1ta kichik harf kirgazing!");
                  } else if (i == -5) {
                    showCustomToast(
                        context: context,
                        message: "Kamida 8 ta belgidan iborat bo'lishi kerak!");
                  } else if (i == -6) {
                    showCustomToast(
                        context: context,
                        message: "Iltimos, to'g'ri telefon raqamini kiriting!");
                  } else if (i == -7) {
                    showCustomToast(
                        context: context,
                        message: "Parolda bo'sh joy bo'lmasligi kerak!");
                  }
                  if (i == 0) {
                    String salt = generateRandomPassword(16);
                    String saltedText = salt + controllerPassword.text + salt;

                    var bytes = utf8.encode(saltedText);
                    var hash = md5.convert(bytes);

                    final user = Users(
                      name: controllerName.text,
                      phone: controllerPhone.text,
                      password: hash.toString(),
                      salt: salt + controllerPassword.text,
                      id: widget.users.id,
                      // createdAt: widget.users.createdAt,
                    );
                    context.read<UserBloc>().add(
                          UpdateUserEvent(
                            users: user,
                            onSuccess: () {
                              Navigator.pop(context);
                            },
                          ),
                        );
                  }
                  // context.go(AppRouteName.home);
                },
                child: Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                    color: redOrange,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      "Saqlash",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
