import 'package:clean_architecture_posts_app/comments/domain/entities/comment.dart';


class CommentModel extends Comment {
  const CommentModel({
    int? id,
    required String name,
    required String body,
    required int postId,
    required String email,
  }) : super(id: id, name: name, body: body, postId: postId, email: email);

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
        id: json['id'],
        name: json['name'],
        body: json['body'],
        email: json['email'],
        postId: json['postId']);
  }

  // Map<String, dynamic> toJson() {
  //   return {'id': id, 'name': title, 'body': body};
  // }
}
