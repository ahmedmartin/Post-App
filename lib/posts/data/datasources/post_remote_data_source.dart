import 'package:clean_architecture_posts_app/core/strings/api_urls.dart';
import 'package:clean_architecture_posts_app/posts/data/models/post_model.dart';
import 'package:dio/dio.dart';

import '../../../core/error/exceptions.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<PostModel> getPostById({required String postId});
  Future<List<PostModel>> getPostsByUserId({required String userId});
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final Dio client;

  PostRemoteDataSourceImpl({required this.client});
  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(
      PostsURL,
      options: Options(headers: {"Content-Type": "application/json"}),
    );

    if (response.statusCode == 200) {
      final List<PostModel> postModels = response.data
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();

      return postModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<PostModel> getPostById({required String postId}) async {
    final response = await client.get(
      '$PostsURL/$postId',
      options: Options(headers: {"Content-Type": "application/json"}),
    );

    if (response.statusCode == 200) {
      return PostModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<PostModel>> getPostsByUserId({required String userId}) async {
    final response = await client.get(
      '$PostsURL?userId=$userId',
      options: Options(headers: {"Content-Type": "application/json"}),
    );

    if (response.statusCode == 200) {
      final List<PostModel> postModels = response.data
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();

      return postModels;
    } else {
      throw ServerException();
    }
  }
}
