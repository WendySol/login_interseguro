import 'package:flutter/widgets.dart';

class CustomSocialIcons {
  CustomSocialIcons._();

  static const _kFontFam = 'CustomSocialIcons';
  static const String? _kFontPkg = null;

  static const IconData twitter =
      IconData(0xf099, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData linkedin =
      IconData(0xf0e1, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData google =
      IconData(0xf1a0, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData facebook =
      IconData(0xf30c, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}

class ButtonSocialComponent extends StatelessWidget {
  const ButtonSocialComponent(
      {Key? key,
      required this.child,
      required this.onTap,
      required this.colors})
      : super(key: key);
  final Widget child;
  final List<Color> colors;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: colors)),
        child: child,
      ),
    );
  }
}
