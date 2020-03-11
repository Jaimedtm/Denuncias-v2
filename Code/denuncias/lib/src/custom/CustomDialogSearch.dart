import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:denuncias/src/util/ColorList.dart';
import 'package:flutter/material.dart';

class CustomDialogSearch extends StatefulWidget {
  CustomDialogSearch({Key key}) : super(key: key);

  @override
  _CustomDialogSearchState createState() => _CustomDialogSearchState();
}

class _CustomDialogSearchState extends State<CustomDialogSearch> {
  TextEditingController _controller = TextEditingController();
  String idText;
  String status = '';
  bool validID = false;
  bool startToSearch = false;

  @override
  void initState() {
    idText = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !startToSearch ? _inputView() : _findView();
  }

  Widget _inputView() {
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
              onChanged: (fieldTetx) {
                if (fieldTetx.length == 9) {
                  validID = true;
                  setState(() {});
                } else if (fieldTetx.length == 8) {
                  setState(() {
                    validID = false;
                  });
                }
              },
              controller: _controller,
              autocorrect: false,
              autofocus: true,
              cursorColor: textColor,
              textAlign: TextAlign.center,
              maxLength: 9,
              maxLines: 1,
              textCapitalization: TextCapitalization.characters,
              style: TextStyle(
                  color: textColor, fontSize: 20, fontWeight: FontWeight.w300),
              decoration: InputDecoration(
                labelText: 'ID',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: textColor,
                  width: 2,
                )),
                labelStyle: TextStyle(
                    color: textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ),
      ),
      actions: <Widget>[
        Center(
          child: FlatButton(
              color: Color(0xBF81B015),
              onPressed: validID
                  ? () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      idText = _controller.text;
                      startToSearch = true;

                      setState(() {});
                    }
                  : null,
              child: Text('Buscar',
                  style: TextStyle(
                      fontSize: 20,
                      color: validID ? textColor : backgroundColor,
                      fontWeight: FontWeight.w300))),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width -
              MediaQuery.of(context).size.width * 0.1,
        )
      ],
    );
  }

  Widget _findView() {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: Color.fromARGB(
        166,
        222,
        218,
        218,
      ),
      title: Center(
          child: Text('Resultado',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.w400))),
      content: FutureBuilder(
        future: Firestore.instance
            .collection('denuncia_anonima')
            .where('id', isEqualTo: idText)
            .getDocuments(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.documents.isNotEmpty) {
              status = snapshot.data.documents[0].data.toString();
              status = status.substring(
                  status.lastIndexOf('status') + 8, status.length - 1);
            }
            else status='NO_MATCHES';
            
            if(status=='NO_MATCHES'){
              return _toReturn(
                Text(
                  'Sin resultados',
                  style: TextStyle(
                  fontSize: 25,
                  color: Color(0xFFB40C14),
                  fontWeight: FontWeight.w400)
                )
              );
            }

            else
              return _toReturn(
                Text(
                  status,
                  style: TextStyle(
                  fontSize: 25,
                  color: greenButton,
                  fontWeight: FontWeight.w400))
              );

          }

          else
            return _searchMode();
        },
      ),
    );
  }

  Widget _searchMode() {
    return SizedBox(
      height: 100,
      child: Center(
        child: SizedBox(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(
            backgroundColor: greenButton,
          ),
        ),
      ),
    );
  }

  Widget _toReturn(Widget child){
    return SizedBox(
      height: 100,
      child: Center(
        child: child
      ),
    );
  }
}
