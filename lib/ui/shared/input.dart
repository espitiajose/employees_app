import 'package:employee_app/styles/empColors.dart';
import 'package:employee_app/ui/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Input extends StatefulWidget {

  final String? label;
  final String placeholder;
  final TextInputType type;
  final Icon? prefixIcon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final EdgeInsets? padding;
  final TextStyle? textStyle;
  final OutlineInputBorder? border;
  final Color? fillColor;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final bool enabled;
  final DateTime? firstDate;

  const Input({
    Key? key,
    required this.controller,
    this.label,
    this.placeholder = '',
    this.type = TextInputType.text,
    this.validator,
    this.padding,
    this.textStyle,
    this.prefixIcon,
    this.border,
    this.fillColor,
    this.onTap,
    this.onChanged,
    this.focusNode,
    this.enabled = true,
    this.firstDate
  }) : super(key: key);

  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {

  String value = '';
  bool obscure = false;
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
          keyboardType: this.widget.type,
          obscureText: this.obscure,
          controller: this.widget.controller,
          style: this.widget.textStyle?.copyWith(color: !widget.enabled ? Colors.black26 : null) ?? TextStyle(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: .8, color: !widget.enabled ? Colors.black26 : null),
          decoration: InputDecoration(
            filled: widget.fillColor != null || !widget.enabled,
            fillColor: !widget.enabled ? Colors.black26.withOpacity(.3) : widget.fillColor,
            border: border,
            enabledBorder: border,
            focusedBorder: border,
            suffixIcon: _suffixIcon,
            suffixIconConstraints: BoxConstraints(
              maxWidth: 35,
              maxHeight: 35,
            ),
            prefixIcon: widget.prefixIcon,
            hintText: this.widget.placeholder,
            hintStyle: this.widget.textStyle ?? TextStyle(fontSize: 14, fontWeight: FontWeight.w200, letterSpacing: .8),
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            errorStyle: Theme.of(context).textTheme.overline?.copyWith(color: Theme.of(context).errorColor, fontWeight: FontWeight.w500),
          ),
          validator: (value) {
            if(this.widget.validator != null) {
              setState(() {isError = this.widget.validator!(value) != null;});
              return this.widget.validator!(value);
            }
          },
          onChanged: (value) {
            setState(() {this.value = value;});
            if(widget.onChanged != null) widget.onChanged!(value);
          },
          onTap: () {
            if(widget.type == TextInputType.datetime) return openPickerDate();
            if(widget.onTap != null) widget.onTap!();
          },
          focusNode: widget.focusNode,
        ),
      ],
    );
  }

  @override
  void initState() { 
    super.initState();
    setState(() {obscure = this.widget.type == TextInputType.visiblePassword;});
  }

  Widget? get _suffixIcon {
    if(this.value.isNotEmpty) {
      return TextButton(
        child: Icon(_icon, size: 20, color: EmpColors.graySide),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            )
          )
        ),
        onPressed: () {
          if(this.widget.type == TextInputType.visiblePassword) setState(() {this.obscure = !this.obscure;});
          else if(this.widget.type != TextInputType.visiblePassword) {
            this.widget.controller.clear();
            setState(() {this.value = '';});
            if(widget.onChanged != null) widget.onChanged!('');
          }
        }
      );
    }
    return null;
  }

  IconData get _icon {
    if(this.widget.type == TextInputType.visiblePassword && this.obscure) return Icons.visibility_outlined;
    else if(this.widget.type == TextInputType.visiblePassword && !this.obscure) return Icons.visibility_off_outlined;
    else if(this.widget.type != TextInputType.visiblePassword) return Icons.close;
    else return Icons.close;
  }

  OutlineInputBorder get border {
    return widget.border ?? OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      borderSide: BorderSide(width: 1, color: EmpColors.graySide)
    );
  }

  openPickerDate() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: widget.firstDate ?? DateTime.now().subtract(Duration(days: 365 * 100)),
      lastDate: DateTime.now()
    );
    if(picked != null) widget.controller.text = DateFormat('yyyy-MM-dd').format(picked);
    setState(() {});
  }
}