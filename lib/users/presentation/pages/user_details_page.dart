import 'package:clean_architecture_posts_app/core/widgets/app_bar.dart';
import 'package:clean_architecture_posts_app/core/widgets/loading_widget.dart';
import 'package:clean_architecture_posts_app/posts/presentation/bloc/post_by_user/post_by_user_cubit.dart';
import 'package:clean_architecture_posts_app/core/widgets/message_display_widget.dart';
import 'package:clean_architecture_posts_app/posts/presentation/widgets/posts_page/post_list_widget.dart';
import 'package:clean_architecture_posts_app/users/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDetailsPage extends StatefulWidget {
  final User user;

  const UserDetailsPage({Key? key, required this.user}) : super(key: key);

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  late final PostByUserCubit postByUserCubit;

  @override
  void initState() {
    postByUserCubit = BlocProvider.of<PostByUserCubit>(context);
    postByUserCubit.postByUser(userId: widget.user.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar('User Details'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: const Text('User Name'),
              subtitle: Text(
                widget.user.userName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: const Text('Email'),
              subtitle: Text(
                widget.user.email,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: const Text('Phone'),
              subtitle: Text(
                widget.user.phone,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: const Text('Address'),
              subtitle: Text(
                '${widget.user.address.street} - ${widget.user.address.city}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: const Text('Company'),
              subtitle: Text(
                widget.user.company.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'User Posts',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            BlocBuilder<PostByUserCubit, PostByUserState>(
              bloc: postByUserCubit,
              builder: (context, state) {
                if (state is LoadedPostsByUserState) {
                  return SizedBox(
                    height: 400,
                    child: PostListWidget(posts: state.posts));
                } else if (state is ErrorPostsByUserState) {
                  return MessageDisplayWidget(message: state.message,onRetry: () {
                    postByUserCubit.postByUser(userId: widget.user.id.toString());
                  },);
                } else {
                  return const LoadingWidget();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
