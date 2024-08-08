import 'package:flutter/material.dart';

import 'features/product/Presentation/pages/home.dart';
import 'features/product/Presentation/pages/product_add.dart';
import 'features/product/Presentation/pages/product_details.dart';
import 'features/product/Presentation/pages/product_search.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/add': (context) => const AddPage(),
        '/search': (context) => const SearchPage(),
        '/details': (context) => const DetailsPage(),
      },
    );
  }
}
