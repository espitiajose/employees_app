

import 'package:employee_app/models/employee_model.dart';
import 'package:get/get.dart';

class EmployeeController  extends GetxController{

  RxList<EmployeeModel> activeEmployees = <EmployeeModel>[].obs;
  RxList<EmployeeModel> inactiveEmployees = <EmployeeModel>[].obs;


  addActive(EmployeeModel employee) {
    final index = inactiveEmployees.indexWhere((employee) => employee.id == employee.id);
    if(index != -1) inactiveEmployees.removeAt(index);
    activeEmployees.insert(0, employee.copyWith(status: true));
  }

  addInactive(EmployeeModel employee) {
    final index = activeEmployees.indexWhere((employee) => employee.id == employee.id);
    if(index != -1) activeEmployees.removeAt(index);
    inactiveEmployees.insert(0, employee.copyWith(status: false));
  }

  updateActive(EmployeeModel employee) {
    final index = activeEmployees.indexWhere((employee) => employee.id == employee.id);
    if(index != -1) activeEmployees.setAll(index, [employee]);
  }

  setListActive(List<EmployeeModel> employees) {
    activeEmployees.value = employees;
  }

  setListInactive(List<EmployeeModel> employees) {
    inactiveEmployees.value = employees;
  }

}