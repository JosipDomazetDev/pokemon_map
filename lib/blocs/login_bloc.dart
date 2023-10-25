import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_map/repositories/login_repository.dart';

abstract class LoginEvent {}

class InitializeEvent extends LoginEvent {}

class AttemptLoginEvent extends LoginEvent {
  String username;
  String password;

  AttemptLoginEvent(this.username, this.password);
}

class LogoutEvent extends LoginEvent {
}

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginErrorState extends LoginState {}

class LoginSuccessState extends LoginState {
  UserCredential userCredential;

  LoginSuccessState(this.userCredential);
}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository repository;

  LoginBloc({required this.repository}) : super(LoginInitialState()) {
    on<InitializeEvent>((event, emit) {
      // To make listeners fire on the initial state, we need to emit it.
      emit(LoginInitialState());
    });

    on<AttemptLoginEvent>((event, emit) async {
      UserCredential? userCredential =
          await repository.login(event.username, event.password);

      if (userCredential != null) {
        emit(LoginSuccessState(userCredential));
      } else {
        emit(LoginErrorState());
      }
    });

    on<LogoutEvent>((event, emit) async {
      await repository.logout();
      emit(LoginInitialState());
    });
  }
}
