import 'package:denuncias/src/routes/Routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main(List<String> args) {

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    )
    );

  runApp(new MaterialApp(

    title: 'Denuncias',
    debugShowCheckedModeBanner: true,
    initialRoute: '/',
    routes: getRoutes(),
  )
  );
}