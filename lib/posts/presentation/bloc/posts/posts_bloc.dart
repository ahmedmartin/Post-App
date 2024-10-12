import 'package:bloc/bloc.dart';
import 'package:clean_architecture_posts_app/core/error/error_message.dart';
import 'package:clean_architecture_posts_app/posts/domain/entities/post.dart';
import 'package:clean_architecture_posts_app/posts/domain/usecases/get_all_posts_usecase.dart';
import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';


part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUsecase getAllPosts;
  PostsBloc({
    required this.getAllPosts,
  }) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(LoadingPostsState());

        final failureOrPosts = await getAllPosts();
        emit(_mapFailureOrPostsToState(failureOrPosts));
      } else if (event is RefreshPostsEvent) {
        emit(LoadingPostsState());

        final failureOrPosts = await getAllPosts();
        emit(_mapFailureOrPostsToState(failureOrPosts));
      }
    });
  }

  PostsState _mapFailureOrPostsToState(Either<Failure, List<Post>> either) {
    return either.fold(
      (failure) => ErrorPostsState(message: mapFailureToMessage(failure)),
      (posts) => LoadedPostsState(
        posts: posts,
      ),
    );
  }

  
}
