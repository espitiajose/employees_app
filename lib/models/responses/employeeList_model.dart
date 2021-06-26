// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:employee_app/models/employee_model.dart';

EmployeeListModel employeeListFromJson(String str) => EmployeeListModel.fromJson(json.decode(str));

String employeeListToJson(EmployeeListModel data) => json.encode(data.toJson());

class EmployeeListModel {
    EmployeeListModel({
      required this.total,
      required this.data,
    });

    final int total;
    final List<EmployeeModel> data;

    factory EmployeeListModel.fromJson(Map<String, dynamic> json) => EmployeeListModel(
        total: json["total"],
        data: List<EmployeeModel>.from(json["data"].map((x) => EmployeeModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}