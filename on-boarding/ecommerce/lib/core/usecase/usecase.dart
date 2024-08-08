import 'package:dartz/dartz.dart';

import '../errors/falilures.dart';

abstract class Usecase<Type, Params> {
  Future<Either<Failure, Type>> call({Params params});
}