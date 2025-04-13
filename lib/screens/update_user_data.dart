import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hiveee/bloc/user/user.event.dart';
import 'package:hiveee/bloc/user/user_bloc.dart';
import 'package:hiveee/models/user.dart';
import 'package:hiveee/widget/gradient_button.dart';
import 'package:hiveee/widget/login_field.dart';

class UpdateUserData extends StatefulWidget {
  final int userId;
  const UpdateUserData({super.key, required this.userId});

  @override
  State<UpdateUserData> createState() => _UpdateUserDataState();
}

class _UpdateUserDataState extends State<UpdateUserData> {
  User? currentUser;

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    final box = await Hive.openBox<User>('users');
    final user = box.get(widget.userId);

    setState(() {
      currentUser = user;

      // assign new values
      _editEmailController.text = user?.email ?? '';
      _editFirstNameController.text = user?.firstName ?? '';
      _editLastNameController.text = user?.lastName ?? '';
    });
  }

  final _formKey = GlobalKey<FormState>();
  final _editFirstNameController = TextEditingController();
  final _editLastNameController = TextEditingController();
  final _editEmailController = TextEditingController();
  // final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          currentUser == null
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                child: Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Text(
                          'Update User.',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                          ),
                        ),
                        const SizedBox(height: 50),
                        LoginField(
                          hintText: 'Email',
                          controller: _editEmailController,
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
                          hintText: 'First Name',
                          controller: _editFirstNameController,
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
                          controller: _editLastNameController,
                          icon: Icons.abc,
                          validator: (value) {
                            if (value == null || value.toString().isEmpty) {
                              return 'Please enter some text';
                            }

                            return null;
                          },
                        ),
                        // const SizedBox(height: 15),
                        // LoginField(
                        //   hintText: 'Password',
                        //   controller: passwordController,
                        //   isPassword: true,
                        //   keyboardType: TextInputType.visiblePassword,
                        //   icon: Icons.lock_outline_rounded,
                        //   validator: (value) {
                        //     if (value == null || value.toString().isEmpty) {
                        //       return 'Please enter some text';
                        //     }

                        //     return null;
                        //   },
                        // ),
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
                                        _editEmailController.text
                                            .trim()
                                            .toLowerCase() &&
                                    u.id != currentUser!.id,
                              );

                              if (emailExists) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Email is already registered",
                                    ),
                                  ),
                                );
                                return;
                              }

                              final user = User(
                                id: currentUser!.id,
                                userRole: 2,
                                email: _editEmailController.text.trim(),
                                firstName: _editFirstNameController.text.trim(),
                                lastName: _editLastNameController.text.trim(),
                                password: currentUser!.password,
                                createdAt: DateTime.now(),
                              );

                              box.put(currentUser!.id, user);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('User updated successfully'),
                                ),
                              );

                              context.read<UserBloc>().add(UpdateUser(user));

                              // context.read<AuthBloc>().add(RegisterUser(user));
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        GradientButton(
                          text: 'Back',
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => LoginScreen()),
                            // );

                            Navigator.of(context).pop();
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
