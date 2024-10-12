import 'package:clean_architecture_posts_app/comments/domain/entities/comment.dart';
import 'package:clean_architecture_posts_app/comments/domain/repositories/comments_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';

class GetAllCommentsUseCase {
  final CommentsRepository repository;

  GetAllCommentsUseCase(this.repository);

  Future<Either<Failure, List<Comment>>> call() async {
    return await repository.getAllComments();
  }
}
