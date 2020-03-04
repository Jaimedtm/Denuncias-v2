import 'package:denuncias/src/util/ColorList.dart';
import 'package:denuncias/src/util/Text.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatefulWidget {

  final Function onCancell;
  final Function onAcept;

  CustomAlertDialog({@required this.onAcept,@required this.onCancell});

  @override
  _CustomAlertDialogState createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {

  bool textIsReaded=false;

  @override
  Widget build(BuildContext context) {

    ScrollController controller = new ScrollController();

    Function listener = () {
      final double max = controller.position.maxScrollExtent;
      if (controller.offset >= max) {
        setState(() {
          textIsReaded=true;
        });
      }
    };

    Function aceptar = () {
      Navigator.of(context).pop();
      widget.onAcept();
      setState(() {});
    };

    Function cancelar = () {
      Navigator.of(context).pop();
      widget.onCancell();
      setState(() {});
    };

    controller.addListener(listener);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: Color.fromARGB(
        166,
        222,
        218,
        218,
      ),
      title: Center(
          child: Text('Aviso de privacidad',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.w300))),
      content: SizedBox(
        height: 200,
        child: SingleChildScrollView(
          controller: controller,
          child: Text(
            lorem,
            style: TextStyle(color: textColor, fontSize: 17),
            textAlign: TextAlign.justify,
          ),
        ),
      ),

      actions: <Widget>[
              FlatButton(
                child: Text(
                  'Cancelar',
                  style: TextStyle(color: textIsReaded ? textColor : backgroundColor, fontWeight: FontWeight.w300,fontSize: 20),
                  ),
                  color: Color(0xbFA6252B),

                onPressed: textIsReaded? cancelar:null,
              ),

              FlatButton(
                child: Text(
                  'Aceptar',
                  style: TextStyle(color: textIsReaded ? textColor : backgroundColor,fontWeight: FontWeight.w300,fontSize: 20),
                  ),
                  color: Color(0xBF81B015),

                onPressed: textIsReaded? aceptar:null,
              ),

              SizedBox(height: 10,)
            ],
    );
  }
}
