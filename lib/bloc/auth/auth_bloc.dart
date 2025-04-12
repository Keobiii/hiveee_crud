import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hiveee/bloc/auth/auth_event.dart';
import 'package:hiveee/bloc/auth/auth_state.dart';
import 'package:hiveee/repositories/user_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;

  AuthBloc({required this.userRepository}) : super(AuthInitial()) {
    on<RegisterUser>(_onRegisterUser);
    on<LoginUser>(_onLoginUser);
  }

  Future<void> _onRegisterUser(RegisterUser event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      await userRepository.addUser(event.user);
      emit(AuthSuccess(event.user));
    } catch (e) {
      emit(AuthFailure("Failed to register user."));
    }
  }

  Future<void> _onLoginUser(LoginUser event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final user = await userRepository.getUserByNameAndPassword(event.firstName, event.password);

    if (user != null) {
      emit(AuthSuccess(user));
    } else {
      emit(AuthFailure("Invalid credentials."));
    }
  }
}
