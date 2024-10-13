import 'package:bloc/bloc.dart';
import 'package:clean_architecture_posts_app/comments/domain/entities/comment.dart';
import 'package:clean_architecture_posts_app/comments/domain/usecases/get_all_comment_usecase.dart';
import 'package:clean_architecture_posts_app/core/error/error_message.dart';
import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final GetAllCommentsUseCase getAllComments;
  CommentsBloc({
    required this.getAllComments,
  }) : super(CommentsInitial()) {
    on<CommentsEvent>((event, emit) async {
      if (event is GetAllCommentsEvent) {
        emit(LoadingCommentsState());

        final failureOrPosts = await getAllComments(postId: event.postId);
        emit(_mapFailureOrPostsToState(failureOrPosts));
      } else if (event is RefreshCommentsEvent) {
        emit(LoadingCommentsState());

        final failureOrPosts = await getAllComments(postId: event.postId);
        emit(_mapFailureOrPostsToState(failureOrPosts));
      }
    });
  }

  CommentsState _mapFailureOrPostsToState(
      Either<Failure, List<Comment>> either) {
    return either.fold(
      (failure) => ErrorCommentsState(message: mapFailureToMessage(failure)),
      (comments) => LoadedCommentsState(
        comments: comments,
      ),
    );
  }

}
