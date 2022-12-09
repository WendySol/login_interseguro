import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_interseguro/core/util/colors.dart';
import 'package:login_interseguro/core/util/responsive.dart';
import 'package:login_interseguro/features/login/presentation/bloc/login_bloc.dart';
import 'package:login_interseguro/features/login/presentation/provider/bloc_validators.dart';
import 'package:login_interseguro/features/login/presentation/provider/radio_rememberme_provider.dart';
import 'package:login_interseguro/features/login/presentation/widgets/buttons/button_component.dart';
import 'package:login_interseguro/features/login/presentation/widgets/custom_social_icons.dart';
import 'package:login_interseguro/features/login/presentation/widgets/widget_gradient.dart';
import 'package:login_interseguro/features/login/presentation/widgets/widget_shadow_component.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../preferences/preferencias_usuario.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //instancia del bloc
  LoginBloc loginBloc = LoginBloc();
  LoginBlocValidator loginValidator = LoginBlocValidator();
  //controllers
  final userController = TextEditingController();
  final passController = TextEditingController();

  Preferences prefs = Preferences();
  //radio de remember me
  bool statesesion = false;
  //visibilidad de la contraseña
  bool _securedText = true;

  @override
  void initState() {
    prefs.rememberme = false;
    super.initState();
  }

  @override
  void dispose() {
    loginValidator.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final saveSesionProvider = Provider.of<RememberMeProvider>(context);
    return BlocProvider.value(
      value: loginBloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          height: responsive.hp(100),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: responsive.hp(6), left: responsive.wp(15.5)),
                  child: Image.asset(
                    'assets/images/image_header.png',
                    fit: BoxFit.cover,
                    width: responsive.wp(100),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: responsive.hp(8), left: responsive.wp(5)),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.cover,
                      ),
                      Text(
                        'Interseguro',
                        style: TextStyle(
                            fontSize: responsive.ip(3),
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: responsive.hp(80)),
                  child: Image.asset(
                    'assets/images/image_footer.png',
                    width: responsive.wp(100),
                    height: responsive.hp(22),

                    // fit: BoxFit.fitWidth,
                  ),
                ),
                _boxLogin(responsive),
                _rowSingIn(responsive, saveSesionProvider),
                SocialMediaLogin(responsive: responsive)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _boxLogin(Responsive responsive) {
    return ShadowContainerComponent(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Login',
              style: TextStyle(
                  fontSize: responsive.ip(3),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5),
            ),
            SizedBox(height: responsive.hp(3)),
            Column(
              children: [
                _username(responsive),
                SizedBox(height: responsive.hp(3)),
                _password(responsive),
                SizedBox(height: responsive.hp(3)),
                _forgotPassword(responsive),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _username(Responsive responsive) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Username',
          style: TextStyle(
            fontSize: responsive.ip(1.7),
            fontWeight: FontWeight.w400,
          ),
        ),
        StreamBuilder<String>(
            stream: loginValidator.userStream,
            builder: (context, snapshot) {
              return TextFormField(
                cursorColor: AppPaletteColors.lightCyan,
                controller: userController,
                maxLength: 8,
                style: TextStyle(
                  fontSize: responsive.ip(1.9),
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                    hintStyle: TextStyle(
                      fontSize: responsive.ip(1.7),
                      color: Colors.grey,
                    ),
                    hintText: 'Usuario',
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    isDense: true,
                    errorText: snapshot.error?.toString(),
                    counterText: "",
                ),

                //autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: ((value) {
                  String user = value.trim();

                  loginValidator.changeEmail(user);
                }),
              );
            }),
      ],
    );
  }

  Widget _password(Responsive responsive) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: TextStyle(
            fontSize: responsive.ip(1.7),
            fontWeight: FontWeight.w400,
          ),
        ),
        StreamBuilder<String>(
            stream: loginValidator.passwordStream,
            builder: (context, snapshot) {
              return TextFormField(
                maxLength: 12,
                obscureText: _securedText,
                cursorColor: AppPaletteColors.lightCyan,
                controller: passController,
                style: TextStyle(
                  fontSize: responsive.ip(1.9),
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                    fontSize: responsive.ip(1.7),
                    color: Colors.grey,
                  ),
                  hintText: 'Contraseña',
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  isDense: true,
                  errorText: snapshot.error?.toString(),
                  suffixIcon: IconButton(
                    icon: _securedText
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                    iconSize: responsive.ip(2.5),
                    onPressed: () {
                      setState(() {
                        _securedText = !_securedText;
                      });
                    },
                  ),
                  counterText: "",
                ),
                onChanged: (value) {
                  loginValidator.changePassword(value.trim());
                },
                //autovalidateMode: AutovalidateMode.onUserInteraction,
              );
            }),
      ],
    );
  }

  Widget _forgotPassword(Responsive responsive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          'Forgot Password?',
          style: TextStyle(
            color: AppPaletteColors.lightCyan,
            fontSize: responsive.ip(2),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _rowSingIn(
      Responsive responsive, RememberMeProvider saveSesionProvider) {
    return Container(
      width: responsive.wp(99),
      margin: EdgeInsets.only(top: responsive.hp(76)),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: responsive.wp(5)),
          _rememberMeRadio(statesesion, saveSesionProvider, responsive),
          SizedBox(width: responsive.wp(7)),
          _buttonSingIn(responsive),
        ],
      ),
    );
  }

  Widget _rememberMeRadio(bool statesesion,
      RememberMeProvider saveSesionProvider, Responsive responsive) {
    return Row(
      children: [
        GestureDetector(
            onTap: () {
              statesesion = !saveSesionProvider.rememberme;
              //print("press $statesesion");

              //guardar en preferences
              prefs.rememberme = statesesion;
              //cambiar valor con provider
              saveSesionProvider.changeState(statesesion);
            },
            child: !saveSesionProvider.rememberme
                ? const Icon(Icons.radio_button_off)
                : const Icon(Icons.radio_button_checked)),
        SizedBox(width: responsive.wp(3)),
        Text(
          'Remember me',
          style: TextStyle(
            color: Colors.black,
            fontSize: responsive.ip(1.8),
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }

  Widget _buttonSingIn(Responsive responsive) {
    return BlocListener<LoginBloc, LoginState>(listener: (context, state) {
      if (state is loggedInState) {
        Navigator.pushReplacementNamed(context, 'home');
      } else if (state is loggedFailedState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              state.error!,
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }, child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Stack(
        children: [
          StreamBuilder(
              stream: loginValidator.formValidStream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return BoxGradient(
                  child: Button(
                      heigth: 6,
                      width: 45,
                      child: Text(
                        'SINGIN',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: responsive.ip(2.0),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onTap: () {
                        if (snapshot.hasData) {
                          //enviar datos al bloc
                          loginBloc.add(LoginUserEvent(
                              loginValidator.user, loginValidator.password));
                          // print(
                          //     "user: ${userController.text}, pass: ${passController.text} ");
                        } else if (userController.text.isEmpty ||
                            passController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Ingrese sus credenciales por favor",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Ingrese sus credenciales correctamente, por favor",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }
                      }),
                );
              }),
          state is Loading ? _buildLoading(responsive) : Container()
        ],
      );
    }
        //}
        ));
  }
}

Widget _buildLoading(Responsive responsive) => Padding(
      padding:  EdgeInsets.only(left: responsive.wp(20), top: responsive.hp(1)),
      child: CircularProgressIndicator(
        color: AppPaletteColors.inDarkblue,
      ),
    );

class SocialMediaLogin extends StatelessWidget {
  const SocialMediaLogin({Key? key, required this.responsive})
      : super(key: key);
  final Responsive responsive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: responsive.hp(86)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: responsive.wp(20),
                height: responsive.hp(0.2),
                color: Colors.grey[300],
              ),
              SizedBox(width: responsive.wp(4)),
              Text(
                'Social Login',
                style: TextStyle(
                    fontSize: responsive.ip(2.0),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0),
              ),
              SizedBox(width: responsive.wp(4)),
              Container(
                width: responsive.wp(20),
                height: responsive.hp(0.2),
                color: Colors.grey[300],
              ),
            ],
          ),
          SizedBox(height: responsive.hp(2)),
          Center(
            child: SizedBox(
              width: responsive.wp(70),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _facebook(),
                  _google(),
                  _twitter(),
                  _linkedin(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  ButtonSocialComponent _linkedin() {
    return ButtonSocialComponent(
        colors: [
          AppPaletteColors.inLightCyan,
          AppPaletteColors.inDarkblue,
        ],
        onTap: () async {
          String url = "https://www.linkedin.com/";
          final Uri toLaunch = Uri(
            scheme: 'https',
            host: 'www.linkedin.com',
          );
          if (!await launchUrl(
            toLaunch,
            mode: LaunchMode.externalApplication,
          )) {
            throw 'No se pudo encontrar $url';
          }
        },
        child: Icon(
          CustomSocialIcons.linkedin,
          color: AppPaletteColors.white,
        ));
  }

  ButtonSocialComponent _twitter() {
    return ButtonSocialComponent(
        colors: [
          AppPaletteColors.twitterLightCyan,
          AppPaletteColors.twitterDarkblue,
        ],
        onTap: () async {
          String url = "https://twitter.com/";
          final Uri toLaunch = Uri(
            scheme: 'https',
            host: 'www.twitter.com',
          );
          if (!await launchUrl(
            toLaunch,
            mode: LaunchMode.externalApplication,
          )) {
            throw 'No se pudo encontrar $url';
          }
        },
        child: Icon(
          CustomSocialIcons.twitter,
          color: AppPaletteColors.white,
        ));
  }

  ButtonSocialComponent _google() {
    return ButtonSocialComponent(
        colors: [
          AppPaletteColors.googleLightRed,
          AppPaletteColors.googleDarkRed,
        ],
        onTap: () async {
          String url = "https://accounts.google.com/Login";
          final Uri toLaunch =
              Uri(
                scheme: 'https', 
                host: 'www.google.com'
                );
          if (!await launchUrl(
            toLaunch,
            mode: LaunchMode.externalApplication,
          )) {
            throw 'No se pudo encontrar $url';
          }
        },
        child: Icon(
          CustomSocialIcons.google,
          color: AppPaletteColors.white,
        ));
  }

  ButtonSocialComponent _facebook() {
    return ButtonSocialComponent(
        colors: [
          AppPaletteColors.faceDarkBlue,
          AppPaletteColors.faceLightCyan,
        ],
        onTap: () async {
          String url = "https://facebook.com/";
          final Uri toLaunch = Uri(
            scheme: 'https',
            host: 'www.facebook.com',
            //path: 'headers/'
          );
          if (!await launchUrl(
            toLaunch,
            mode: LaunchMode.externalApplication,
          )) {
            throw 'No se pudo encontrar $url';
          }
        },
        child: Icon(
          CustomSocialIcons.facebook,
          color: AppPaletteColors.white,
        ));
  }
}
