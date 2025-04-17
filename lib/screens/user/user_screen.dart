import 'package:flutter/material.dart';
import 'package:hiveee/widget/gradient_button.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              GradientButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/userOrderList');
                },
                text: 'Orders',
              ),
              SizedBox(height: 20),
              GradientButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/orderPage');
                },
                text: 'List of Product',
              ),
              SizedBox(height: 20),
              GradientButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                },
                text: 'Logout',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
