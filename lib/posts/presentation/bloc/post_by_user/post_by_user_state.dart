part of 'post_by_user_cubit.dart';

class PostByUserState extends Equatable {
  const PostByUserState();

  @override
  List<Object> get props => [];
}

class PostByUserInitial extends PostByUserState {}


class LoadingPostsByUserState extends PostByUserState {}

class LoadedPostsByUserState extends PostByUserState {
  final List<Post> posts;

  const LoadedPostsByUserState({required this.posts});

  @override
  List<Object> get props => [posts];
}

class ErrorPostsByUserState extends PostByUserState {
  final String message;

  const ErrorPostsByUserState({required this.message});

  @override
  List<Object> get props => [message];
}