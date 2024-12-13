import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe/application/user/user_bloc.dart';
import 'package:recipe/assets/colors/colors.dart';
import 'package:recipe/assets/icons.dart';
import 'package:recipe/data/dto/login.dart';
import 'package:recipe/presentation/routes/route_names.dart';
import 'package:recipe/presentation/widgets/custom_text_field.dart';
import 'package:recipe/utils/custom_toast_bar.dart';
import 'package:recipe/utils/formatters.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController controllerPhone;
  late TextEditingController controllerPassword;

  bool _showPassword = false;
  bool hasUpperCase = false;
  bool hasLowerCase = false;
  bool hasMinLength = false;
  bool hasCorrectText = false;

  @override
  void initState() {
    controllerPhone = TextEditingController();
    controllerPassword = TextEditingController();
    super.initState();
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
    if (controllerPassword.text.isEmpty || controllerPhone.text.isEmpty) {
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
      backgroundColor: white,
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          // BLoC holatiga qarab turli reaktsiyalarni ko'rsatish
          if (state.statusUser == FormzSubmissionStatus.success) {
            // Login muvaffaqiyatli bo'lsa
            showCustomToast(
              context: context,
              message: "Welcome back!",
              time: 4,
              color: green,
            );
            context.go(AppRouteName.home);

            // Navigator.push(
            //    context,
            //   MaterialPageRoute(
            //     builder: (context) => const HomeView(),
            //   ),
            // );
          } else if (state.statusUser == FormzSubmissionStatus.failure) {
            // Telefon raqam mavjud emas
            showCustomToast(
                context: context, message: "Telefon raqami noto'g'ri");
          } else if (state.statusUser == FormzSubmissionStatus.canceled) {
            // Parol mos kelmasa
            showCustomToast(context: context, message: "Noto'g'ri parol");
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 240,
                  decoration: const BoxDecoration(
                    color: redOrange,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.elliptical(80, 80),
                    ),
                  ),
                  child: Center(
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppIcons.recipe.svg(
                            height: 120,
                            width: 120,
                            color: white,
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            "Tizimga kirish",
                            style: TextStyle(
                              fontSize: 28,
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
                        topLeft: Radius.elliptical(80, 80),
                        topRight: Radius.elliptical(10, 10),
                        bottomLeft: Radius.elliptical(10, 10),
                        bottomRight: Radius.elliptical(80, 80),
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(width: 8),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 42, bottom: 8),
                          child: CustomTextField(
                            controller: controllerPhone,
                            hintText: "+998 (**) *** ** **",
                            borderRadius: 20,
                            borderColor: white,
                            keyboardType: TextInputType.phone,
                            formatter: [Formatters.phoneFormatter],
                            enableBorderColor: white,
                            fillColor: white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 42, top: 8),
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
                          message:
                              "Kamida 8 ta belgidan iborat bo'lishi kerak!");
                    } else if (i == -6) {
                      showCustomToast(
                          context: context,
                          message:
                              "Iltimos, to'g'ri telefon raqamini kiriting!");
                    } else if (i == -7) {
                      showCustomToast(
                          context: context,
                          message: "Parolda bo'sh joy bo'lmasligi kerak!");
                    }
                    if (i == 0) {
                      final login = Login(
                        phone: controllerPhone.text,
                        password: controllerPassword.text,
                      );
                      context.read<UserBloc>().add(
                            CheckLoginEvent(
                              login: login,
                            ),
                          );
                    }
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
                        "Kirish",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "Sizda account yo'qmi? ",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: black,
                          ),
                        ),
                        TextSpan(
                          text: "Ro'yxatdan o'tish",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: redOrange,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.go(AppRouteName.register);
                            },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
