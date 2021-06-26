import 'package:employee_app/styles/empSharedStyles.dart';
import 'package:employee_app/ui/shared/shared.dart';
import 'package:flutter/material.dart';

class Button extends StatefulWidget {

  final String text;
  final Function()? onPressed;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final bool outline;
  final double width;
  final double? heigth;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? textStyle;
  final bool loading;
  final FocusNode? focusNode;
  final BoxConstraints? constraints;


  const Button({
    Key? key,
    required this.text,
    required this.onPressed,
    this.outline = false,
    this.padding,
    this.margin,
    this.color,
    this.width = double.infinity,
    this.heigth,
    this.prefixIcon,
    this.suffixIcon,
    this.textStyle,
    this.loading = false,
    this.focusNode,
    this.constraints,
  }) : super(key: key); 

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> with TickerProviderStateMixin{


  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat();

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.ease,
  );

  @override
  Widget build(BuildContext context) {
    
    return Container(
      width: this.widget.width,
      height: widget.heigth,
      margin: this.widget.margin,
      decoration: !widget.outline && widget.color == null ? EmpSharedStyles.gradientDecoration2.copyWith(borderRadius: new BorderRadius.all(Radius.circular(10))) : null,
      child: ElevatedButton(  
        focusNode: widget.focusNode,    
        style: ElevatedButton.styleFrom(
          elevation: widget.outline ? 0 : 1,        
          primary: !widget.outline ? this.widget.color ?? Colors.transparent : Colors.transparent,
          padding: this.widget.padding ?? EdgeInsets.symmetric(vertical: 18),
          side:  this.widget.outline ? BorderSide(color: this.widget.color ?? Theme.of(context).primaryColor, width: 2) : null,
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.all(Radius.circular(10)),
          ),          
        ),      
        onPressed: widget.loading ? null : this.widget.onPressed,
        child: Stack(
          alignment: AlignmentDirectional.centerStart,
          children: [
            this.widget.prefixIcon != null ? Padding(padding: EdgeInsets.only(left: 10), child: this.widget.prefixIcon) : SizedBox(),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                !widget.loading ? SizedBox() :
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: RotationTransition(
                    turns: _animation,
                    child: Icon(Icons.refresh, size: 20, color: Colors.white),
                  ),
                ),
                  Label(
                    text: this.widget.text,
                    constraints: widget.constraints,
                    style: this.widget.textStyle ?? Theme.of(context).textTheme.button,
                    margin: EdgeInsets.symmetric(vertical: 3),
                    align: TextAlign.center,
                  ),
                ],
              ),
            ),
            this.widget.suffixIcon != null ? Positioned(
              right: 10,
              child: this.widget.suffixIcon!
            ) : SizedBox(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() { 
    _controller.dispose();
    super.dispose();
  }
}