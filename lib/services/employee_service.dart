import 'dart:convert';
import 'dart:io';

import 'package:employee_app/config/enviroment.dart';
import 'package:employee_app/helpers/empHttp.dart';
import 'package:employee_app/models/employee_model.dart';
import 'package:employee_app/models/errors_model.dart';
import 'package:employee_app/models/responses/employeeList_model.dart';

class EmployeeService  extends EmpHttp {

  Future<EmployeeListModel> getActives(int start, {int limit = 8}) async {
    final res = await this.get('${Enviroment.apiUrl}/employee/list?start=$start&limit=$limit');
    if(res.statusCode == 200) {
      return employeeListFromJson(res.body);
    } else throw HttpException('Ha ocurrido un error');
  }

  Future<EmployeeListModel> getInactives(int start, {int limit = 8}) async {
    final res = await this.get('${Enviroment.apiUrl}/employee/list/inactives?start=$start&limit=$limit');
    if(res.statusCode == 200) {
      return employeeListFromJson(res.body);
    } else throw HttpException('Ha ocurrido un error');
  }

  Future<EmployeeModel?> create(EmployeeModel employee) async {
    final res = await this.post('${Enviroment.apiUrl}/employee/create', employee.toRegisterJson());
    if(res.statusCode == 201) {
      return EmployeeModel.fromJson(jsonDecode(res.body)['data']);
    } else throw HttpException(errorsFromJson(res.body).errors[0].msg);
  }

  Future<EmployeeModel?> update(EmployeeModel employee) async {
    final res = await this.put('${Enviroment.apiUrl}/employee/update/${employee.id}', employee.toJson());
    if(res.statusCode == 200) {
      return EmployeeModel.fromJson(jsonDecode(res.body)['data']);
    } else throw HttpException(errorsFromJson(res.body).errors[0].msg);
  }

  Future<bool> inactive(EmployeeModel employee) async {
    final res = await this.delete('${Enviroment.apiUrl}/employee/${employee.id}');
    return res.statusCode == 200;
  }

  Future<bool> active(EmployeeModel employee) async {
    final res = await this.put('${Enviroment.apiUrl}/employee/${employee.id}', {"status": true});
    return res.statusCode == 200;
  }

}