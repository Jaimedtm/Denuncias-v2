import 'package:cloud_functions/cloud_functions.dart';
import 'package:denuncias/src/custom/CustomAlertDialog.dart';
import 'package:denuncias/src/custom/CustomDialogSend.dart';
import 'package:denuncias/src/custom/CustomFlatButton.dart';
import 'package:denuncias/src/util/ColorList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//import 'package:encrypt/encrypt.dart' as enc;

class TestPage extends StatefulWidget {
  TestPage({Key key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  TextEditingController textController = TextEditingController();
  String generatedID;
  bool contactar = false;
  String textFieldData = "";
  Size screenSize;
  bool isFocused = false;
  FocusNode focusNode = FocusNode();

  HttpsCallable callable = CloudFunctions.instance
      .getHttpsCallable(functionName: 'testFuction')
        ..timeout = const Duration(seconds: 30);

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          isFocused = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;

    var _onWillPop = () {
      if (isFocused == true) {
        isFocused = false;
        setState(() {});
        FocusScope.of(context).requestFocus(new FocusNode());
        return Future<bool>.value(false);
      } else
        return Future<bool>.value(true);
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Test Page',
          style: TextStyle(
              color: textColor, fontSize: 30, fontWeight: FontWeight.w300),
        ),
        backgroundColor: appbarColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _txtField(_onWillPop),
              _buttonArea(),
              Padding(
                padding: EdgeInsets.only(top: screenSize.height * 0.27),
                child: SizedBox(
                  height: 50,
                  child: Container(
                    child: CustomFlatButton(
                      onPress: () {
                        //añadir else para implementar solo la publicación
                        if (contactar == true)
                          Navigator.pushNamed(context, 'Contact');
                        else {
                          //TODO: create a future builder
                          //final enc.Key ky = enc.Key.fromLength(32);
                          //final enc.IV iv = enc.IV.fromLength(8);
                          //final enc.Encrypter encrypter = enc.Encrypter(enc.Salsa20(ky));

                          //print(encrypter.encrypt('Taquitos',iv: iv).toString());

                          //_testfire2();

                          _createComplaint(context);

                          setState(() {
                            textController.clear();
                          });
                        }
                      },
                      text: !contactar
                          ? 'Crear denuncia'
                          : 'Añadir datos de contacto',
                      fontSize: !contactar ? null : 25,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      backgroundColor: backgroundColor,
    );
  }

  Widget _txtField(Future<bool> Function() f) {
    return WillPopScope(
      onWillPop: f,
      child: SizedBox(
        height: screenSize.height * 0.4,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: TextField(
            controller: textController,
            focusNode: focusNode,
            autocorrect: true,
            keyboardType: TextInputType.multiline,
            cursorColor: textColor,
            decoration: InputDecoration(
              alignLabelWithHint: true,
              labelText: 'Datos de denuncia',
              labelStyle: TextStyle(
                color: isFocused ? Colors.lightBlueAccent : Colors.white60,
                fontSize: 25,
                fontWeight: FontWeight.w300,
                decoration: (isFocused || (textFieldData.isNotEmpty))
                    ? null
                    : TextDecoration.underline,
              ),
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: textColor, width: 2.5)),
            ),
            style: TextStyle(
                color: textColor, fontSize: 20, fontWeight: FontWeight.w300),
            textAlign: TextAlign.justify,
            textAlignVertical: TextAlignVertical.top,
            textCapitalization: TextCapitalization.sentences,
            minLines: null,
            maxLines: null,
            expands: true,
            onChanged: (value) {
              textFieldData = value;
            },
          ),
        ),
      ),
    );
  }

  Widget _buttonArea() {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: SizedBox(
        height: screenSize.height * 0.1,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(5, 25, 5, 25),
                child: CustomFlatButton(
                  onPress: () {},
                  text: 'Adjuntar archivo',
                  fontSize: 17,
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 5, bottom: 0),
                      child: Text(
                        '¿Desea ser contactado?',
                        style: TextStyle(color: textColor),
                      ),
                    ),
                    Container(
                      child: Switch(
                        value: contactar,
                        onChanged: (value) {
                          setState(() {
                            contactar = value;
                            if (contactar == true) _alerta(context);
                          });
                        },
                        inactiveThumbColor: textColor,
                        inactiveTrackColor: Colors.white38,
                        activeTrackColor: Colors.white38,
                        activeColor: greenButton,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _alerta(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return WillPopScope(
            onWillPop: _onCall,
            child: CustomAlertDialog(
              onAcept: () {
                setState(() {
                  contactar = true;
                });
              },
              onCancell: () {
                setState(() {
                  contactar = false;
                });
              },
            ));
      },
    );
  }

  void _testfire2() async {
    try {
      final HttpsCallableResult result = await callable.call(<String, dynamic>{
        'info': textFieldData,
        'day': DateTime.now().day,
        'month': DateTime.now().month,
        'year': DateTime.now().year,
        'time': getTimeInString(),
      });
      String resp = result.data.toString();
      generatedID = resp.substring(resp.lastIndexOf(':') + 2, resp.length - 1);
      print(generatedID);
      textController.text = generatedID;
      setState(() {});
    } on CloudFunctionsException catch (e) {
      print(e.details.toString());
      print('No se que tranza carnal');
    } catch (e) {
      print('Yo tampoco se que pedo carnal :c');
    }
  }

  String getTimeInString() {
    String minutes = (DateTime.now().minute >= 10)
        ? DateTime.now().minute.toString()
        : "0" + DateTime.now().minute.toString();
    String seconds = (DateTime.now().second >= 10)
        ? DateTime.now().second.toString()
        : "0" + DateTime.now().second.toString();

    return DateTime.now().hour.toString() + ":" + minutes + ':' + seconds;
  }

  void _createComplaint(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return CustomDialogSend(
            barrier: false,
            fadeInAnimation: true,
            title: SizedBox.expand(
              child:Container(
                color: Colors.amber,
                child: Icon(
                Icons.warning,
                color: Colors.white,
                size: 60,
                ),
              )),
          );
        });
  }

  Future<bool> _onCall() {
    contactar = false;
    print('Salio');
    setState(() {});
    return new Future<bool>.value(true);
  }
}
