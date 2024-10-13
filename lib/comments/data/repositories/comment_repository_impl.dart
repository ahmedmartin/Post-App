import 'package:clean_architecture_posts_app/comments/data/datasources/comments_local_data_source.dart';
import 'package:clean_architecture_posts_app/comments/data/models/comment_model.dart';
import 'package:clean_architecture_posts_app/comments/domain/entities/comment.dart';
import 'package:clean_architecture_posts_app/comments/domain/repositories/comments_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../../../core/network/network_info.dart';
import '../datasources/comments_remote_data_source.dart';

class CommentsRepositoryImpl implements CommentsRepository {
  final CommentsRemoteDataSource remoteDataSource;
  final CommentsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CommentsRepositoryImpl( {
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Comment>>> getAllComments(
      {required String postId}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteComments =
            await remoteDataSource.getAllComments(postId: postId);
        localDataSource.cacheComments(remoteComments,postId);
        return Right(remoteComments.map((e) => e.toDomain()).toList());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localComments = await localDataSource.getCachedComments(postId);
        return Right(localComments);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }
}
