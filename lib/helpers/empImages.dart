// ignore: implementation_imports
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmpImages {

  static Widget Function(double size) logo1 = (double size) => _buildSvg('employee_icon', size, 'Logo');
  static Widget Function(double size) logo2 = (double size) => _buildSvg('employee_icon_2', size, 'Logo');
  static Widget Function(double size) logo3 = (double size) => _buildSvg('employee_icon_3', size, 'Logo');
  static Widget Function(double size) off = (double size) => _buildSvg('off', size, 'Off');

  static SvgPicture _buildSvg(String name, double size, String semanticsLabel) => SvgPicture.asset('assets/images/svg/$name.svg',semanticsLabel: semanticsLabel,height: size);
}
