import 'package:clean_architecture_posts_app/comments/presentation/bloc/comments/comments_bloc.dart';
import 'package:clean_architecture_posts_app/posts/presentation/bloc/post_by_user/post_by_user_cubit.dart';
import 'package:clean_architecture_posts_app/users/presentation/bloc/user_by_id/user_by_id_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/app_theme.dart';
import 'posts/presentation/bloc/posts/posts_bloc.dart';
import 'posts/presentation/pages/posts_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => di.sl<PostsBloc>()..add(GetAllPostsEvent())),
          BlocProvider(
              create: (_) => di.sl<CommentsBloc>()),
          BlocProvider(
              create: (_) => di.sl<UserByIdCubit>()),
          BlocProvider(
              create: (_) => di.sl<PostByUserCubit>()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: appTheme,
            title: 'Posts App',
            home: const PostsPage()));
  }
}
