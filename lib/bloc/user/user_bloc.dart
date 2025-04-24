import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hiveee/bloc/user/user.event.dart';
import 'package:hiveee/bloc/user/user_state.dart';
import 'package:hiveee/models/user.dart';
import 'package:hiveee/repositories/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UpdateInitial()) {
    on<LoadUsers>(_onLoadUsers);
    on<DeleteUser>(_onDeleteUser);
    on<UpdateUser>(_onUpdateUser);
  }

  Future<void> _onLoadUsers(LoadUsers event, Emitter<UserState> emit) async {
    emit(UpdateLoading());
    print("Loading users...");

    try {
      final userBox = Hive.box<User>('users');
      final users = userBox.values.toList();
      emit(UsersLoaded(users));
    } catch (e) {
      emit(UpdateFailure("Failed to load users: $e"));
    }
  }

  Future<void> _onDeleteUser(DeleteUser event, Emitter<UserState> emit) async {
    emit(UpdateLoading());

    try {
      await userRepository.deleteUser(event.studentId);
      // Reload users from Hive after deletion
      final userBox = Hive.box<User>('users');
      final users = userBox.values.toList();
      emit(UsersLoaded(users));
    } catch (e) {
      emit(UpdateFailure("Failed to delete user: $e"));
    }
  }

  Future<void> _onUpdateUser(UpdateUser event, Emitter<UserState> emit) async {
    emit(UpdateLoading());

    try {
      await userRepository.updateUser(event.updatedUser);
      emit(UpdateSuccess(event.updatedUser));
    } catch (e) {
      emit(UpdateFailure("Failed to update user: $e"));
    }
  }
}
