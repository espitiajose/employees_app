// ignore: implementation_imports
import 'package:flutter/src/widgets/editable_text.dart';

class PhoneEditingController extends TextEditingController {
  
  late int? phoneCode;
  late String? _phone;

  PhoneEditingController({this.phoneCode = 51, String? phone}){
    if(phone != null) _phone = phone;
  }

  String get phone {
    return this.text == '' ? this.text : '$phoneCode${this.text}';
  }

  set phone(String? value){
    _phone = value;
    if(_phone != null) {
      this.phoneCode = int.parse(_phone!.substring(0, 2));
      this.text = _phone!.substring(2, _phone!.length);
    }
  }
}