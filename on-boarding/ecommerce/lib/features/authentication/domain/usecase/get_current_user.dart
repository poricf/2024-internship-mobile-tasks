
import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/user.dart';
import '../repository/auth_repository.dart';

class GetCurrentUserUseCase implements UseCase<User,NoParams> {
  final AuthRepository repository;

  const GetCurrentUserUseCase(this.repository);
  
  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await repository.getCurrentUser();
  }

  


}