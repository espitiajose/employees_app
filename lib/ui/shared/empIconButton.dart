import 'package:flutter/material.dart';

class EmpIconButton extends StatelessWidget {

  final Icon icon;
  final Function() action;
  final String? tooltip;
  final double height;
  final double width;
  final Color? color;

  const EmpIconButton({
    Key? key, 
    required this.icon, 
    required this.action,
    this.height = 40,
    this.width = 40,
    this.tooltip,
    this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Stack(
        children: [
          Center(
            child: Transform.rotate(
              angle: 90,
              child: Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  color: color ?? Theme.of(context).accentColor,
                  borderRadius: BorderRadius.all(Radius.circular(10))
                )
              ),
            ),
          ),
          Center(child: icon)
        ],
      ),
      tooltip: tooltip,
      onPressed: action,
    );
  }
}