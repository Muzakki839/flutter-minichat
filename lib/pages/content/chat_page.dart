import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({
    super.key,
    required this.selectedUser,
  });

  final String selectedUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedUser),
      ),
      body: Center(
        child: Text("Chat not found"),
      ),
    );
  }
}
