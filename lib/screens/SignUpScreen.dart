import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hiveee/bloc/auth/auth_bloc.dart';
import 'package:hiveee/bloc/auth/auth_event.dart';
import 'package:hiveee/models/user.dart';
import 'package:hiveee/screens/LoginScreen.dart';
import 'package:hiveee/widget/gradient_button.dart';
import 'package:hiveee/widget/login_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Image.asset('assets/images/signin_balls.png'),
                const Text(
                  'Sign in.',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                ),
                const SizedBox(height: 50),
                // const SocialButton(
                //   iconPath: 'assets/svgs/g_logo.svg',
                //   label: 'Continue with Google',
                // ),
                // const SizedBox(height: 20),
                // const SocialButton(
                //   iconPath: 'assets/svgs/f_logo.svg',
                //   label: 'Continue with Facebook',
                //   horizontalPadding: 90,
                // ),
                const SizedBox(height: 15),
                const Text('or', style: TextStyle(fontSize: 17)),
                const SizedBox(height: 15),
                LoginField(
                  hintText: 'First Name',
                  controller: firstNameController,
                  icon: Icons.abc,
                  validator: (value) {
                    if (value == null || value.toString().isEmpty) {
                      return 'Please enter some text';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 15),
                LoginField(
                  hintText: 'Last Name',
                  controller: lastNameController,
                  icon: Icons.abc,
                  validator: (value) {
                    if (value == null || value.toString().isEmpty) {
                      return 'Please enter some text';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 15),
                LoginField(
                  hintText: 'Email',
                  controller: emailController,
                  icon: Icons.email_outlined,
                  validator: (value) {
                    if (value == null || value.toString().isEmpty) {
                      return 'Please enter some text';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 15),
                LoginField(
                  hintText: 'Password',
                  controller: passwordController,
                  isPassword: true,
                  keyboardType: TextInputType.visiblePassword,
                  icon: Icons.lock_outline_rounded,
                  validator: (value) {
                    if (value == null || value.toString().isEmpty) {
                      return 'Please enter some text';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 20),
                GradientButton(
                  text: 'Sign Up',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final box = Hive.box<User>('users');

                      // Check if email already exists
                      final emailExists = box.values.any(
                        (u) =>
                            u.email.toLowerCase() ==
                            emailController.text.trim().toLowerCase(),
                      );

                      if (emailExists) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Email is already registered"),
                          ),
                        );
                        return;
                      }

                      final user = User(
                        id: box.isEmpty ? 1 : box.values.last.id + 1,
                        userRole: 2,
                        email: emailController.text.trim(),
                        firstName: firstNameController.text.trim(),
                        lastName: lastNameController.text.trim(),
                        password: passwordController.text.trim(),
                        createdAt: DateTime.now(),
                      );

                      
                      context.read<AuthBloc>().add(RegisterUser(user));
                    }
                  },
                ),
                const SizedBox(height: 20),
                GradientButton(
                  text: 'Back',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
