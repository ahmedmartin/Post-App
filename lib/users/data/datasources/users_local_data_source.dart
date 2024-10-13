import 'dart:convert';

import 'package:clean_architecture_posts_app/users/data/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/error/exceptions.dart';

abstract class UsersLocalDataSource {
  Future<UserModel> getCachedUsers(String postId);
  Future<Unit> cacheUsers(UserModel UsersModels,String postId);
}

const CACHED_Users = "CACHED_Users";

class UsersLocalDataSourceImpl implements UsersLocalDataSource {
  final SharedPreferences sharedPreferences;

  UsersLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> cacheUsers(UserModel UserModel,String userId) {
  
    sharedPreferences.setString('$CACHED_Users _ $userId', json.encode(UserModel.toJson()));
    return Future.value(unit);
  }

  @override
  Future<UserModel> getCachedUsers(String userId) {
    final jsonString = sharedPreferences.getString('$CACHED_Users _ $userId');
    if (jsonString != null) {
      var decodeJsonData = json.decode(jsonString);
      UserModel model = UserModel.fromJson(decodeJsonData);
      return Future.value(model);
    } else {
      throw EmptyCacheException();
    }
  }
}
