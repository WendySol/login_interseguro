import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_interseguro/features/home/presentation/pages/home_screen.dart';
import 'package:login_interseguro/features/login/presentation/bloc/login_bloc.dart';
import 'package:login_interseguro/features/login/presentation/pages/login_screen.dart';
import 'package:login_interseguro/features/login/presentation/provider/radio_rememberme_provider.dart';
import 'package:login_interseguro/splash.dart';
import 'package:provider/provider.dart';

import 'preferences/preferencias_usuario.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  //inicializar preferences
  final prefs = Preferences();
  await prefs.initPrefs();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginBloc()),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<RememberMeProvider>(
              create: (_) => RememberMeProvider()),
        ],
        child: MaterialApp(
          title: 'Interseguro',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'Nunito'),
          home: Splash(),
          routes: {
            'login': (context) => const LoginScreen(),
            'splash': (context) =>  Splash(),
            'home': (context) => HomeScreen(),
          },
        ),
      ),
    );
  }
}
