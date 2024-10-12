import 'package:bloc/bloc.dart';
import 'package:clean_architecture_posts_app/core/error/error_message.dart';
import 'package:clean_architecture_posts_app/core/error/failures.dart';
import 'package:clean_architecture_posts_app/users/domain/entities/user.dart';
import 'package:clean_architecture_posts_app/users/domain/usecases/get_user_by_id_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'user_by_id_state.dart';

class UserByIdCubit extends Cubit<UserByIdState> {
  UserByIdCubit({required this.userByIdUseCase}) : super(UserByIdInitial());

  final GetUserByIdUseCase userByIdUseCase;

  Future<void> getUserById({required String userId}) async {
     emit(LoadingUserState());

     final failureOrPosts = await userByIdUseCase.call(userId: userId);
     emit(_mapFailureOrPostsToState(failureOrPosts));
  }

  UserByIdState _mapFailureOrPostsToState(Either<Failure, User> either) {
    return either.fold(
      (failure) => ErrorUserState(message: mapFailureToMessage(failure)),
      (user) => LoadedUserState(
        user: user,
      ),
    );
  }
}
