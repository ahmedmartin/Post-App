part of 'comments_bloc.dart';

abstract class CommentsState extends Equatable {
  const CommentsState();

  @override
  List<Object> get props => [];
}

class CommentsInitial extends CommentsState {}

class LoadingCommentsState extends CommentsState {}

class LoadedCommentsState extends CommentsState {
  final List<Comment> comments;

  const LoadedCommentsState({required this.comments});

  @override
  List<Object> get props => [comments];
}

class ErrorCommentsState extends CommentsState {
  final String message;

  const ErrorCommentsState({required this.message});

  @override
  List<Object> get props => [message];
}
