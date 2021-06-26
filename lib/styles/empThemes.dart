import 'package:employee_app/styles/empColors.dart';
import 'package:flutter/material.dart';

class EmpThemes {

  static ThemeData ligth = ThemeData(
      brightness: Brightness.light,
      accentColor: EmpColors.aqua,
      primaryColor: EmpColors.blue,
      primaryColorDark: EmpColors.blueDark,
      errorColor: EmpColors.red,
      checkboxTheme: CheckboxThemeData(fillColor:MaterialStateProperty.all(EmpColors.green)),
      indicatorColor: EmpColors.graySide,
      iconTheme: IconThemeData(color: EmpColors.blueDark),
      fontFamily: 'Roboto',
      textTheme: TextTheme(
        subtitle1: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, letterSpacing: -0.03),
        subtitle2: TextStyle(fontSize: 16, letterSpacing: -0.03),
        bodyText1: TextStyle(fontSize: 16, fontWeight: FontWeight.w300, letterSpacing: -0.03),
        bodyText2: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, letterSpacing: -0.03),
        button: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white),
        overline: TextStyle(fontWeight: FontWeight.w100, fontSize: 12, letterSpacing:  -0.03),
        headline1: TextStyle(fontWeight: FontWeight.w800, fontSize: 35, letterSpacing:  -0.03),
        headline2: TextStyle(fontWeight: FontWeight.w800, fontSize: 30, letterSpacing:  -0.03),
        headline3: TextStyle(fontWeight: FontWeight.w600, fontSize: 27, letterSpacing:  -0.03),
        headline4: TextStyle(fontWeight: FontWeight.w600, fontSize: 24, letterSpacing:  -0.03),
        headline5: TextStyle(fontWeight: FontWeight.w600, fontSize: 19, letterSpacing:  -0.03),
        headline6: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, letterSpacing:  -0.03),
        caption: TextStyle(fontWeight: FontWeight.w300, fontSize: 14, letterSpacing:  -0.03),
      )
  );
}
