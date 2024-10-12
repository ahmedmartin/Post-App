import 'package:clean_architecture_posts_app/users/domain/repositories/users_repository.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';

class GetAllUsersUseCase {
  final UsersRepository repository;

  GetAllUsersUseCase(this.repository);

  Future<Either<Failure, List<User>>> call() async {
    return await repository.getAllUsers();
  }
}