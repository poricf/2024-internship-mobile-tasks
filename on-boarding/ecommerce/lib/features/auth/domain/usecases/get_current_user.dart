import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/UserEntity.dart';
import '../repositories/auth_repository.dart';

class GetCurrentUser implements UseCase<User, NoParams> {
  final AuthRepository repository;

  const GetCurrentUser(this.repository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await repository.getCurrentUser();
  }
}
