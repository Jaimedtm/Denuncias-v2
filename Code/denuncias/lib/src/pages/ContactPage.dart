import 'package:denuncias/src/custom/CustomFlatButton.dart';
import 'package:denuncias/src/util/ColorList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ContactPage extends StatefulWidget {
  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

  String nombre = "";
  String apellidos = "";
  String email = "";
  String numero = "";

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Datos de Contacto',
          style: TextStyle(
              color: textColor, fontSize: 25, fontWeight: FontWeight.w300),
        ),
        backgroundColor: appbarColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
            child: Column(
              
          children: <Widget>[

            Padding(
              padding: const EdgeInsets.only(top:5),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nombre',
                ),
                onChanged: (name) {
                  setState(() {
                    nombre = name;
                  });
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top:20),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Apellidos',
                ),
                onChanged: (txt) {
                  setState(() {
                    apellidos = txt;
                  });
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top:20),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'E-Mail',
                ),
                onChanged: (txt) {
                  setState(() {
                    email = txt;
                  });
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top:20),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Número de telefono',
                ),
                onChanged: (txt) {
                  setState(() {
                    numero = txt;
                  });
                },
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height-500,),

            Container(
              //color: Colors.red,
              child: SizedBox(
                height: 60,
                width: double.infinity,
                child: CustomFlatButton(
                  onPress: (){
                    Navigator.of(context).pop();
                  },
                  text: 'Crear denuncia',
                  fontSize: 25,
                  color: 4,),
              ),
            )

          ],
        )),
      ),
    );
  }
}
