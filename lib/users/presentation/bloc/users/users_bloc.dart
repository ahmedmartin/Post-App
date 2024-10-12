import 'package:bloc/bloc.dart';
import 'package:clean_architecture_posts_app/core/error/error_message.dart';
import 'package:clean_architecture_posts_app/users/domain/entities/user.dart';
import 'package:clean_architecture_posts_app/users/domain/usecases/get_all_users_usecase.dart';
import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final GetAllUsersUseCase getAllUsers;
  UsersBloc({
    required this.getAllUsers,
  }) : super(UsersInitial()) {
    on<UsersEvent>((event, emit) async {
      if (event is GetAllUsersEvent) {
        emit(LoadingUsersState());

        final failureOrPosts = await getAllUsers();
        emit(_mapFailureOrPostsToState(failureOrPosts));
      } else if (event is RefreshUsersEvent) {
        emit(LoadingUsersState());

        final failureOrPosts = await getAllUsers();
        emit(_mapFailureOrPostsToState(failureOrPosts));
      }
    });
  }

  UsersState _mapFailureOrPostsToState(Either<Failure, List<User>> either) {
    return either.fold(
      (failure) => ErrorUsersState(message: mapFailureToMessage(failure)),
      (users) => LoadedUsersState(
        users: users,
      ),
    );
  }

}
