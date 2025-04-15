import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hiveee/bloc/auth/auth_bloc.dart';
import 'package:hiveee/bloc/user/user_bloc.dart';
import 'package:hiveee/repositories/user_repository.dart';
import 'package:hiveee/screens/login_screen.dart';
import 'package:hiveee/screens/seller/seller_screen.dart';
import 'package:hiveee/screens/signup_screen.dart';
import 'package:hiveee/screens/update_user_data.dart';
import 'package:hiveee/screens/user_list_screen.dart';
import 'package:hiveee/screens/user_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create:
                    (context) => AuthBloc(
                      userRepository: context.read<UserRepository>(),
                    ),
                child: const LoginScreen(),
              ),
        );
      case '/signup':
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create:
                    (context) => AuthBloc(
                      userRepository: context.read<UserRepository>(),
                    ),
                child: const SignUpScreen(),
              ),
        );
      case '/list':
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create:
                    (context) => UserBloc(
                      userRepository: context.read<UserRepository>(),
                    ),
                child: const UserListScreen(),
              ),
        );
      case '/updateUser':
        // Expecting the Page that passing userId
        final userId = settings.arguments as int;
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create:
                    (context) => UserBloc(
                      userRepository: context.read<UserRepository>(),
                    ),
                child: UpdateUserData(userId: userId),
              ),
        );
      case '/userPage':
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create:
                        (context) => UserBloc(
                          userRepository: context.read<UserRepository>(),
                        ),
                  ),
                  BlocProvider(
                    create:
                        (context) => AuthBloc(
                          userRepository: context.read<UserRepository>(),
                        ),
                  ),
                ],
                child: const UserScreen(),
              ),
        );
      case '/sellerPage':
        return MaterialPageRoute(builder: (context) => SellerScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text('No Route'), centerTitle: true),
          body: const Center(
            child: Text(
              'Sorry route not found',
              style: TextStyle(color: Colors.red, fontSize: 18.0),
            ),
          ),
        );
      },
    );
  }
}
