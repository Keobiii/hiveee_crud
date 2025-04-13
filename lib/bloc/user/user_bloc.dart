  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:hiveee/bloc/user/user.event.dart';
  import 'package:hiveee/bloc/user/user_state.dart';
  import 'package:hiveee/repositories/user_repository.dart';

  class UserBloc extends Bloc<UserEvent, UserState> {
    final UserRepository userRepository;

    UserBloc({required this.userRepository}) : super(UpdateInitial()) {
      on<UpdateUser>(_onUpdateUser);
    }

      Future<void> _onUpdateUser(UpdateUser event, Emitter<UserState> emit) async {
      emit(UpdateLoading());

      try {
        await userRepository.updateUser(event.updatedUser); 
        emit(UpdateSuccess(event.updatedUser));
      } catch (e) {
        emit(UpdateFailure(e.toString()));
      }
    }

  }
