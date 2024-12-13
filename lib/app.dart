import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:recipe/application/category/category_bloc.dart';
import 'package:recipe/application/product/product_bloc.dart';
import 'package:recipe/application/user/user_bloc.dart';
import 'package:recipe/assets/colors/colors.dart';
import 'package:recipe/presentation/routes/app_routes.dart';
import 'package:recipe/presentation/routes/route_names.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductBloc(),
        ),
        BlocProvider(
          create: (context) => CategoryBloc(),
        ),
        BlocProvider(
          create: (context) => UserBloc()
            ..add(
              GetUserById(),
            ),
        ),
      ],
      child: MaterialApp.router(
        restorationScopeId: 'app',
        debugShowCheckedModeBanner: false,
        routerConfig: AppRoutes.router,
        theme:
            ThemeData(appBarTheme: const AppBarTheme(surfaceTintColor: white)),
        builder: (context, child) {
          return BlocListener<UserBloc, UserState>(
            listener: (context, state) {
              switch (state.statusAuth) {
                case AuthenticationStatus.authenticated:
                  AppRoutes.router.pushReplacement(AppRouteName.home);
                  break;
                case AuthenticationStatus.unauthenticated:
                  AppRoutes.router.pushReplacement(AppRouteName.login);
                case AuthenticationStatus.loading:
                case AuthenticationStatus.cancelLoading:
                  break;
              }
            },
            child: KeyboardDismisser(child: child),
          );
        },
      ),
    );
  }
}
