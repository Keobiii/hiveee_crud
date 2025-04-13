import 'package:equatable/equatable.dart';
import 'package:hiveee/models/user.dart';

// State - this reprsents the state of the application
// it tells the UI what should it display
// like, initialization, loading, success, or failed.

// Equatable - is dart package where makes object compare by its value
// in default, when comparing object to object its comparing the reference address not the value

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}



class AuthSuccess extends AuthState {
  final User user;

  AuthSuccess(this.user);
  
  // This props list tells Flutter: "If the user changes, then it's a new state"
  // If the user is the same as before, don't update the UI (avoid unnecessary rebuilds)
  @override
  List<Object?> get props => [user];
}


class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}
