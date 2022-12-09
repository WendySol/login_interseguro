import 'package:flutter/material.dart';
import 'package:login_interseguro/core/util/colors.dart';
import 'package:login_interseguro/core/util/responsive.dart';
import 'package:login_interseguro/preferences/preferencias_usuario.dart';

class ShowDialogExit extends StatelessWidget {
  ShowDialogExit({Key? key}) : super(key: key);
  final prefs = Preferences();

  String message = "¿Está seguro que desea salir?";

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              message,
              style: TextStyle(
                color: AppPaletteColors.lightCyan,
                fontSize: responsive.ip(2)),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('No',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: responsive.ip(1.9),
                  color: Colors.grey)),
        ),
        TextButton(
          child: Text('Si',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: responsive.ip(1.9))),
          onPressed: () {
            //limpiar las preferencias
            prefs.clearPreferences();
            Navigator.pushNamedAndRemoveUntil(context, 'splash', (route) => false);
          },
        ),
      ],
    );
  
  }
}
