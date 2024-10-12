import 'package:clean_architecture_posts_app/users/data/datasources/user_remote_data_source.dart';
import 'package:clean_architecture_posts_app/users/domain/entities/user.dart';
import 'package:clean_architecture_posts_app/users/domain/repositories/users_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../../../core/network/network_info.dart';

class UsersRepositoryImpl implements UsersRepository {
  final UserRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  UsersRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<User>>> getAllUsers() async {
    try {
      final remotePosts = await remoteDataSource.getAllUsers();
      return Right(remotePosts);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getUserById({required String userId}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUsers = await remoteDataSource.getUserById(userId: userId);
        return Right(remoteUsers);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }
}
