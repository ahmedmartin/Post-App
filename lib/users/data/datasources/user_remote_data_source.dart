import 'package:clean_architecture_posts_app/core/strings/api_urls.dart';
import 'package:clean_architecture_posts_app/users/data/models/user_model.dart';
import 'package:dio/dio.dart';

import '../../../core/error/exceptions.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> getAllUsers();
  Future<UserModel> getUserById({required String userId});
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio client;

  UserRemoteDataSourceImpl({required this.client});
  @override
  Future<List<UserModel>> getAllUsers() async {
    final response = await client.get(
      UsersURL,
      options: Options(headers: {"Content-Type": "application/json"}),
    );

    if (response.statusCode == 200) {
      final List<UserModel> usersModels = response.data
          .map<UserModel>((jsonPostModel) => UserModel.fromJson(jsonPostModel))
          .toList();

      return usersModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> getUserById({required String userId}) async {
    final response = await client.get(
      '$UsersURL/$userId',
      options: Options(headers: {"Content-Type": "application/json"}),
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }
}
