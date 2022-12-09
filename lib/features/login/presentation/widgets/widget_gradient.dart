import 'package:flutter/material.dart';
import 'package:login_interseguro/core/util/colors.dart';

class BoxGradient extends StatelessWidget {
  const BoxGradient({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              AppPaletteColors.twitterLightCyan,
              AppPaletteColors.inDarkblue,
            ],
          )),
      child: child,
    );
  }
}
