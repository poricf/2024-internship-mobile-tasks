import 'package:equatable/equatable.dart';

import '../../Domain/entities/product.dart';


abstract class ProductState extends Equatable{
  const ProductState();

  @override
  List<Object> get props => [];
}

class InitialState extends ProductState{}

class LoadingState extends ProductState{}


class LoadedSingleProductState extends ProductState{
  final Product product;
  const LoadedSingleProductState({required this.product});
  @override
  List<Object> get props => [product];

}



class LoadedAllProductsState extends ProductState{
  final List<Product> products;
  const LoadedAllProductsState({required this.products});

}

class SuccessfulDeletionState extends ProductState{

  final bool deleted;

  const SuccessfulDeletionState(
    {
      required this.deleted
    });

    
  @override
  List<Object> get props => [deleted];
}


class SuccessfulAdditionState extends ProductState{
  final bool added;

  const SuccessfulAdditionState({
    required this.added
  });
  List<Object> get props => [added];
}


class SuccessfulUpdateState extends ProductState{
  final bool updated;
  const SuccessfulUpdateState({
    required this.updated
  });
  List<Object> get props => [updated];
}




class ErrorState extends ProductState {
  final String messages;

  const ErrorState({required this.messages});

  @override
  List<Object> get props => [messages];
}
