import 'package:equatable/equatable.dart';
import 'package:hiveee/models/user.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadUsers extends UserEvent {}

class UpdateUser extends UserEvent {
  final User updatedUser;

  UpdateUser(this.updatedUser);

  @override
  List<Object?> get props => [updatedUser];
}

class DeleteUser extends UserEvent {
  final int studentId;

  DeleteUser(this.studentId);

  @override
  List<Object?> get props => [studentId];
}
