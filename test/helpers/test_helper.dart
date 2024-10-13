
import 'package:clean_architecture_posts_app/comments/data/datasources/comments_local_data_source.dart';
import 'package:clean_architecture_posts_app/comments/data/datasources/comments_remote_data_source.dart';
import 'package:clean_architecture_posts_app/comments/domain/repositories/comments_repository.dart';
// import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;


@GenerateMocks(
  [
    CommentsRepository,
    CommentsRemoteDataSource,
    // CommentsLocalDataSource,
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
  // customMocks: [MockSpec<Dio>(as: #MockHttpClient)],
)
void main() {}