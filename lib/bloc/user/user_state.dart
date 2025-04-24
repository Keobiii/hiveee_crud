import 'package:equatable/equatable.dart';
import 'package:hiveee/models/user.dart';

abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateInitial extends UserState {}

class UpdateLoading extends UserState {}

class UsersLoaded extends UserState {
  final List<User> users;

  UsersLoaded(this.users);

  @override
  List<Object?> get props => [users];
}

class UpdateSuccess extends UserState {
  final User user;

  UpdateSuccess(this.user);

  // This props list tells Flutter: "If the user changes, then it's a new state"
  // If the user is the same as before, don't update the UI (avoid unnecessary rebuilds)
  @override
  List<Object?> get props => [user];
}

class UpdateFailure extends UserState {
  final String message;

  UpdateFailure(this.message);

  @override
  List<Object?> get props => [message];
}
