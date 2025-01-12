import 'package:flutter/material.dart';
import 'package:minichat/services/auth/auth_service.dart';
import 'package:minichat/services/chat/chat_service.dart';

class ChatPage extends StatelessWidget {
  final String receiverName;
  final String receiverID;

  ChatPage({
    super.key,
    required this.receiverName,
    required this.receiverID,
  });

  // text controller
  final TextEditingController _messageController = TextEditingController();

  // chat & auth service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  // send message
  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      // sending message
      await _chatService.sendMessage(receiverID, _messageController.text);

      // reset the text controller
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          spacing: 10,
          children: [
            CircleAvatar(
              backgroundColor: theme.onPrimary,
              child: Icon(Icons.person, color: theme.primary),
            ),
            Text(
              receiverName,
              style: TextStyle(color: theme.onPrimary),
            ),
          ],
        ),
        titleSpacing: 0,
        backgroundColor: theme.primary,
        foregroundColor: theme.onPrimary,
      ),
      body: Center(
        child: Text("Chat not found"),
      ),
    );
  }
}
