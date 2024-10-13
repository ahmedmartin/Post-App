import 'dart:convert';

import 'package:clean_architecture_posts_app/comments/data/models/comment_model.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/error/exceptions.dart';

abstract class CommentsLocalDataSource {
  Future<List<CommentModel>> getCachedComments(String postId);
  Future<Unit> cacheComments(List<CommentModel> CommentModels,String postId);
}

const CACHED_Comments = "CACHED_CommentS";

class CommentsLocalDataSourceImpl implements CommentsLocalDataSource {
  final SharedPreferences sharedPreferences;

  CommentsLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> cacheComments(List<CommentModel> CommentModels,String postId) {
    List CommentModelsToJson = CommentModels
        .map<Map<String, dynamic>>((CommentModel) => CommentModel.toJson())
        .toList();
    sharedPreferences.setString('$CACHED_Comments _ $postId', json.encode(CommentModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<CommentModel>> getCachedComments(String postId) {
    final jsonString = sharedPreferences.getString('$CACHED_Comments _ $postId');
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<CommentModel> jsonToCommentModels = decodeJsonData
          .map<CommentModel>((jsonCommentModel) => CommentModel.fromJson(jsonCommentModel))
          .toList();
      return Future.value(jsonToCommentModels);
    } else {
      throw EmptyCacheException();
    }
  }
}
