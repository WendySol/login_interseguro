import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_interseguro/core/util/responsive.dart';
import 'preferences/preferencias_usuario.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final preferences = Preferences();

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      if (preferences.rememberme == false ||
          preferences.rememberme == null ||
          preferences.user == null) {
        //si no existe un usuario logueado, pasa a Login
        Navigator.pushReplacementNamed(context, 'login');
      } else if (preferences.user != null && preferences.rememberme == true) {
        Navigator.pushReplacementNamed(context, 'home');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          
          Padding(
            padding: EdgeInsets.symmetric(vertical: responsive.hp(40),horizontal: responsive.wp(5)),
            child: Row(
          children: const [
            Image(
                image: AssetImage('assets/images/logo.png'),
                fit: BoxFit.contain),
            Text("INTERSEGURO",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                )),
          ],
            ),
          ),
          Positioned(
            top: responsive.hp(10),
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
                child: CupertinoActivityIndicator(
              radius: responsive.ip(2.0),
            )
            ),
          ),
        ],
      ),
    );
  }
}
