import 'package:denuncias/src/custom/CustomAlertDialog.dart';
import 'package:denuncias/src/custom/CustomFlatButton.dart';
import 'package:denuncias/src/util/ColorList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ActionPage extends StatefulWidget {
  @override
  State<ActionPage> createState() => _ActionPageState();
}

class _ActionPageState extends State<ActionPage> {
  bool contactar;

  @override
  void initState() {
    contactar = false;

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
  }

  @override
  void dispose() {
    //contactar=false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          'Denunciar',
          style: TextStyle(
              color: textColor, fontSize: 30, fontWeight: FontWeight.w300),
        ),
        backgroundColor: appbarColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
                flex: 6,
                child: Placeholder(
                  color: Colors.white,
                )),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                        flex: 4,
                        child: CustomFlatButton(
                          onPress: () {},
                          text: 'Añadir archivo',
                          fontSize: 20,
                        )),
                    Spacer(
                      flex: 1,
                    ),
                    Expanded(
                        flex: 2,
                        child: Container(
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                  child: Text(
                                '¿Deseas ser contactado?',
                                style: TextStyle(color: textColor),
                              )),
                              Center(
                                child: Switch(
                                  value: contactar,
                                  onChanged: (value) {
                                    setState(() {
                                      contactar = value;
                                      if (contactar == true) alerta(context);
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
                        ))
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: CustomFlatButton(
                    fontSize: !contactar ? null : 25,
                    color: 0,
                    onPress: () {
                      //añadir else para implementar solo la publicación
                      if (contactar == true)
                        Navigator.pushNamed(context, 'Contact');
                    },
                    text: !contactar
                        ? 'Crear denuncia'
                        : 'Añadir datos de contacto',
                  )),
            ),
          ],
        ),
      ),
      backgroundColor: backgroundColor,
    );
  }

  void alerta(BuildContext context) {
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

  Future<bool> _onCall() {
    contactar = false;
    print('Salio');
    setState(() {});
    return new Future<bool>.value(true);
  }
}
