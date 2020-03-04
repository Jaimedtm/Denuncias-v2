import 'package:denuncias/src/custom/CustomFlatButton.dart';
import 'package:denuncias/src/util/ColorList.dart';
import 'package:denuncias/src/util/Text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/*
  * TODO:
  * 
  * 
  */

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        //*Hace falta un icono para el appBar

        title: new FractionallySizedBox(
          widthFactor: 0.4,
          child: Image.asset(
            'Res/appbar.png',
            fit: BoxFit.fill,
          ),
        ),

        actions: <Widget>[
          IconButton(
            onPressed: () => _us(context),
            icon: Icon(Icons.info),
            color: textColor,
          )
        ],

        backgroundColor: appbarColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: new Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: <Widget>[
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: CustomFlatButton(
                  color: 1,
                  text: 'Denunciar',
                  fontSize: 50,
                  onPress: () {
                    Navigator.pushNamed(context, 'Action');
                  },
                ),
              ),
            ),
            Expanded(flex: 1, child: Container()),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 20),
                child: CustomFlatButton(
                  color: 2,
                  text: 'Buscar Denuncia',
                  fontSize: 25,
                  onPress: () {
                    _search(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: backgroundColor,
    );
  }

  void _us(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            backgroundColor: Color.fromARGB(
              166,
              222,
              218,
              218,
            ),
            title: Center(
                child: SizedBox(
                    width: 200,
                    child: Image.asset(
                      'Res/appbar.png',
                      fit: BoxFit.fill,
                    ))),
            content: SizedBox(
              height: 200,
              child: SingleChildScrollView(
                child: Text(
                  nosotros,
                  style: TextStyle(color: textColor, fontSize: 17),
                ),
              ),
            ),
          );
        });
  }

  void _search(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
              height: 200,
              child: Center(
                child: SizedBox(
                  height: 30,
                  child: Placeholder(color: Colors.white),
                ),
              ),
            ),
            actions: <Widget>[
              Center(
                child: FlatButton(
                    color: greenButton,
                    onPressed: () {},
                    child: Text('Buscar',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w300))),
              ),
              SizedBox(width: MediaQuery.of(context).size.width-100,)
            ],
          );
        });
  }
}
