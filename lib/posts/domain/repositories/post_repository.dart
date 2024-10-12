import '../entities/post.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class PostsRepository {
  Future<Either<Failure, List<Post>>> getAllPosts();
  Future<Either<Failure, Post>> getPostById({required String postId});
  Future<Either<Failure, List<Post>>> getPostsByUserId({required String userId});
}
