part of 'user_by_id_cubit.dart';

class UserByIdState extends Equatable {
  const UserByIdState();

  @override
  List<Object> get props => [];
}

class UserByIdInitial extends UserByIdState {}

class LoadingUserState extends UserByIdState {}

class LoadedUserState extends UserByIdState {
  final User user;

  const LoadedUserState({required this.user});

  @override
  List<Object> get props => [user];
}

class ErrorUserState extends UserByIdState {
  final String message;

  const ErrorUserState({required this.message});

  @override
  List<Object> get props => [message];
}