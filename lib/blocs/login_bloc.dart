import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_map/repositories/login_repository.dart';

abstract class LoginEvent {}

class InitializeEvent extends LoginEvent {}

class AttemptLoginEvent extends LoginEvent {}

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginErrorState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository repository;

  LoginBloc({required this.repository}) : super(LoginInitialState()) {
    on<InitializeEvent>((event, emit) {
      // To make listeners fire on the initial state, we need to emit it.
      emit(LoginInitialState());
    });

    on<AttemptLoginEvent>((event, emit) async {
      var loggedIn = await repository.login("", "");

      if (loggedIn) {
        emit(LoginSuccessState());
      } else {
        emit(LoginErrorState());
      }
    });
  }
}
