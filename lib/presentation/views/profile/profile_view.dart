import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe/application/user/user_bloc.dart';
import 'package:recipe/assets/colors/colors.dart';
import 'package:recipe/presentation/routes/route_names.dart';
import 'package:recipe/presentation/views/profile/profile_edit.dart';
import 'package:recipe/utils/my_function.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool _showPassword = false;

  @override
  void initState() {
    context.read<UserBloc>().add(GetUserById());
    super.initState();
  }

  TextStyle styleText = const TextStyle(
    fontSize: 20,
    color: black,
  );

  final BoxDecoration myBoxDecoration = const BoxDecoration(
    color: white,
    borderRadius: BorderRadius.only(
      topLeft: Radius.elliptical(6, 6),
      topRight: Radius.elliptical(40, 40),
      bottomLeft: Radius.elliptical(40, 40),
      bottomRight: Radius.elliptical(6, 6),
    ),
  );

  void showLogOut() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tizimdan chiqish'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Retseptlar dasturidan chiqishni xohlaysizmi?',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // log out
                context.read<UserBloc>().add(LogOutUserEvent());
                Navigator.pop(context);
                context.go(AppRouteName.login);
              },
              child: const Text(
                'Tizimdan chiqish',
                style: TextStyle(color: red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Bekor qilish'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: redOrange,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: const Icon(
                Icons.logout_rounded,
                size: 26,
                color: white,
              ),
              onPressed: () {
                // Harakatni amalga oshiring
                showLogOut();
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state.statusUser.isInProgress) {
              return const CupertinoActivityIndicator(
                radius: 15.0,
                color: redOrange,
              );
            } else if (state.users.isEmpty) {
              return const Center(
                child: Text(
                  "Foydalanuvchi topilmadi",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
              );
            }
            return Column(
              children: [
                Container(
                  height: 100,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.elliptical(120, 120),
                    ),
                    color: redOrange,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      state.users.first.name!,
                      style: const TextStyle(
                        fontSize: 28,
                        color: white,
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.fade,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
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
                      children: [
                        const SizedBox(width: 8),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 42, bottom: 8),
                          child: Container(
                            height: 50,
                            decoration: myBoxDecoration,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 14.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.person_pin_outlined),
                                  const SizedBox(width: 8),
                                  Text(
                                    state.users.first.name!,
                                    style: styleText,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 8, bottom: 8),
                          child: Container(
                            height: 50,
                            decoration: myBoxDecoration,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 14.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.phone_android_outlined),
                                  const SizedBox(width: 8),
                                  Text(
                                    state.users.first.phone!,
                                    style: styleText,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 8, top: 8),
                          child: Container(
                            height: 50,
                            decoration: myBoxDecoration,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 14.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.date_range_outlined),
                                  const SizedBox(width: 8),
                                  Text(
                                    MyFunction.dateFormat2(
                                        state.users.first.createdAt!),
                                    style: styleText,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 42, top: 8),
                          child: Container(
                            height: 50,
                            decoration: myBoxDecoration,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 14.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.security_rounded),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      _showPassword
                                          ? state.users.first.salt!
                                              .substring(16)
                                          : "**********",
                                      style: styleText,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  IconButton(
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
                                ],
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProfileEdit(users: state.users.first),
                      ),
                    );
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
                        "Profilni tahrirlash",
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
            );
          },
        ),
      ),
    );
  }
}
