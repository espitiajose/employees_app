import 'dart:io';

import 'package:employee_app/controllers/employee_controller.dart';
import 'package:employee_app/helpers/dropdownController.dart';
import 'package:employee_app/helpers/validators.dart';
import 'package:employee_app/models/employee_model.dart';
import 'package:employee_app/models/enums/area_enum.dart';
import 'package:employee_app/models/enums/country_enum.dart';
import 'package:employee_app/models/enums/documentType_enum.dart';
import 'package:employee_app/services/employee_service.dart';
import 'package:employee_app/styles/empColors.dart';
import 'package:employee_app/ui/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class AddPage extends StatefulWidget {

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

  final _surnameCtrl = TextEditingController();
  final _secondSurnameCtrl = TextEditingController();
  final _fistnameCtrl = TextEditingController();
  final _secondnameCtrl = TextEditingController();
  final _documentCtrl = TextEditingController();
  final _dateOfAdmissionCtrl = TextEditingController();
  final _countryCtrl = DropDownController(items: DropItems(countryEnumValues.toList, keyInput: 'key', valueInput: 'value'));
  final _documentTypeCtrl = DropDownController(items: DropItems(documentsTypeEnumValues.toList, keyInput: 'key', valueInput: 'value'));
  final _areaTypeCtrl = DropDownController(items: DropItems(areaEnumValues.toList, keyInput: 'key', valueInput: 'value'));
  final _formKey = GlobalKey<FormState>();

  final employeeService = EmployeeService();
  final employeeCtrl = Get.find<EmployeeController>();
  EmployeeModel? currentEmployee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(115),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          centerTitle: false,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: Label(
              width: double.infinity,
              text: "${currentEmployee != null ? 'Actualizar': 'Nuevo'} empleado", 
              margin: EdgeInsets.only(left: 10, bottom: 10),
              style: Theme.of(context).textTheme.headline2?.copyWith(
                color: Theme.of(context).primaryColorDark, 
                fontWeight: FontWeight.bold
              )
            ),
          ),
        ),
      ),
      body: Container(
        height: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                DropDown(
                  label: 'Tipo de identificación',
                  controlller: _documentTypeCtrl,
                  margin: EdgeInsets.only(top: 5, bottom: 5, right: 5,),
                  isTextValidator: false,
                  validator: (value) => Validator.validate(value, require: true)
                ),
                Input(
                  label: 'Número de identificación',
                  placeholder: 'Escriba aquí...',
                  type: TextInputType.number,
                  controller: _documentCtrl,
                  validator: (value) => Validator.validate(value, require: true, maxLenth: 20),
                ),
                DropDown(
                  label: 'Area de desempeño',
                  controlller: _areaTypeCtrl,
                  margin: EdgeInsets.only(top: 5, bottom: 5, right: 5),
                  isTextValidator: false,
                  validator: (value) => Validator.validate(value, require: true)
                ),
                Input(
                  label: 'Primer apellido',
                  placeholder: 'Escriba aquí...',
                  type: TextInputType.text,
                  controller: _surnameCtrl,
                  validator: (value) => Validator.validate(value, require: true, maxLenth: 20, accents: false),
                ),
                Input(
                  label: 'Segundo apellido',
                  placeholder: 'Escriba aquí...',
                  type: TextInputType.text,
                  controller: _secondSurnameCtrl,
                  validator: (value) => Validator.validate(value, require: true, maxLenth: 20, accents: false),
                ),
                Input(
                  label: 'Primer nombre',
                  placeholder: 'Escriba aquí...',
                  type: TextInputType.text,
                  controller: _fistnameCtrl,
                  validator: (value) => Validator.validate(value, require: true, maxLenth: 20, accents: false),
                ),
                Input(
                  label: 'Otros nombres',
                  placeholder: 'Escriba aquí...',
                  type: TextInputType.text,
                  controller: _secondnameCtrl,
                  validator: (value) => Validator.validate(value, require: true, maxLenth: 50, accents: false),
                ),
                DropDown(
                  label: 'País de empleo',
                  controlller: _countryCtrl,
                  margin: EdgeInsets.only(top: 5, bottom: 5, right: 5),
                  isTextValidator: false,
                  validator: (value) => Validator.validate(value, require: true)
                ),
                Input(
                  label: 'Fecha de ingreso',
                  placeholder: 'Seleccione aquí...',
                  firstDate: DateTime.now().subtract(Duration(days: 30)),
                  type: TextInputType.datetime,
                  controller: _dateOfAdmissionCtrl,
                  validator: (value) => Validator.validate(value, require: true),
                ),
                Button(
                  text: currentEmployee != null ? 'Actualizar' : 'Guardar', 
                  onPressed: currentEmployee != null ? update : save,
                  margin: EdgeInsets.symmetric(vertical: 20),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() { 
    super.initState();
    if(Get.arguments != null) {
      currentEmployee = EmployeeModel.fromJson(Get.arguments);
      _surnameCtrl.text = currentEmployee!.surname;
      _secondSurnameCtrl.text = currentEmployee!.secondSurname;
      _fistnameCtrl.text = currentEmployee!.firstName;
      _secondnameCtrl.text = currentEmployee!.secondName;
      _documentCtrl.text = currentEmployee!.document;
      _dateOfAdmissionCtrl.text = currentEmployee!.dateOfAdmissionFormatted;
      _countryCtrl.value = countryEnumValues.reverse[currentEmployee!.country];
      _documentTypeCtrl.value = documentsTypeEnumValues.reverse[currentEmployee!.documentType];
      _areaTypeCtrl.value = areaEnumValues.reverse[currentEmployee!.area];
      setState(() {});
    }
  }

  save() async {
    if(_formKey.currentState?.validate() ?? false) {
      EmployeeModel employee = EmployeeModel(
        firstName: _fistnameCtrl.text,
        secondName: _secondnameCtrl.text,
        surname: _surnameCtrl.text,
        secondSurname: _secondSurnameCtrl.text,
        country: countryEnumValues.map[_countryCtrl.value!]?.value,
        documentType: documentsTypeEnumValues.map[_documentTypeCtrl.value!]?.value,
        document: _documentCtrl.text,
        area: areaEnumValues.map[_areaTypeCtrl.value!]?.value,
        dateOfAdmission: DateTime.parse(_dateOfAdmissionCtrl.text).toUtc().millisecondsSinceEpoch
      );
      try {
          EasyLoading.show(status: 'Creando empleando');
          final newEmployee = await employeeService.create(employee);
          if(newEmployee != null) {
            employeeCtrl.addActive(newEmployee);
            Navigator.pop(context);
          }
          Get.snackbar('Registro de empleado', 'Empleado creado exitosamente', backgroundColor: Colors.lightGreen.withOpacity(.5));
      } on SocketException {
        Get.snackbar('Error de conexión', 'Compruebe su conexión a internet y vuelva a intentarlo', backgroundColor: EmpColors.red.withOpacity(.5), duration: Duration(seconds: 1));
      } on HttpException catch (err) {
        Get.snackbar('Error en formulario', err.message, backgroundColor: EmpColors.red.withOpacity(.5), colorText: Colors.white);
      }
      EasyLoading.dismiss();
    }
  }

  update()async{
    currentEmployee = currentEmployee!.copyWith(
      firstName: _fistnameCtrl.text,
      secondName: _secondnameCtrl.text,
      surname: _surnameCtrl.text,
      secondSurname: _secondSurnameCtrl.text,
      country: countryEnumValues.map[_countryCtrl.value!]?.value,
      documentType: documentsTypeEnumValues.map[_documentTypeCtrl.value!]?.value,
      document: _documentCtrl.text,
      area: areaEnumValues.map[_areaTypeCtrl.value!]?.value,
      dateOfAdmission: DateTime.parse(_dateOfAdmissionCtrl.text).toUtc().millisecondsSinceEpoch
    );
    try {
      EasyLoading.show(status: 'Actualizando empleando');
      final newEmployee = await employeeService.update(currentEmployee!);
      if(newEmployee != null) {
        employeeCtrl.updateActive(newEmployee);
        Navigator.pop(context);
      }
      Get.snackbar('Actualización de empleado', 'Empleado creado exitosamente', backgroundColor: Colors.lightGreen.withOpacity(.5));

    } on SocketException {
      Get.snackbar('Error de conexión', 'Compruebe su conexión a internet y vuelva a intentarlo', backgroundColor: EmpColors.red.withOpacity(.5), duration: Duration(seconds: 1));
    } on HttpException catch (err) {
      Get.snackbar('Error en formulario', err.message, backgroundColor: EmpColors.red.withOpacity(.5), colorText: Colors.white);
    }
    EasyLoading.dismiss();
  }
}