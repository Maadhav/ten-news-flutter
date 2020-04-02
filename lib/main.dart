import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'Screens/headlines.dart';
import 'Screens/about.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
        textTheme: TextTheme(
          body1: TextStyle(fontFamily: 'Nunito'),
          title: TextStyle(fontFamily: 'Nunito'),
          body2: TextStyle(fontFamily: 'Nunito'),
          button: TextStyle(fontFamily: 'Nunito'),
          caption: TextStyle(fontFamily: 'Nunito'),
          display1: TextStyle(fontFamily: 'Nunito'),
          display2: TextStyle(fontFamily: 'Nunito'),
          display3: TextStyle(fontFamily: 'Nunito'),
          display4: TextStyle(fontFamily: 'Nunito'),
          headline: TextStyle(fontFamily: 'Nunito'),
          overline: TextStyle(fontFamily: 'Nunito'),
          subhead: TextStyle(fontFamily: 'Nunito'),
          subtitle: TextStyle(fontFamily: 'Nunito'),
        ),
        backgroundColor: Colors.white,
        canvasColor: Colors.grey[100],
        accentColor: Colors.white,
        primaryColor: Colors.white
      ),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        "/headlines": (BuildContext context) => Headlines(),
        "/about": (BuildContext context) => About(),
      },
    );
  }
}