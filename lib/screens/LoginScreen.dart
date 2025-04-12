import 'package:flutter/material.dart';
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
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushNamed(context, '/home');
                    }
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
    );
  }
}
