import 'package:denuncias/src/pages/ActionPage.dart';
import 'package:denuncias/src/pages/ContactPage.dart';
import 'package:denuncias/src/pages/HomePage.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getRoutes(){

  return <String, WidgetBuilder> {

    '/'         : (BuildContext context) => HomePage(),
    'Action'    : (BuildContext context) => ActionPage(),
    'Contact'    : (BuildContext context) => ContactPage(),

  };
}