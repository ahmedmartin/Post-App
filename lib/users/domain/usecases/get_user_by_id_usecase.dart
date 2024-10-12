import 'package:clean_architecture_posts_app/core/error/failures.dart';
import 'package:clean_architecture_posts_app/users/domain/entities/user.dart';
import 'package:clean_architecture_posts_app/users/domain/repositories/users_repository.dart';
import 'package:dartz/dartz.dart';

class GetUserByIdUseCase {
  final UsersRepository repository;

  GetUserByIdUseCase(this.repository);

  Future<Either<Failure, User>> call({required String userId}) async {
    return await repository.getUserById(userId: userId);
  }
}