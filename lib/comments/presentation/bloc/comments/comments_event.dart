part of 'comments_bloc.dart';

abstract class CommentsEvent extends Equatable {
  const CommentsEvent();

  @override
  List<Object> get props => [];
}

class GetAllCommentsEvent extends CommentsEvent {
  final String postId;

  const GetAllCommentsEvent({required this.postId});
}

class RefreshCommentsEvent extends CommentsEvent {
  final String postId;

  const RefreshCommentsEvent({required this.postId});
}
