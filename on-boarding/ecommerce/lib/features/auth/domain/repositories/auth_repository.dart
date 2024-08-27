import 'package:dartz/dartz.dart';


import '../../../../core/failure/failure.dart';
import '../entities/UserEntity.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(
      {required String email, required String password});
  Future<Either<Failure, User>> register(
      {required String name, required String email, required String password});
  Future<Either<Failure, Unit>> logout();
  Future<Either<Failure, User>> getCurrentUser();

}
