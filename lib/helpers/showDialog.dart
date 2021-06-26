import 'package:employee_app/ui/shared/shared.dart';
import 'package:flutter/material.dart';

class ShowDialog {

  static basicDialog({
    required BuildContext context,
    String? title,
    Widget? widget,
    Widget? image,
    TextAlign? titleAlign,
    TextStyle? textStyleTitle,
    bool buttonBack = true,
    bool buttonClose = true,
    bool dismissible = true,
    bool fullSize = false,
    Duration? duration,
    EdgeInsetsGeometry contentPadding = const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0)
  }) {

    if(duration != null) {
      Future.delayed(duration, (){
        Navigator.pop(context);
      });
    }

    showDialog(
      context: context,
      useRootNavigator: false,
      barrierDismissible: dismissible,
      builder: (context) => AlertDialog(
        insetPadding: fullSize ? EdgeInsets.symmetric(horizontal: 10) : EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
        contentPadding: contentPadding,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all( Radius.circular(20.0))),
        content: Builder(
          builder: (context) {
            return Container(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      Positioned(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: image ?? SizedBox()
                        )
                      ),
                      Positioned(
                        right: 5,
                        child: IconButton(
                          icon: Icon(Icons.close, color: Theme.of(context).primaryColorDark, size: 34),
                          onPressed: () => Navigator.pop(context),
                          splashRadius: 15,
                        ),
                      )
                    ],
                  ),
                  title == null ? SizedBox() :
                  Label(
                    text: title,
                    margin: EdgeInsets.only(top: 20),
                    style: textStyleTitle ?? Theme.of(context).textTheme.subtitle2,
                    align: titleAlign ?? TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                  ),
                  widget != null ?
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: widget,
                  ) : SizedBox(),
                  buttonBack ?
                  Button(
                    text: 'Cerrar',
                    outline: true,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    textStyle: Theme.of(context).textTheme.button?.copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                    onPressed: () => Navigator.pop(context),
                  )
                  : SizedBox(),
                ],
              ),
            );
          }
        )
      ),
    );
  }

  static bottomDialog(BuildContext context, Widget widget) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      elevation: 2.0,
      isDismissible: true,
      useRootNavigator: false,
      backgroundColor: Colors.white,
      enableDrag: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)), 
      ),
      builder: (builder){
        return StatefulBuilder(builder: (context,state){
          return Container(
            padding: EdgeInsets.only(top: 10),
            constraints: BoxConstraints(
              minHeight: 150.0,
              maxHeight: MediaQuery.of(context).size.height * 0.9
            ),
            child: SingleChildScrollView( 
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 50.0,
                    height: 5.0,
                    margin: EdgeInsets.only(bottom: 10.0, top: 5),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                  widget,
                ],
              ),
            ),
          );
        });
      }
    );
  }
}
