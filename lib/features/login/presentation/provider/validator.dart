import 'dart:async';

class Validators {
  final validateuser =
      StreamTransformer<String, String>.fromHandlers(handleData: (user, sink) {
    if (user.length == 8) {
      sink.add(user);
    } else if (user.isEmpty) {
      sink.addError('Ingrese su usuario, por favor');
    } else if (user.length < 8) {
      sink.addError('El usuario debe tener 8 caracteres');
    }
  });
  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@+#\$&*~]).{6,}$';
    RegExp regExp = RegExp(pattern);

    if (regExp.hasMatch(password)) {
      sink.add(password);
    } else if (password.isEmpty) {
      sink.addError('Ingrese una contraseña, por favor');
    } else {
      sink.addError('La contraseña no es válida');
    }
  });
}
