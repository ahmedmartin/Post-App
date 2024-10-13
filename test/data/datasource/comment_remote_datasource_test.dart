import 'package:clean_architecture_posts_app/comments/data/datasources/comments_remote_data_source.dart';
import 'package:clean_architecture_posts_app/comments/data/models/comment_model.dart';
import 'package:clean_architecture_posts_app/core/strings/api_urls.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient client;
  late CommentsRemoteDataSourceImpl dataSourceImpl;

  setUp(
    () {
      client = MockHttpClient();
      dataSourceImpl = CommentsRemoteDataSourceImpl(client: client);
    },
  );

  const postId = 1;

  group(
    'fetch current comment',
    ()  {
      
      test('fetch comment from backend with response code 200', () async {
        when(client.get(Uri.parse(getCommentByPostId(postId.toString()))))
          .thenAnswer((_) async => http.Response(
              readJson('helpers/dummy_data/comment_dummy_data_test.json'),
              200));

      final result =
          await dataSourceImpl.getAllComments(postId: postId.toString());

      expect(result, isA<List<CommentModel>>());
      },);
    },
  );
}
