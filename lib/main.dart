import 'package:flutter/material.dart';
import 'package:ulkeler/detail_page.dart';
import 'package:ulkeler/home.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(initialRoute: '/', routes: {
      '/': (context) => Home(),
      '/detail': (context) => Detail(),
    });
  }
}
