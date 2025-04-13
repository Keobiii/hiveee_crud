import 'package:flutter/material.dart';
import 'package:hiveee/screens/LoginScreen.dart';
import 'package:hiveee/screens/SignUpScreen.dart';
import 'package:hiveee/screens/update_user_data.dart';
import 'package:hiveee/screens/user_list_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/signup':
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => const UserListScreen());
      case '/updateUser':
        // Expecting the Page that passing userId
        final userId = settings.arguments as int;
        return MaterialPageRoute(builder: (_) => UpdateUserData(userId: userId));
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
