import 'package:clean_architecture_posts_app/comments/data/models/comment_model.dart';
import 'package:clean_architecture_posts_app/comments/domain/entities/comment.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const testCommentModel = CommentModel(
    id: 1,
    name: 'name',
    body: 'body',
    postId: 1,
    email: 'email',
  );

  test(
    'should be a subclass of weather entity',
    () {
      
        expect(testCommentModel, isA<Comment>());
    },
  );
}
