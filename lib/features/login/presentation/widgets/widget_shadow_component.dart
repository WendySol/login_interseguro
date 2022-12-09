import 'package:flutter/material.dart';
import 'package:login_interseguro/core/util/responsive.dart';

class ShadowContainerComponent extends StatelessWidget {
  const ShadowContainerComponent({Key? key, required this.child})
      : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return Container(
      height: responsive.hp(43),
      margin: EdgeInsets.symmetric(
          vertical: responsive.hp(30), horizontal: responsive.wp(6)),
      padding: EdgeInsets.symmetric(
          vertical: responsive.hp(2), horizontal: responsive.wp(4)),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: const <BoxShadow>[
            BoxShadow(
                color: Colors.black26,
                blurRadius: 3.0,
                offset: Offset(0.0, 5.0),
                spreadRadius: 3.0)
          ]),
      child: child,
    );
  }
}
