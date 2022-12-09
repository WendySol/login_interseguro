part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {
  LoginInitial();
}

class loggedInState extends LoginState {
  final String? user;
 

  loggedInState(this.user);
}

class Loading extends LoginState {}

class loggedFailedState extends LoginState {
  final String? error;

  loggedFailedState(
    this.error,
  );
}
