part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginUserEvent extends LoginEvent {
  LoginUserEvent(this.user, this.password);
  final String user;
  final String password;
}

