import 'package:clean_architecture_posts_app/comments/data/repositories/comment_repository_impl.dart';
import 'package:clean_architecture_posts_app/comments/domain/repositories/comments_repository.dart';
import 'package:clean_architecture_posts_app/comments/domain/usecases/get_all_comment_usecase.dart';
import 'package:clean_architecture_posts_app/comments/presentation/bloc/comments/comments_bloc.dart';
import 'package:clean_architecture_posts_app/posts/data/datasources/post_remote_data_source.dart';
import 'package:clean_architecture_posts_app/posts/data/repositories/post_repository_impl.dart';
import 'package:clean_architecture_posts_app/posts/domain/repositories/post_repository.dart';
import 'package:clean_architecture_posts_app/posts/domain/usecases/get_all_posts_usecase.dart';
import 'package:clean_architecture_posts_app/posts/domain/usecases/get_post_by_user_usecase.dart';
import 'package:clean_architecture_posts_app/posts/presentation/bloc/post_by_user/post_by_user_cubit.dart';
import 'package:clean_architecture_posts_app/users/data/datasources/user_remote_data_source.dart';
import 'package:clean_architecture_posts_app/users/data/repositories/users_repository_impl.dart';
import 'package:clean_architecture_posts_app/users/domain/repositories/users_repository.dart';
import 'package:clean_architecture_posts_app/users/domain/usecases/get_user_by_id_usecase.dart';
import 'package:clean_architecture_posts_app/users/presentation/bloc/user_by_id/user_by_id_cubit.dart';
import 'package:dio/dio.dart';

import 'core/network/network_info.dart';
import 'posts/data/datasources/post_local_data_source.dart';
import 'comments/data/datasources/comments_remote_data_source.dart';
import 'posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
//! Features - posts

// Bloc

  sl.registerFactory(() => PostsBloc(getAllPosts: sl()));
  sl.registerFactory(() => PostByUserCubit(postsByUserUseCase: sl()));
  sl.registerFactory(() => CommentsBloc(getAllComments: sl()));
  sl.registerFactory(() => UserByIdCubit(userByIdUseCase: sl()));

// Usecases

  sl.registerLazySingleton(() => GetAllPostsUsecase(sl()));
  sl.registerLazySingleton(() => GetPostsByUserUseCase(sl()));
  sl.registerLazySingleton(() => GetAllCommentsUseCase(sl()));
  sl.registerLazySingleton(() => GetUserByIdUseCase(sl()));

// Repository

  sl.registerLazySingleton<PostsRepository>(() => PostsRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<CommentsRepository>(() => CommentsRepositoryImpl(
      remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<UsersRepository>(() => UsersRepositoryImpl(
      remoteDataSource: sl(), networkInfo: sl()));

// Datasources

  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<PostLocalDataSource>(
      () => PostLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<CommentsRemoteDataSource>(
      () => CommentsRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(client: sl()));

//! Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

//! External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  // sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
