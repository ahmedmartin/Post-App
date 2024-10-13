import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  final int id;
  final String name;
  final String body;
  final String email;
  final int postId;

  const Comment({required this.id, required this.name, required this.body,required this.email,required this.postId,});

  @override
  List<Object?> get props => [id, name, body,postId,email];
}
