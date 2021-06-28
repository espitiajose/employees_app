import 'dart:io';

import 'package:employee_app/controllers/employee_controller.dart';
import 'package:employee_app/helpers/empImages.dart';
import 'package:employee_app/helpers/showDialog.dart';
import 'package:employee_app/models/employee_model.dart';
import 'package:employee_app/models/enums/area_enum.dart';
import 'package:employee_app/services/employee_service.dart';
import 'package:employee_app/styles/empColors.dart';
import 'package:employee_app/ui/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class EmployeeList extends StatefulWidget {

  final Function() onRefreshNews;
  final Function() onRefreshLoad;
  final bool error;
  final List<EmployeeModel> employeeList;
  final RefreshController refreshController;

  const EmployeeList({
    Key? key,
    required this.onRefreshNews,
    required this.onRefreshLoad,
    required this.employeeList,
    required this.refreshController,
    this.error = false,
  }) : super(key: key);

  @override
  _EmployeeListState createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  @override
  Widget build(BuildContext context) {
        return SmartRefresher(
          enablePullDown: true,
          enablePullUp: !this.widget.error && this.widget.employeeList.length > 0,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: this.widget.employeeList.length,
            padding: EdgeInsets.all(15),
            itemBuilder: (_, int index) => _EmployeeItem(employee: this.widget.employeeList[index]),
          ),
          onRefresh: this.widget.onRefreshNews,
          onLoading: this.widget.onRefreshLoad,
          controller: this.widget.refreshController,
          header: CustomHeader(
            builder: (BuildContext context, RefreshStatus? mode) {
              switch (mode) {
                case RefreshStatus.idle:
                  return _RefreshState(
                      icon: Icons.arrow_downward, text: 'Busqueda de nuevos empleados');
                case RefreshStatus.refreshing:
                  return _RefreshState(icon: Icons.refresh, text: 'Buscando empleados');
                case RefreshStatus.failed:
                  return _RefreshState(
                      icon: Icons.close,
                      text: 'Ha ocurrido un error, vuelve a intentarlo');
                case RefreshStatus.canRefresh:
                  return _RefreshState(
                      icon: Icons.touch_app,
                      text: 'Suelta para empezar la busqueda');
                case RefreshStatus.completed:
                  return _RefreshState(
                      icon: Icons.check,
                      text: 'Encontramos nuevos empleados');
                default:
                  return _RefreshState(
                      icon: Icons.sentiment_dissatisfied,
                      text: 'No encontramos empleados');
              }
            },
          ),
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus? mode) {
              Future.delayed(Duration(seconds: 5), () => widget.refreshController.loadComplete());
              switch (mode) {
                case LoadStatus.idle:
                  return _RefreshState(
                      icon: Icons.arrow_upward, text: 'Encuentra más empleados');
                case LoadStatus.loading:
                  return _RefreshState(icon: Icons.refresh, text: 'Cargando empleados');
                case LoadStatus.failed:
                  return _RefreshState(
                      icon: Icons.close,
                      text: 'Ha ocurrido un error, vuelve a intentarlo');
                case LoadStatus.canLoading:
                  return _RefreshState(
                      icon: Icons.touch_app, text: 'Suelta para cargar empleados');
                case LoadStatus.noMore:
                  return _RefreshState(
                      icon: Icons.face,
                      text: 'No hay más empleados');
                default:
                  return _RefreshState(
                      icon: Icons.sentiment_dissatisfied,
                      text: 'No encontramos más empleados');
              }
            },
          )
        );
      }
}

class _EmployeeItem extends StatefulWidget {

  final EmployeeModel employee;

  const _EmployeeItem({Key? key, required this.employee}) : super(key: key);

  @override
  __EmployeeItemState createState() => __EmployeeItemState();
}

class __EmployeeItemState extends State<_EmployeeItem> {



  final employeeService = EmployeeService();
  final employeeCtrl = Get.find<EmployeeController>();
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !(widget.employee.status ?? false) ? null : () => Get.toNamed('add', arguments: widget.employee.toJson()),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              offset: Offset(1,1),
              color: Colors.grey
            )
          ]
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Stack(
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            child: Stack(
                              children: [
                                Center(
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).accentColor.withOpacity(.2),
                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: Transform.rotate(
                                    angle: 90,
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).accentColor.withOpacity(.3),
                                        borderRadius: BorderRadius.all(Radius.circular(15))
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Icon(icon, color: Theme.of(context).accentColor, size: 50,)
                                ),
                              ],
                            ),
                          ),
                          Label(
                            text: widget.employee.proffesionalArea,
                            style: Theme.of(context).textTheme.caption?.copyWith(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                              fontSize: 10
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Label(
                          text: widget.employee.name,
                          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        Label(
                          text: widget.employee.email ?? '',
                          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: Colors.blueGrey,
                          ),
                        ),
                        Label(
                          text: 'Fecha de adminisión',
                          margin: EdgeInsets.only(top: 10),
                          style: Theme.of(context).textTheme.caption?.copyWith(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                            fontSize: 10
                          ),
                        ),
                        Label(
                          text: widget.employee.dateOfAdmissionFormatted,
                          style: Theme.of(context).textTheme.caption?.copyWith(
                            color: Colors.blueGrey,
                            fontSize: 11
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                right: -10,
                top: -10,
                child: EmpIconButton(
                  action: actionButton,
                  height: 25,
                  width: 25,
                  tooltip: (widget.employee.status ?? false) ? 'Inactivar' : 'Activar',
                  color: (widget.employee.status ?? false) ? EmpColors.red : Colors.lightGreen,
                  icon: Icon((widget.employee.status ?? false) ? Icons.close : Icons.keyboard_arrow_up_sharp, color: Colors.white, size: 18),
                ),
              )
            ],
          ),
        )
      ),
    );
  }

  IconData get icon {
    switch(widget.employee.area) {
      case AreaEnum.ADMIN:
        return Icons.admin_panel_settings;
      case AreaEnum.FINANCIAL:
        return Icons.attach_money;
      case AreaEnum.SHOPPING:
        return Icons.shopping_cart_rounded;
      case AreaEnum.INFRASTRUCTURE:
        return Icons.view_column;
      case AreaEnum.OPERATION:
        return Icons.support_agent;
      case AreaEnum.HUMANTALENT:
        return Icons.accessibility_new_sharp;
      case AreaEnum.SERVICES:
        return Icons.supervised_user_circle;
      case AreaEnum.OTHER:
        return Icons.admin_panel_settings;
    }
  }

  actionButton() {
    if(widget.employee.status ?? false) {
      ShowDialog.basicDialog(
        context: context,
        title: '¿Seguro que quieres inactivar este empleado?',
        titleAlign: TextAlign.center,
        image: EmpImages.off(150),
        widget: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Button(
            text: 'Inactivar', 
            color: EmpColors.red,
            margin: EdgeInsets.symmetric(horizontal: 5),
            onPressed: innactive
          ),
        )
      );
    } else {
      ShowDialog.basicDialog(
        context: context,
        title: '¿Seguro que quieres activar este empleado?',
        titleAlign: TextAlign.center,
        image: EmpImages.off(150),
        widget: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Button(
            text: 'Activar', 
            color: Colors.lightGreen,
            margin: EdgeInsets.symmetric(horizontal: 5),
            onPressed: active
          ),
        )
      );
    }
  }

  innactive() async {
    try {
      EasyLoading.show(status: 'Inactivando empleando');
      final isInactive = await employeeService.inactive(widget.employee);
      if(isInactive) {
        employeeCtrl.addInactive(widget.employee);
        setState(() {});
        Navigator.pop(context);
      }
      Get.snackbar('Inactivación de empleado', 'Empleado inactivado exitosamente', backgroundColor: Colors.lightGreen.withOpacity(.5));
    } on SocketException {
      Get.snackbar('Error de conexión', 'Compruebe su conexión a internet y vuelva a intentarlo', backgroundColor: EmpColors.red.withOpacity(.5), duration: Duration(seconds: 1));
    } on HttpException catch (err) {
      Get.snackbar('Error', err.message, backgroundColor: EmpColors.red.withOpacity(.5), colorText: Colors.white);
    }
    EasyLoading.dismiss();
  }

  active() async{
    try {
      EasyLoading.show(status: 'Activando empleando');
      final isActive = await employeeService.active(widget.employee);
      if(isActive) {
        employeeCtrl.addActive(widget.employee);
        setState(() {});
        Navigator.pop(context);
      }
      Get.snackbar('Activación de empleado', 'Empleado activado exitosamente', backgroundColor: Colors.lightGreen.withOpacity(.5));
    } on SocketException {
      Get.snackbar('Error de conexión', 'Compruebe su conexión a internet y vuelva a intentarlo', backgroundColor: EmpColors.red.withOpacity(.5), duration: Duration(seconds: 1));
    } on HttpException catch (err) {
      Get.snackbar('Error', err.message, backgroundColor: EmpColors.red.withOpacity(.5), colorText: Colors.white);
    }
    EasyLoading.dismiss();
  }
}


class _RefreshState extends StatelessWidget {

  final IconData icon;
  final String text;
  final bool push;

  const _RefreshState({
    Key? key, 
    required this.icon, 
    required this.text,
    this.push = true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(this.icon, color: Theme.of(context).accentColor),
          Label(
            text: this.text,
            margin: EdgeInsets.only(left: 10),
            style: Theme.of(context).textTheme.subtitle2?.copyWith(
              color: Colors.black54,
            ),
          )
        ],
      ),
    );
  }
}