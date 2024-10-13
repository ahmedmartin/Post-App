const BaseURL = "https://jsonplaceholder.typicode.com";

const PostsURL = '$BaseURL/posts';

const UsersURL = '$BaseURL/users';

const CommentsURL = '$BaseURL/comments';

String getCommentByPostId(String postId)=> '$CommentsURL?postId=$postId';
