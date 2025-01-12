import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minichat/services/auth/auth_service.dart';
import 'package:minichat/services/chat/chat_service.dart';
import 'package:minichat/widgets/fields/common_text_field.dart';

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
      body: Column(
        children: [
          // show all message
          Expanded(child: _buildMessageList()),

          // user input
          _buildUserInput(theme),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessage(senderID, receiverID),
      builder: (context, snapshot) {
        // errors
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }

        // loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        // return listView
        if (snapshot.data!.docs.isNotEmpty) {
          return ListView(
            children: snapshot.data!.docs
                .map<Widget>(
                  (messageDoc) => _buildMessageListItem(messageDoc),
                )
                .toList(),
          );
        } else {
          return Center(
            child: Text("Chat not found"),
          );
        }
      },
    );
  }

  Widget _buildMessageListItem(DocumentSnapshot messageDoc) {
    Map<String, dynamic> data = messageDoc.data() as Map<String, dynamic>;

    return Text(data["message"]);
  }

  Widget _buildUserInput(ColorScheme theme) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        spacing: 10,
        children: [
          // textfield
          Expanded(
            child: Card(
              color: theme.surfaceContainerLowest,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                // side: BorderSide(color: theme.primary),
              ),
              surfaceTintColor: theme.primary,
              elevation: 5,
              shadowColor: theme.scrim,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: CommonTextField(
                  hintText: "Type message here",
                  controller: _messageController,
                ),
              ),
            ),
          ),

          // send button
          IconButton(
            onPressed: sendMessage,
            icon: Icon(Icons.send_rounded),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(theme.primary),
              iconColor: WidgetStatePropertyAll(theme.onPrimary),
              shadowColor: WidgetStatePropertyAll(theme.scrim),
              padding: WidgetStatePropertyAll(EdgeInsets.all(12)),
              iconSize: WidgetStatePropertyAll(26),
              // elevation: WidgetStatePropertyAll(5),
            ),
          ),
        ],
      ),
    );
  }
}
