import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:login_interseguro/core/util/api_base.dart';
import 'package:login_interseguro/preferences/preferencias_usuario.dart';

class LoginApi {
  final prefs = Preferences();
  final _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  };

  Future<dynamic> loginUser(String username, String password) async {
    Map<String, dynamic> _response = {};

    const url = '$apiBaseURL/v1/auth/login';

    Map<String, dynamic> _requestBodyMap = {
      "user": username,
      "password": password
    };

    var requestBodyMap = json.encode(_requestBodyMap);

    try {
      var response = await http.post(Uri.parse(url),
          body: requestBodyMap, headers: _headers);

      var responseData = json.decode(response.body);

      switch (response.statusCode) {
        case (200):
          if (responseData['code'] == 0) {
            //guardar en preferencias
            prefs.user = responseData['body']['name'];

            _response["code"] = responseData['code'];
            _response["name"] = responseData['body']['name'];

            return _response;
          } else {
            _response = responseData['message'];
            return _response;
          }

        case (400):
          // print('Bad Data 400');
          _response['message'] = "Solicitud Incorrecta";

          return _response;

        case (401):
          _response['message'] = responseData['message'];

          return responseData;
        case (500):
          // print('Failed Upload 500');

          _response['message'] = "Ha ocurrido una falla en el servidor";
          return _response;

        default:
          //  print('Problemas de conexión');

          _response['message'] = "Hay problemas con la conexión";
          return _response;
      }
    } catch (error, stacktrace) {
      //  print("Exception occured: $error stackTrace: $stacktrace");

      _response['message'] = "Excepción ocurrida: $error Error: $stacktrace";
      return _response;
    }
  }
}
