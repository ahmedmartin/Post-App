import 'package:clean_architecture_posts_app/comments/domain/entities/comment.dart';
import 'package:clean_architecture_posts_app/comments/domain/usecases/get_all_comment_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetAllCommentsUseCase commentUseCase;
  late MockCommentsRepository mockCommentsRepository;

  setUp(() {
    mockCommentsRepository = MockCommentsRepository();
    commentUseCase = GetAllCommentsUseCase(mockCommentsRepository);
  });

  const testComments = [Comment(
    id: 1,
    name: 'name',
    body: 'body',
    email: 'email',
    postId: 1,
  )];

  const postId = 1;

  test(
    'should get current comments from the repository',
    () async {
      
      when(mockCommentsRepository.getAllComments(postId: postId.toString())).thenAnswer((_) async => const Right(testComments));

      final result = await commentUseCase.call(postId: postId.toString());

      expect(result, equals(const Right(testComments)));
    },
  );
}
