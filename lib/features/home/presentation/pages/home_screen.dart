import 'package:flutter/material.dart';
import 'package:login_interseguro/core/util/responsive.dart';
import 'package:login_interseguro/features/home/presentation/widgets/alert_dialog_component.dart';
import 'package:login_interseguro/preferences/preferencias_usuario.dart';


class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  var prefs = Preferences();

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return Scaffold(
        appBar: AppBar(
          title:  Center(child:  Text("Interseguro",
            style: TextStyle(
                fontSize: responsive.ip(2.5),
                fontWeight: FontWeight.bold,
                ),
          )),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: <Color>[Color(0xFF17ead9), Color(0xFF005bea)]),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return ShowDialogExit();
                      });
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(width: responsive.wp(99)),
            Text(
              'Empleado Logueado:',
              style: TextStyle(
                fontSize: responsive.ip(1.7),
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              prefs.user!,
              style: TextStyle(
                fontSize: responsive.ip(1.7),
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: responsive.hp(3)),
            Text(
              "¿Mantener sesión iniciada?",
              style: TextStyle(
                fontSize: responsive.ip(1.7),
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              prefs.rememberme.toString(),
              style: TextStyle(
                fontSize: responsive.ip(1.7),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ));
  }
}
