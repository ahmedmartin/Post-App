import 'package:clean_architecture_posts_app/comments/domain/entities/comment.dart';
import 'package:clean_architecture_posts_app/comments/domain/repositories/comments_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../../../core/network/network_info.dart';
import '../datasources/comments_remote_data_source.dart';

class CommentsRepositoryImpl implements CommentsRepository {
  final CommentsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  CommentsRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Comment>>> getAllComments() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getAllComments();
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }
}
