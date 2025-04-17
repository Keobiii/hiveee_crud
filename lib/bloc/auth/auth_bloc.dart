import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hiveee/bloc/auth/auth_event.dart';
import 'package:hiveee/bloc/auth/auth_state.dart';
import 'package:hiveee/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

// BLoc - this is where the logic works
// it listens fro events
// it performs the logic
// then emit the new state

// basically add the data inside of the userRepository since its the one who talks with Hive
// and emits the state if its success or not

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;

  AuthBloc({required this.userRepository}) : super(AuthInitial()) {
    on<RegisterUser>(_onRegisterUser);
    on<LoginUser>(_onLoginUser);
  }

  // Future - represents a value that will be available later, like a promise.
  // In this case, "_onRegisterUser" is an async function that promises to complete later.
  // It doesn't return any data (void), but it performs an action: registering a user.

  // void - means this function doesn't return any value.
  // If we changed "void" to String, int, or User, that would mean it returns that data type.

  // async - makes this function asynchronous.
  // It allows us to use "await", which pauses the function until the awaited operation finishes.

  // Emitter - comes from BLoC. It's used to emit new states (like loading, success, failure).
  // When we emit a state, the UI listens and updates based on that state.

  Future<void> _onRegisterUser(
    RegisterUser event,
    Emitter<AuthState> emit,
  ) async {
    // Tell the UI we're doing something (like showing a loading spinner)
    emit(AuthLoading());

    try {
      // Try to add the user (like saving to Hive or a database)
      await userRepository.addUser(event.user);

      // If it's successful, emit AuthSuccess and pass the registered user
      emit(AuthSuccess(event.user));
    } catch (e) {
      // If there's an error (like saving failed), emit an error state
      emit(AuthFailure("Failed to register user."));
    }
  }

  Future<void> _onLoginUser(LoginUser event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final user = await userRepository.getUserByNameAndPassword(
      event.email,
      event.password,
    );

    if (user != null) {
      // Save to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('userId', user.userId);
      await prefs.setInt('userRole', user.userRole);

      emit(AuthSuccess(user));
      print('User Role: ${user.userRole}');
    } else {
      emit(AuthFailure("Invalid credentials."));

      print('Failed: ');
    }
  }
}
