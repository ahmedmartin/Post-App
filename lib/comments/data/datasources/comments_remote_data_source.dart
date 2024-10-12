
import 'package:clean_architecture_posts_app/core/strings/api_urls.dart';
import 'package:dio/dio.dart';

import '../../../core/error/exceptions.dart';
import '../models/comment_model.dart';

abstract class CommentsRemoteDataSource {
  Future<List<CommentModel>> getAllComments();
}

class CommentsRemoteDataSourceImpl implements CommentsRemoteDataSource {
  final Dio client;

  CommentsRemoteDataSourceImpl({required this.client});
  @override
  Future<List<CommentModel>> getAllComments() async {
    final response = await client.get(
      CommentsURL,
      options: Options(headers: {"Content-Type": "application/json"}),
    );

    if (response.statusCode == 200) {
      final List<CommentModel> commentsModels = response.data
          .map<CommentModel>(
              (jsonPostModel) => CommentModel.fromJson(jsonPostModel))
          .toList();

      return commentsModels;
    } else {
      throw ServerException();
    }
  }
}
