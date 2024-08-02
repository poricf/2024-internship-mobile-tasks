import 'package:flutter/material.dart';
import 'home.dart';
import 'add_product.dart';
import 'search.dart';
import 'details.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/add': (context) => AddPage(),
        '/search': (context) => SearchPage(),
        '/details': (context) => DetailsPage(),
      },
    );
  }
}
