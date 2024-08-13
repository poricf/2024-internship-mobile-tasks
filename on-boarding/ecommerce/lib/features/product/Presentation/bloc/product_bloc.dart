import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Domain/usecases/product_usecase.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductUsecase productUsecases;

  ProductBloc({required this.productUsecases}) : super(InitialState()) {
    on<GetSingleProductEvent>((event, emit) async {
      emit(LoadingState());

      final result = await productUsecases.getProduct(event.productid);
      result.fold((failure) {
        emit(const ErrorState(messages: 'try again'));
      }, (data) {
        emit(LoadedSingleProductState(product: data));
      });
    });


    //Load

    on<LoadAllProductsEvent>((event, emit) async {
      emit(LoadingState());

      final result = await productUsecases.dataForAll();
      result.fold((failure) {
        emit(const ErrorState(messages: 'try again'));
      }, (data) {
        emit(LoadedAllProductsState(products: data));
      });
    });


    // create

    on<CreateProductEvent>((event, emit) async {
      emit(LoadingState());
      final result = await productUsecases.addProduct(event.product);
      result.fold((failure) {
        emit(const ErrorState(messages: 'try again'));
      }, (data) {
        emit(const SuccessfulAdditionState(added: true));
      });
    });


    // Delete
    on<DeleteProductEvent>((event, emit) async {
      emit(LoadingState());
      final result = await productUsecases.deleteProduct(event.productid);
      result.fold((failure) {
        emit(const ErrorState(messages: 'try again'));
      }, (data) {
        emit(const SuccessfulDeletionState(deleted: true));
      });
    });


    //Update

    on<UpdateProductEvent>((event, emit) async {
      emit(LoadingState());
      final result =
          await productUsecases.updateProduct(event.productid, event.product);
      result.fold((failure) {
        emit(const ErrorState(messages: 'try again'));
      }, (data) {
        emit(const SuccessfulUpdateState(updated: true));
      });
    });
  }
}
