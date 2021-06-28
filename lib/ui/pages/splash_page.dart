import 'package:employee_app/controllers/employee_controller.dart';
import 'package:employee_app/helpers/empImages.dart';
import 'package:employee_app/styles/empSharedStyles.dart';
import 'package:employee_app/ui/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class SplashPage extends StatefulWidget {

  final x = Get.put(EmployeeController());
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      decoration: EmpSharedStyles.gradientDecoration1,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Label(text: "Bienvenido a", style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.white)),
            Label(
              text: "EmployeeApp", 
              margin: EdgeInsets.only(top: 10),
              style: Theme.of(context).textTheme.headline1?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold
            )),
            Padding(
              padding: EdgeInsets.symmetric(vertical: Get.height * .1),
              child: CircularPercentIndicator(
                animation: true,
                radius: 200,
                animationDuration: 2500,
                percent: 1,
                backgroundColor: Colors.transparent,
                progressColor: Colors.white,
                circularStrokeCap: CircularStrokeCap.round,
                onAnimationEnd: () => next(context),
                center: Padding(
                  padding: EdgeInsets.all(10),
                  child: EmpImages.logo2(170),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

  next(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, "app", (r) => false);
  }
}