import 'package:clean_architecture_posts_app/core/app_theme.dart';
import 'package:flutter/material.dart';

class MessageDisplayWidget extends StatelessWidget {
  final String message;
  final Function()? onRetry;
  const MessageDisplayWidget({
    Key? key,
    required this.message, this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
            child: Text(
              message,
              style: const TextStyle(fontSize: 20,color: Colors.red),
              textAlign: TextAlign.center,
            )),
        TextButton(onPressed: onRetry, child: Text('Retry',style: TextStyle(color: Colors.white),),style: ButtonStyle(backgroundColor:WidgetStatePropertyAll(primaryColor) ),)
      ],
    );
  }
}
