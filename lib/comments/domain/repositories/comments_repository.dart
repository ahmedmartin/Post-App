import 'package:clean_architecture_posts_app/comments/domain/entities/comment.dart';

import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';

abstract class CommentsRepository {
  Future<Either<Failure, List<Comment>>> getAllComments();
}
