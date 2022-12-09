import 'package:rxdart/rxdart.dart';
import 'package:login_interseguro/features/login/presentation/provider/validator.dart';

class LoginBlocValidator with Validators {
  
  final _userController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  //Recuperar los datos del Stream
  Stream<String> get userStream => _userController.stream.transform(validateuser);
  Stream<String> get passwordStream => _passwordController.stream.transform(validatePassword);

  Stream<bool> get formValidStream =>  Rx.combineLatest2(userStream, passwordStream, (u, p) => true);

  //inserta valores al Stream
  Function(String) get changeEmail => _userController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  //obtener el ultimo valor ingresado a los stream
  String get user => _userController.value;
  String get password => _passwordController.value;

  dispose() {
    _userController.close();
    _passwordController.close();
  }

 
}
