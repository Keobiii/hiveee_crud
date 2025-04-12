import 'package:equatable/equatable.dart';
import 'package:hiveee/models/user.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterUser extends AuthEvent {
  final User user;

  RegisterUser(this.user);

  @override
  List<Object?> get props => [user];
}

class LoginUser extends AuthEvent {
  final String firstName;
  final String password;

  LoginUser({required this.firstName, required this.password});

  @override
  List<Object?> get props => [firstName, password];
}
