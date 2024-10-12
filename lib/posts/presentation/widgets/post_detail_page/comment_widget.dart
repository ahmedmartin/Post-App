import 'package:clean_architecture_posts_app/comments/domain/entities/comment.dart';
import 'package:flutter/material.dart';

class CommentWidget extends StatelessWidget {
  final Comment comment;

  const CommentWidget({Key? key, required this.comment}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(comment.name,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
      const SizedBox(height: 10),
      Text(comment.body)],
    );
  }
}
