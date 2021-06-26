import 'package:employee_app/helpers/phoneEditController.dart';
import 'package:employee_app/helpers/showDialog.dart';
import 'package:employee_app/styles/empColors.dart';
import 'package:employee_app/ui/shared/shared.dart';
import 'package:flutter/material.dart';

class InputPhone extends StatefulWidget {

  final String? label;
  final String placeholder;
  final PhoneEditingController controller;
  final String? Function(String?)? validator;
  final EdgeInsets? padding;
  final TextStyle? textStyle;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final OutlineInputBorder? border;
  final bool enabled;

  const InputPhone({
    Key? key,
    this.label,
    required this.controller,
    this.placeholder = '',
    this.validator,
    this.padding,
    this.textStyle,
    this.onChanged,
    this.onTap,
    this.border,
    this.enabled = true
  }) : super(key: key);

  @override
  _InputPhoneState createState() => _InputPhoneState();
}

class _InputPhoneState extends State<InputPhone> {

  String value = '';
  int? phoneCode;
  bool isError = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label == null ? SizedBox() :
        Label(
          text: widget.label!,
          margin:EdgeInsets.symmetric(vertical: 10),
          style: Theme.of(context).textTheme.overline?.copyWith(
            color: !isError ? Colors.black : Theme.of(context).errorColor,
            fontWeight: FontWeight.w300,
          ),
        ),
        TextFormField(
          enabled: widget.enabled,
          autocorrect: false,
          keyboardType: TextInputType.phone,
          controller: this.widget.controller,          
          style: this.widget.textStyle?.copyWith(color: !widget.enabled ? Colors.black26 : null) ?? TextStyle(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: .8, color: !widget.enabled ? Colors.black26 : null),
          decoration: InputDecoration(
            border: border,
            enabledBorder: border,
            focusedBorder: border,
            suffixIcon: _suffixIcon,
            suffixIconConstraints: BoxConstraints(
              maxWidth: 35,
              maxHeight: 35,
            ),
            prefixIcon: _prefixIcon,
            prefixIconConstraints: BoxConstraints(maxWidth: 90),
            hintText: this.widget.placeholder,
            hintStyle: this.widget.textStyle ?? TextStyle(fontSize: 14, fontWeight: FontWeight.w200, letterSpacing: .8, color: Theme.of(context).primaryColorDark),
            contentPadding: EdgeInsets.only(left: 20),
            errorStyle: Theme.of(context).textTheme.overline?.copyWith(color: Theme.of(context).errorColor, fontWeight: FontWeight.w500),
            fillColor: Colors.black26.withOpacity(.3), 
            filled: !widget.enabled
          ),
          validator: (value) {
            if(this.widget.validator != null) {
              setState(() {isError = this.widget.validator!(value) != null;});
              return this.widget.validator!(value);
            }
          },
          onChanged: (value) {
            setState(() {this.value = value;});
            if(widget.onChanged != null) widget.onChanged!(widget.controller.phone);
          },  
          onTap: widget.onTap,   
        ),
      ],
    );
  }

  @override
  void initState() { 
    super.initState();
    setState(() {
      phoneCode = widget.controller.phoneCode;
    });
  }

  Widget? get _suffixIcon {
    if(this.value.isNotEmpty) {
      return TextButton(
        child: Icon(Icons.close, size: 20, color: EmpColors.graySide),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            )
          )
        ),
        onPressed: () {
          this.widget.controller.clear();
          setState(() {this.value = '';});
          if(widget.onChanged != null) widget.onChanged!('');
        }
      );
    }
    return null;
  }

  Widget? get _prefixIcon{
    return GestureDetector(
      onTap: selectCountry,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          border: Border(right: BorderSide(width: 1.2, color: Theme.of(context).primaryColorDark))
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.keyboard_arrow_down, size: 10, color: Colors.black),
            Label(
              text: '+$phoneCode',
              margin: EdgeInsets.symmetric(vertical: 15), 
              style: this.widget.textStyle ?? TextStyle(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: .8, color: Theme.of(context).primaryColorDark)
            ),
          ],
        ),
      ),
    );
  }

  void selectCountry() {
    ShowDialog.basicDialog(
      context: context,
      title: 'Selecciona un país',
      buttonBack: false,
      widget: Column(
        children: [
          Row(
            children: [
              Radio(
                value: 51,
                groupValue: phoneCode,
                onChanged: updateCode,
                visualDensity: VisualDensity.standard,
                materialTapTargetSize: MaterialTapTargetSize.padded,
              ),
              Label(
                text: 'Perú',
                style: this.widget.textStyle ?? TextStyle(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: .8, color: Colors.black)
              )
            ],
          ),
          Row(
            children: [
              Radio(
                value: 57,
                groupValue: phoneCode,
                onChanged: updateCode,
                visualDensity: VisualDensity.standard,
                materialTapTargetSize: MaterialTapTargetSize.padded,
              ),
              Label(
                text: 'Colombia',
                style: this.widget.textStyle ?? TextStyle(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: .8, color: Colors.black)
              )
            ],
          ),
          Row(
            children: [
              Radio(
                value: 1,
                groupValue: phoneCode,
                onChanged: updateCode,
                visualDensity: VisualDensity.standard,
                materialTapTargetSize: MaterialTapTargetSize.padded,
              ),
              Label(
                text: 'USA',
                style: this.widget.textStyle ?? TextStyle(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: .8, color: Colors.black)
              )
            ],
          )
        ],
      )
    );
  }

  void updateCode(int? value) {
    widget.controller.phoneCode = value;
    phoneCode = value;
    Navigator.pop(context);
    setState(() {});
  }

  OutlineInputBorder get border {
    return widget.border ?? OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      borderSide: BorderSide(width: 1, color: EmpColors.graySide)
    );
  }
}