import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/errors/falilures.dart';
import 'package:ecommerce/features/product/Domain/entities/product.dart';
import 'package:ecommerce/features/product/Domain/usecases/product_usecase.dart';
import 'package:ecommerce/features/product/Presentation/bloc/product_bloc.dart';
import 'package:ecommerce/features/product/Presentation/bloc/product_event.dart';
import 'package:ecommerce/features/product/Presentation/bloc/product_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late MockProductUsecase mockProductUsecase;
  late ProductBloc productBloc;

  setUp(() {
    mockProductUsecase = MockProductUsecase();
    productBloc = ProductBloc(productUsecases: mockProductUsecase);
  });

  test('test the inital state ', () {
    expect(productBloc.state, InitialState());
  });

  const Product product = Product(
    productid: '1',
    name: 'Test Product',
    description: 'This is a test product',
    price: 10.0,
    imageUrl: 'test_image.jpg',
  );

  const List<Product> listProduct = [
    Product(
        productid: '1',
        name: 'Test Product',
        description: 'This is a test product',
        price: 10.0,
        imageUrl: 'gg'),
    Product(
        productid: '1',
        name: 'test',
        description: 'test',
        price: 10.0,
        imageUrl: 'gg')
  ];

  group('test each state', () {
    blocTest<ProductBloc, ProductState>(
      'emits [get single product event] when getProduct is added.',
      build: () {
        when(
          mockProductUsecase.getProduct(any),
        ).thenAnswer((_) async => const Right(product));

        return productBloc;
      },
      act: (bloc) => bloc.add(const GetSingleProductEvent(productid: '1')),
      expect: () =>
          [LoadingState(), const LoadedSingleProductState(product: product)],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [MyState] when get product by id return failure.',
      build: () {
        when(mockProductUsecase.dataById(any)).thenAnswer((_) async =>
            const Left(ConnectionFailure('try again', message: 'Hello')));
        return productBloc;
      },
      act: (bloc) => bloc.add(const GetSingleProductEvent(productid: '1')),
      expect: () => [
        LoadingState(),
        const ErrorState(messages: 'try again'),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [MyState] when get all product return  success fully.',
      build: () {
        when(mockProductUsecase.dataForAll())
            .thenAnswer((_) async => const Right(listProduct));
        return productBloc;
      },
      act: (bloc) => bloc.add(const LoadAllProductsEvent()),
      expect: () => [
        LoadingState(),
        const LoadedAllProductsState(products: listProduct),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [MyState] when get  all product must return failure.',
      build: () {
        when(mockProductUsecase.dataForAll()).thenAnswer((_) async =>
            const Left(ConnectionFailure('try again', message: 'Hello')));
        return productBloc;
      },
      act: (bloc) => bloc.add(const LoadAllProductsEvent()),
      expect: () => [
        LoadingState(),
        const ErrorState(messages: 'try again'),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [MyState] when add new  product return  success fully.',
      build: () {
        when(mockProductUsecase.addProduct(any))
            .thenAnswer((_) async => const Right(true));
        return productBloc;
      },
      act: (bloc) => bloc.add(const CreateProductEvent(product: product)),
      expect: () => [
        LoadingState(),
        const SuccessfulAdditionState(added: true),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [MyState] when add new product must return failure.',
      build: () {
        when(mockProductUsecase.addProduct(any)).thenAnswer((_) async =>
            const Left(ConnectionFailure('try again', message: 'Hello')));
        return productBloc;
      },
      act: (bloc) => bloc.add(const CreateProductEvent(product: product)),
      expect: () => [
        LoadingState(),
        const ErrorState(messages: 'try again'),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [MyState] when delete  a product must return  success.',
      build: () {
        when(mockProductUsecase.deleteProduct(any))
            .thenAnswer((_) async => const Right(true));
        return productBloc;
      },
      act: (bloc) => bloc.add(const DeleteProductEvent(productid: '1')),
      expect: () => [
        LoadingState(),
        const SuccessfulDeletionState(deleted: true),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [MyState] when delete  a product must return failure.',
      build: () {
        when(mockProductUsecase.deleteProduct(any)).thenAnswer((_) async =>
            const Left(ConnectionFailure('try again', message: 'Hello')));
        return productBloc;
      },
      act: (bloc) => bloc.add(const DeleteProductEvent(productid: '1')),
      expect: () => [
        LoadingState(),
        const ErrorState(messages: 'try again'),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [MyState] when edit  a product must return  success.',
      build: () {
        when(mockProductUsecase.updateProduct(any, any))
            .thenAnswer((_) async => const Right(true));
        return productBloc;
      },
      act: (bloc) =>
          bloc.add(const UpdateProductEvent(productid: '1', product: product)),
      expect: () => [
        LoadingState(),
        const SuccessfulUpdateState(updated: true),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [MyState] when edit  a product must return failure.',
      build: () {
        when(mockProductUsecase.updateProduct(any, any)).thenAnswer((_) async =>
            const Left(ConnectionFailure('try again', message: 'Hello')));
        return productBloc;
      },
      act: (bloc) =>
          bloc.add(UpdateProductEvent(productid: '1', product: product)),
      expect: () => [
        LoadingState(),
        const ErrorState(messages: 'try again'),
      ],
    );
  });
}
