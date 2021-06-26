import 'package:employee_app/config/enviroment.dart';
import 'package:employee_app/routes/routes.dart';
import 'package:employee_app/styles/empColors.dart';
import 'package:employee_app/styles/empThemes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';

void setupApp() async {
  print('Start app - mode: ${Enviroment.flavorName}');
  configLoading();
  await GetStorage.init();
  runApp(EmployeeApp());
}

class EmployeeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    
    return GetMaterialApp(
      title: Enviroment.title,
      debugShowCheckedModeBanner: !Enviroment.isProd,
      theme: EmpThemes.ligth,
      initialRoute: 'splash',
      routes: routes,
      builder: (context, child) => Container(
        child: FlutterEasyLoading(child: child)
      )
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 55.0
    ..radius = 20.0
    ..progressColor = EmpColors.blueDark
    ..backgroundColor = Colors.transparent
    ..indicatorColor = EmpColors.aqua
    ..textColor = Colors.black
    ..maskType = EasyLoadingMaskType.custom
    ..maskColor = Colors.white.withOpacity(.8)
    ..userInteractions = false;
}
