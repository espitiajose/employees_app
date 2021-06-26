import 'package:flutter/material.dart';

class Label extends StatelessWidget {

  final String text;
  final EdgeInsets? margin;
  final TextAlign align;
  final TextOverflow? overflow;
  final double? heigth;
  final TextStyle? style;
  final VoidCallback? onPressed;
  final double? width;
  final Color? splashColor;
  final BoxConstraints? constraints;

  const Label({
    Key? key,
    required this.text,
    this.margin,
    this.align = TextAlign.left,
    this.overflow,
    this.heigth,
    this.width,
    this.style,
    this.splashColor,
    this.onPressed,
    this.constraints
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: this.margin,
      height: this.heigth,
      width: this.width,
      constraints: this.constraints,
      child: child
    );
  }

  Widget get child {
    return this.onPressed == null ? textWidget
    : TextButton(onPressed: this.onPressed, child: textWidget,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size(20, 20),
        alignment: Alignment.center,
        primary: splashColor
      ));
  }

  Text get textWidget {
    return Text(this.text,
      textAlign: this.align,
      overflow: overflow,
      maxLines: 5,
      style: this.style ?? TextStyle(fontSize: 13, color: Colors.white, decoration: TextDecoration.none)
    );
  }
  
}