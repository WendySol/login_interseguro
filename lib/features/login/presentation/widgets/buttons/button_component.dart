import 'package:flutter/material.dart';
import 'package:login_interseguro/core/util/responsive.dart';

class Button extends StatelessWidget {
  final Widget child;
  final Function()? onTap;
  final double width;
  final double heigth;
  final Color? color;

  const Button(
      {Key? key,
      required this.child,
      this.onTap,
      required this.width,
      required this.heigth,
       this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return SizedBox(
      width: responsive.wp(width),
      height: responsive.hp(heigth),
      
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 10,
              primary: Colors.transparent, shadowColor: Colors.transparent,
              //side: BorderSide(width: 2, color: color!),
            ),
            onPressed: onTap,
            child: child,
        )
    );
  }
}
