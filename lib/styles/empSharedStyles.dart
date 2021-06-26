import 'package:employee_app/styles/empColors.dart';
import 'package:flutter/material.dart';

class EmpSharedStyles {

  static BoxDecoration gradientDecoration1 = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        EmpColors.blue,
        EmpColors.blueDark,
      ],
    )
  );

  static BoxDecoration gradientDecoration2 = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        EmpColors.blue,
        EmpColors.blueMedium,
      ],
    )
  );
}