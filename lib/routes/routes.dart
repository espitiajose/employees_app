import 'package:employee_app/ui/pages/app/add/add_page.dart';
import 'package:employee_app/ui/pages/app/app_page.dart';
import 'package:employee_app/ui/pages/splash_page.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  'splash': (_) => SplashPage(),
  'app': (_) => AppPage(),
  'add': (_) => AddPage(),
};
