import 'package:employee_app/helpers/dropdownController.dart';
import 'package:employee_app/styles/empColors.dart';
import 'package:employee_app/ui/shared/shared.dart';
import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {

  final String? label;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final TextStyle? fontStyle;
  final String? placeholder;
  final DropDownController controlller;
  final String? Function(String?)? validator;
  final bool isTextValidator;

  const DropDown({
    Key? key,
    required this.controlller,
    this.label,
    this.padding,
    this.margin,
    this.fontStyle,
    this.placeholder,
    this.validator,
    this.isTextValidator = true
  }) : super(key: key);

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {


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
        Container(
          constraints: BoxConstraints(minWidth: 100),
          child: DropdownButtonFormField<String>(
            validator: (value){
              if(this.widget.validator != null) {
                setState(() {isError = this.widget.validator!(value) != null;});
                return this.widget.validator!(value);
              }
            },
            decoration: InputDecoration(
              border: border,
              enabledBorder: border,
              focusedBorder: border,
              contentPadding: this.widget.padding ?? EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              errorStyle: Theme.of(context).textTheme.overline?.copyWith(color: Theme.of(context).errorColor, fontWeight: FontWeight.w500),
            ),
            value: widget.controlller.value,
            hint: _Item(text: widget.placeholder ?? 'Seleccione aquí', isHint: true),
            icon: Icon(Icons.keyboard_arrow_down, size: 8, color: Theme.of(context).primaryColorDark),
            iconEnabledColor: Theme.of(context).primaryColor,
            iconSize: 30,
            isExpanded: true,
            onChanged: (value) => setState(() {FocusScope.of(context).requestFocus(new FocusNode()); widget.controlller.value = value;}),
            dropdownColor: Colors.white,
            items: dropItems,
          ),
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> get dropItems {
    return widget.controlller.items.transform.map((e) => DropdownMenuItem<String>(
      value: e['key'].toString(),
      child: _Item(text: '${e['value']}'),
    )).toList();
  }

  OutlineInputBorder get border {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      borderSide: BorderSide(width: 1, color: isError ? Theme.of(context).errorColor : EmpColors.graySide)
    );
  }
}

class _Item extends StatelessWidget {

  final String text;
  final bool isHint;

  const _Item({
    Key? key,
    required this.text,
    this.isHint = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Label(
      text: this.text,
      heigth: 15,
      style: Theme.of(context).textTheme.bodyText2?.copyWith(color: this.isHint ? Colors.blueGrey : Colors.black),
      align: TextAlign.right,
      overflow: TextOverflow.clip,
    );
  }
}