import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product_8/features/product/domain/entities/product_entity.dart';
import 'package:product_8/features/product/presentation/bloc/product_bloc.dart';
import 'package:product_8/features/product/presentation/bloc/product_event.dart';
import 'package:product_8/features/product/presentation/bloc/product_state.dart';
import 'package:product_8/features/product/presentation/pages/Home_Page/home_page.dart';

class MockProductBloc extends MockBloc<ProductEvent, ProductState>
    implements ProductBloc {}

void main() {
  late MockProductBloc mockProductBloc;

  setUp(() {
    mockProductBloc = MockProductBloc();
    HttpOverrides.global = null;
  });

  Widget _buildTestableWidget() {
    return BlocProvider<ProductBloc>.value(
      value: mockProductBloc,
      child: const MaterialApp(home: HomePage()),
    );
  }

  testWidgets('Displays loading indicator when ProductLoading state is active',
      (WidgetTester tester) async {
    // Arrange
    when(() => mockProductBloc.state).thenAnswer((_) => ProductLoading());

    // Act
    await tester.pumpWidget(_buildTestableWidget());

    // Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Displays products when ProductLoaded state is active',
      (WidgetTester tester) async {
    // Arrange
    final testProducts = [
      const Product(
          id: '1',
          name: 'Sample Product',
          price: 20.0,
          description: 'Sample description',
          imageUrl: 'https://www.example.com')
    ];
    when(() => mockProductBloc.state)
        .thenReturn(ProductLoaded(products: testProducts));

    // Act
    await tester.pumpWidget(_buildTestableWidget());
    await tester.pumpAndSettle();

    // Assert
    expect(find.text('Available Products'), findsOneWidget);
    expect(find.text('Sample Product'), findsOneWidget);
  });

  testWidgets('Displays error message when ProductError state is active',
      (WidgetTester tester) async {
    // Arrange 
    when(() => mockProductBloc.state).thenReturn(ProductError());

    // Act
    await tester.pumpWidget(_buildTestableWidget());
    await tester.pumpAndSettle();
    

    // Assert
    expect(find.text('Failed to load products'), findsOneWidget);
  });
}
