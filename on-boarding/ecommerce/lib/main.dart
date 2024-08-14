import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/product/Presentation/bloc/product_bloc.dart';
import 'features/product/Presentation/pages/home.dart';
import 'features/product/Presentation/pages/product_add.dart';
import 'features/product/Presentation/pages/product_details.dart';
import 'features/product/Presentation/pages/product_search.dart';
import 'injection_container.dart' as inj;

void main() {
  inj.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => inj.sl<ProductBloc>(),
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          '/add': (context) => const AddPage(),
          '/search': (context) => const SearchPage(),
          '/details': (context) => const DetailsPage(),
        },
      ),
    );
  }
}
