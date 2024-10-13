import 'package:clean_architecture_posts_app/comments/presentation/bloc/comments/comments_bloc.dart';
import 'package:clean_architecture_posts_app/core/widgets/loading_widget.dart';
import 'package:clean_architecture_posts_app/posts/domain/entities/post.dart';
import 'package:clean_architecture_posts_app/posts/presentation/widgets/post_detail_page/comment_widget.dart';
import 'package:clean_architecture_posts_app/core/widgets/message_display_widget.dart';
import 'package:clean_architecture_posts_app/users/presentation/bloc/user_by_id/user_by_id_cubit.dart';
import 'package:clean_architecture_posts_app/users/presentation/pages/user_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class PostDetailWidget extends StatefulWidget {
  final Post post;

  const PostDetailWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  State<PostDetailWidget> createState() => _PostDetailWidgetState();
}

class _PostDetailWidgetState extends State<PostDetailWidget> {
  late final CommentsBloc commentsBloc;
  late final UserByIdCubit userByIdCubit;

  @override
  void initState() {
    commentsBloc = BlocProvider.of<CommentsBloc>(context);
    commentsBloc.add(GetAllCommentsEvent(postId: widget.post.id.toString()));
    userByIdCubit = BlocProvider.of<UserByIdCubit>(context);
    userByIdCubit.getUserById(userId: widget.post.userId.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BlocBuilder<UserByIdCubit, UserByIdState>(
              bloc: userByIdCubit,
              builder: (context, state) {
                if (state is LoadedUserState) {
                  return ListTile(
                    title: const Text('User'),
                    subtitle: Text(
                      state.user.userName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => UserDetailsPage(user: state.user),
                ),
              );
                    },
                  );
                }else if(state is ErrorUserState){
                  return MessageDisplayWidget(message: state.message,onRetry: () {
                    userByIdCubit.getUserById(userId: widget.post.userId.toString());
                  },);
                }else{
                  return const LoadingWidget();
                }
              },
            ),
            const SizedBox(height: 10),
            ListTile(
              title: const Text('Title'),
              subtitle: Text(
                widget.post.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              title: const Text('Details'),
              subtitle: Text(
                widget.post.body,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'comments',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            BlocBuilder<CommentsBloc, CommentsState>(
              bloc: commentsBloc,
              builder: (context, state) {
                if (state is LoadingCommentsState) {
                  return const LoadingWidget();
                } else if (state is ErrorCommentsState) {
                  return MessageDisplayWidget(message: state.message,onRetry: () {
                    commentsBloc.add(GetAllCommentsEvent(postId: widget.post.id.toString()));
                  },);
                } else if (state is LoadedCommentsState) {
                  return SizedBox(
                    height: 400,
                    child: RefreshIndicator(
                      onRefresh: () => _onRefresh(context),
                      child: ListView.separated(
                        itemCount: state.comments.length,
                        itemBuilder: (context, index) {
                          return CommentWidget(comment: state.comments[index]);
                        },
                        separatorBuilder: (context, index) {
                          return const Padding(
                            padding: EdgeInsets.all(10),
                            child: Divider(),
                          );
                        },
                      ),
                    ),
                  );
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

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<CommentsBloc>(context).add(RefreshCommentsEvent(postId: widget.post.id.toString()));
  }
}
