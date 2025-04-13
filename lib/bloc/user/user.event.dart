import 'package:equatable/equatable.dart';
import 'package:hiveee/models/user.dart';

abstract class UserEvent extends Equatable {

    @override
  List<Object?> get props => [];
  
}

class UpdateUser extends UserEvent {
  final User updatedUser;

  UpdateUser(this.updatedUser);

  @override
  List<Object?> get props => [updatedUser];
}