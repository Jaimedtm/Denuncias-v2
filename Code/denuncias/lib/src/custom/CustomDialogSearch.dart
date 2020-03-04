import 'package:denuncias/src/util/ColorList.dart';
import 'package:flutter/material.dart';

class CustomDialogSearch extends StatefulWidget {
  CustomDialogSearch({Key key}) : super(key: key);

  @override
  _CustomDialogSearchState createState() => _CustomDialogSearchState();
}

class _CustomDialogSearchState extends State<CustomDialogSearch> {

  String idText;
  bool validID=false;

  @override
  void initState() {
    idText="";
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
            height: 80,
            child: TextField(
              onChanged: (fieldTetx){
                if(fieldTetx.length==9){
                    validID=true;
                    setState(() {
                      
                    });
                  }
                
                else if(fieldTetx.length==8){

                  setState(() {
                    validID=false;
                  });
                  
                }
              },
              autocorrect: false,
              autofocus: true,
              cursorColor: textColor,
              textAlign: TextAlign.center,
              maxLength: 9,
              maxLines: 1,
              textCapitalization: TextCapitalization.characters,
              style: TextStyle(color:textColor, fontSize: 20, fontWeight: FontWeight.w300),
              decoration: InputDecoration(
                labelText: 'ID',
                border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: textColor,width: 2,)
                ),
              labelStyle: TextStyle(color:textColor, fontSize: 20, fontWeight: FontWeight.w300),
              ),


            ),
          ),
        ),
      ),
      actions: <Widget>[
        Center(
          child: FlatButton(
              color: Color(0xBF81B015),
              onPressed: validID ? () {}:null,
              child: Text('Buscar',
                  style: TextStyle(
                      fontSize: 20,
                      color: validID ? textColor:backgroundColor,
                      fontWeight: FontWeight.w300))),
        ),

        SizedBox(
          width: MediaQuery.of(context).size.width - MediaQuery.of(context).size.width*0.1,
        )
      ],
    );

  }
}