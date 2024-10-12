

import 'package:clean_architecture_posts_app/core/error/failures.dart';
import 'package:clean_architecture_posts_app/posts/domain/entities/post.dart';
import 'package:clean_architecture_posts_app/posts/domain/repositories/post_repository.dart';
import 'package:dartz/dartz.dart';

class GetPostsByUserUseCase {
  final PostsRepository repository;

  GetPostsByUserUseCase(this.repository);

  Future<Either<Failure, List<Post>>> call({required String userId}) async {
    return await repository.getPostsByUserId(userId: userId);
  }
}