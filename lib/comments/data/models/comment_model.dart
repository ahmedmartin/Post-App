import 'package:clean_architecture_posts_app/comments/domain/entities/comment.dart';

class CommentModel extends Comment {
  const CommentModel({
    required int id,
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

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'body': body,'email':email,'postId':postId,};
  }
}

extension MapToDomain on CommentModel {
  Comment toDomain() =>
      Comment(id: id, name: name, body: body, email: email, postId: postId);
}
