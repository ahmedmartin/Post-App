import 'package:bloc/bloc.dart';
import 'package:clean_architecture_posts_app/core/error/error_message.dart';
import 'package:clean_architecture_posts_app/core/error/failures.dart';
import 'package:clean_architecture_posts_app/posts/domain/entities/post.dart';
import 'package:clean_architecture_posts_app/posts/domain/usecases/get_post_by_user_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'post_by_user_state.dart';

class PostByUserCubit extends Cubit<PostByUserState> {
  PostByUserCubit({required this.postsByUserUseCase}) : super(PostByUserInitial());

  final GetPostsByUserUseCase postsByUserUseCase;

  Future<void> postByUser({required String userId}) async {
    emit(LoadingPostsByUserState());

        final failureOrPosts = await postsByUserUseCase.call(userId: userId);
        emit(_mapFailureOrPostsToState(failureOrPosts));
  }

  PostByUserState _mapFailureOrPostsToState(Either<Failure, List<Post>> either) {
    return either.fold(
      (failure) => ErrorPostsByUserState(message: mapFailureToMessage(failure)),
      (posts) => LoadedPostsByUserState(
        posts: posts,
      ),
    );
  }
}
