import 'package:clean_architecture_posts_app/posts/data/datasources/post_local_data_source.dart';
import 'package:clean_architecture_posts_app/posts/data/datasources/post_remote_data_source.dart';
import 'package:clean_architecture_posts_app/posts/domain/entities/post.dart';
import 'package:clean_architecture_posts_app/posts/domain/repositories/post_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../../../core/network/network_info.dart';

class PostsRepositoryImpl implements PostsRepository {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PostsRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getAllPosts();
        localDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDataSource.getCachedPosts();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Post>> getPostById({required String postId}) async {
    try {
      final remotePosts = await remoteDataSource.getPostById(postId: postId);
      return Right(remotePosts);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Post>>> getPostsByUserId(
      {required String userId}) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts =
            await remoteDataSource.getPostsByUserId(userId: userId);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    }else {
      return Left(OfflineFailure()); 
    }
  }
}
