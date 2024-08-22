import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'features/product/domain/entities/product_entity.dart';
import 'features/product/presentation/bloc/product_bloc.dart';
import 'features/product/presentation/pages/Add_Product/add_product_page.dart';
import 'features/product/presentation/pages/Home_Page/home_page.dart';
import 'features/product/presentation/pages/detailsPage/product_details_page.dart';
import 'features/product/presentation/pages/SearchPage/search_page.dart';
import 'features/product/presentation/pages/Update_Page/update_page.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(
          getProductByIdUsecase: sl(),
          getProductsUsecase: sl(),
          deleteProductUsecase: sl(),
          updateProductUsecase: sl(),
          insertProductUsecase: sl()),
      child: MaterialApp(
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return _createRoute(const HomePage());
            case '/search':
              return _createRoute(SearchPage());
            case '/detail/update':
              final args = settings.arguments as Product;
              return _createRoute(UpDate(
                product: args,
              ));
            case '/add':
              return _createRoute(const ADDPage());

            case '/detail':
              final args = settings.arguments as Product;
              return _createRoute(Detailspage(
                product: args,
              ));
            default:
              return null;
          }
        },
        initialRoute: '/',
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          primaryColor: const Color.fromARGB(255, 63, 81, 243),
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 63, 81, 243)),
          useMaterial3: true,
        ),
        // home: const HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

PageRouteBuilder _createRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeIn;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
