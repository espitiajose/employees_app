import 'package:employee_app/styles/empColors.dart';
import 'package:employee_app/styles/empSharedStyles.dart';
import 'package:employee_app/ui/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class AppPage extends StatefulWidget {

  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(110),
        child: Head(isActives: currentIndex == 0,),
      ),
      body: Stack(
        children: [
          Positioned(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                color: Colors.white,
                child: child,
              ),
            ),
          ),
          Positioned(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: EmpSharedStyles.gradientDecoration2.copyWith(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(23), topRight: Radius.circular(23))
                ),
                child: BottomNavigationBar(
                    backgroundColor: Colors.transparent,
                    fixedColor: Theme.of(context).accentColor,
                    elevation: 0,
                    iconSize: 30,
                    selectedFontSize: 12,
                    unselectedFontSize: 12,
                    unselectedIconTheme: IconThemeData(color: Colors.white),
                    unselectedItemColor: Colors.white,
                    currentIndex: currentIndex,
                    onTap: changeOption,
                    type: BottomNavigationBarType.fixed,
                    unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w300),
                    selectedLabelStyle: TextStyle(fontWeight: FontWeight.w800),
                    items: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: _Icon(Icons.check),
                        label: 'Activos',
                      ),
                      BottomNavigationBarItem(
                        icon: _Icon(Icons.close_sharp),
                        label: 'Inactivos',
                      ),
                    ],
                  ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget get child {
    return SizedBox();
  }

  changeOption(int index) {
    setState(() {currentIndex = index;});
  }
}

class Head extends StatelessWidget {

  final bool isActives;

  const Head({
    Key? key, 
    required this.isActives
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        IconButton(
          icon: Icon(Icons.add_circle_sharp, color: Theme.of(context).accentColor, size: 30),
          tooltip: 'Agregar empleado',
          onPressed: add,
        ),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Label(
              width: double.infinity,
              text: "Empleados", 
              margin: EdgeInsets.only(left: 10),
              style: Theme.of(context).textTheme.headline1?.copyWith(
              color: Theme.of(context).primaryColorDark,
              fontWeight: FontWeight.bold
            )),
            AnimatedCrossFade(
              crossFadeState: isActives ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              duration: Duration(milliseconds: 500),
              firstCurve: Curves.easeOut,
              secondCurve: Curves.easeIn,
              firstChild: Label(
                text: "Activos", 
                margin: EdgeInsets.only(left: 10),
                style: Theme.of(context).textTheme.headline5?.copyWith(color: Theme.of(context).primaryColor)
              ),
              secondChild: Label(
                text: "Inactivos", 
                margin: EdgeInsets.only(left: 10),
                style: Theme.of(context).textTheme.headline5?.copyWith(color: Theme.of(context).primaryColor)
              ),            
            ),
            Container(
              height: .3,
              margin: EdgeInsets.only(top: 5),
              width: double.infinity,
              color: EmpColors.graySide,
            )
          ],
        ),
      ),
    );
  }

  add() {
    Get.toNamed('add');
  }
}


class _Icon extends StatelessWidget {

  final IconData icon;

  const _Icon(
    this.icon,
    {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Icon(this.icon),
    );
  }
}