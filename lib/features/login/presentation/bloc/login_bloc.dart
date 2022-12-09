import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_interseguro/core/helper/login_api.dart';
import 'package:login_interseguro/preferences/preferencias_usuario.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    final prefs = Preferences();

    on<LoginUserEvent>((event, emit) async {
      final loginApi = LoginApi();

      emit(Loading());
      //llamar a la api de login---
      await Future.delayed(const Duration(seconds: 2));
      var res = await loginApi.loginUser(event.user, event.password);

      if (res["code"] == 0) {
        emit(loggedInState(prefs.user));
      } else {
        var error = res['message'];
        emit(loggedFailedState(error));
      }
    });
  }
}
