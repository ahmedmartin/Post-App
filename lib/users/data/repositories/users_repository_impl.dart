import 'package:clean_architecture_posts_app/users/data/datasources/user_remote_data_source.dart';
import 'package:clean_architecture_posts_app/users/data/datasources/users_local_data_source.dart';
import 'package:clean_architecture_posts_app/users/data/models/user_model.dart';
import 'package:clean_architecture_posts_app/users/domain/entities/user.dart';
import 'package:clean_architecture_posts_app/users/domain/repositories/users_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../../../core/network/network_info.dart';

class UsersRepositoryImpl implements UsersRepository {
  final UserRemoteDataSource remoteDataSource;
  final UsersLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  UsersRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<User>>> getAllUsers() async {
    try {
      final remotePosts = await remoteDataSource.getAllUsers();
      return Right(remotePosts.map((e) => e.toDomain()).toList());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getUserById({required String userId}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUsers = await remoteDataSource.getUserById(userId: userId);
        localDataSource.cacheUsers(remoteUsers,userId);
        return Right(remoteUsers.toDomain());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localUsers = await localDataSource.getCachedUsers(userId);
        return Right(localUsers.toDomain());
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }
}
