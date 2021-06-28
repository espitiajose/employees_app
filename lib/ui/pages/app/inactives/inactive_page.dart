import 'dart:io';

import 'package:employee_app/controllers/employee_controller.dart';
import 'package:employee_app/services/employee_service.dart';
import 'package:employee_app/styles/empColors.dart';
import 'package:employee_app/ui/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class InactivePage extends StatefulWidget {


  final employeeCtrl = Get.find<EmployeeController>();

  @override
  _InactivePageState createState() => _InactivePageState();
}

class _InactivePageState extends State<InactivePage> {

  final RefreshController refreshCtlrNews = RefreshController(initialRefresh: true);
  final _employeeService = EmployeeService();

  int page = 0;
  int lastPage = 0;
  final limit = 8;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      child: EmployeeList( 
          refreshController: refreshCtlrNews,
          employeeList: widget.employeeCtrl.inactiveEmployees,
          onRefreshNews: fetchOrders,
          onRefreshLoad: nextPage
        ),
      );
  }

  @override
  void initState() { 
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    this.refreshCtlrNews.dispose();
  }

  Future nextPage() async {
    try {
      final res = await _employeeService.getInactives(page+1, limit: limit);
      lastPage = (res.total / limit).ceil();
      if(res.data.length > 0 && lastPage >= page+1) {
        page++;
        widget.employeeCtrl.inactiveEmployees.addAll(res.data);
      }
    } on SocketException {
      refreshCtlrNews.loadFailed();
    } on HttpException catch(err) {
      refreshCtlrNews.refreshFailed();
      Get.snackbar('Error', err.message, backgroundColor: EmpColors.red.withOpacity(.5), colorText: Colors.white);
    } catch (e) {
      refreshCtlrNews.refreshFailed();
    }
    if (mounted) setState(() {});
    return true;
  }

  Future fetchOrders() async {
    try {
      page = 1;
      final res = await _employeeService.getInactives(page, limit: limit);
      lastPage = (res.total / limit).ceil();
      if(res.data.length > 0) {
        page++;
        widget.employeeCtrl.inactiveEmployees.value = res.data;
      }
      refreshCtlrNews.refreshToIdle();
    } on SocketException {
      refreshCtlrNews.refreshFailed();
    } on HttpException catch(err) {
      refreshCtlrNews.refreshFailed();
      Get.snackbar('Error', err.message, backgroundColor: EmpColors.red.withOpacity(.5), colorText: Colors.white);
    } catch (e) {
      refreshCtlrNews.refreshFailed();
    }
    if (mounted) setState(() {});
    return true;
  }
}