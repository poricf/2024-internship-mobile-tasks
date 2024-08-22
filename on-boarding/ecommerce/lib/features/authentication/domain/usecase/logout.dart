// logout use case 

// unit instead of void

import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class LogoutUsecase implements UseCase<Unit, NoParams> {
  final AuthRepository repository;

  const LogoutUsecase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return await repository.logout();
  } 
  
}