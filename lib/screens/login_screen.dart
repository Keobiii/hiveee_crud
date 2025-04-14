import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hiveee/bloc/auth/auth_bloc.dart';
import 'package:hiveee/bloc/auth/auth_event.dart';
import 'package:hiveee/bloc/auth/auth_state.dart';
import 'package:hiveee/widget/gradient_button.dart';
import 'package:hiveee/widget/login_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is AuthSuccess) {
          print("User Roleee: ${state.user.userRole}");

          switch (state.user.userRole) {
            case 1:
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil('/list', (route) => false);
              break;
            case 2:
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil('/userPage', (route) => false);
              break;
            default:
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil('/unknown', (route) => false);
              break;
          }
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Image.asset('assets/images/signin_balls.png'),
                    const Text(
                      'Sign in.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                      ),
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
                      keyboardType: TextInputType.visiblePassword,
                      isPassword: true,
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
                      text: 'Login',
                      onPressed: () {
                        // if (_formKey.currentState!.validate()) {
                        //   Navigator.pushNamed(context, '/list');
                        // }

                        context.read<AuthBloc>().add(
                          LoginUser(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          ),
                        );

                        // Navigator.pushNamed(context, '/userPage');
                      },
                    ),
                    const SizedBox(height: 20),
                    GradientButton(
                      text: 'Register',
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
