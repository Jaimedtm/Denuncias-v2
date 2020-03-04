import 'package:denuncias/src/util/ColorList.dart';
import 'package:flutter/material.dart';

class CustomDialogCreate extends StatefulWidget {
  CustomDialogCreate({Key key}) : super(key: key);

  @override
  _CustomDialogCreateState createState() => _CustomDialogCreateState();
}

class _CustomDialogCreateState extends State<CustomDialogCreate> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: Color.fromARGB(
        166,
        222,
        218,
        218,
      ),
      title: Center(
          child: Text('Ingrese ID',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.w400))),
      content: SizedBox(
        height: 100,
        child: Center(
          child: SizedBox(
            height: 40,
            child: TextField(
              autocorrect: false,
              autofocus: true,
              cursorColor: textColor,
              textAlign: TextAlign.center,
              maxLength: 9,
              maxLines: 1,
              
            ),
          ),
        ),
      ),
      actions: <Widget>[
        Center(
          child: FlatButton(
              color: Color(0xBF81B015),
              onPressed: () {},
              child: Text('Buscar',
                  style: TextStyle(
                      fontSize: 20,
                      color: textColor,
                      fontWeight: FontWeight.w300))),
        ),

        SizedBox(
          width: MediaQuery.of(context).size.width - MediaQuery.of(context).size.width*0.1,
        )
      ],
    );

  }
}
