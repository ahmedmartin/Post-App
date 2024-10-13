
import 'dart:convert';

import 'package:clean_architecture_posts_app/core/strings/api_urls.dart';
// import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../../../core/error/exceptions.dart';
import '../models/comment_model.dart';

abstract class CommentsRemoteDataSource {
  Future<List<CommentModel>> getAllComments({required String postId});
}

class CommentsRemoteDataSourceImpl implements CommentsRemoteDataSource {
  final http.Client client;
  // final Dio client;

  CommentsRemoteDataSourceImpl({required this.client});
  @override
  Future<List<CommentModel>> getAllComments({required String postId}) async {

    //HTTP
    final response = await client.get(
      Uri.parse('$CommentsURL?postId=$postId'));

    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body) as List;
      final List<CommentModel> postModels = decodedJson
          .map<CommentModel>((jsonPostModel) => CommentModel.fromJson(jsonPostModel))
          .toList();

      return postModels;


      //dio
      // final response = await client.get(
      // getCommentByPostId(postId));
      // if (response.statusCode == 200) {
      // final List<CommentModel> commentsModels = response.data
      //     .map<CommentModel>(
      //         (jsonPostModel) => CommentModel.fromJson(jsonPostModel))
      //     .toList();

      // return commentsModels;
    } else {
      throw ServerException();
    }
  }
}
