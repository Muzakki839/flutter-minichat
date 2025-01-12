import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minichat/services/auth/auth_service.dart';
import 'package:minichat/services/chat/chat_service.dart';
import 'package:minichat/widgets/fields/common_text_field.dart';

class ChatPage extends StatefulWidget {
  final String receiverName;
  final String receiverID;

  const ChatPage({
    super.key,
    required this.receiverName,
    required this.receiverID,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // text controller
  final TextEditingController _messageController = TextEditingController();

  // chat & auth service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();

    // add listener to textfield focus node
    _focusNode.addListener(
      () {
        // wait until keyboard show up
        // then calculate remaining height
        // then run scrollDown() method
        if (_focusNode.hasFocus) {
          Future.delayed(Durations.extralong1, () => scrollDown());
        }
      },
    );

    // wait until lisview to be build then scrollDown()
    Future.delayed(Durations.extralong1, () => scrollDown());
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // scroll fix
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  void scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.extentTotal,
      duration: Durations.long4,
      curve: Curves.fastOutSlowIn,
    );
  }

  // send message
  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      // sending message
      await _chatService.sendMessage(
          widget.receiverID, _messageController.text);

      // reset the text controller
      _messageController.clear();
    }

    scrollDown();
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
              widget.receiverName,
              style: TextStyle(color: theme.onPrimary),
            ),
          ],
        ),
        titleSpacing: 0,
        backgroundColor: theme.primary,
        foregroundColor: theme.onPrimary,
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
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
      stream: _chatService.getMessage(senderID, widget.receiverID),
      builder: (context, snapshot) {
        // errors
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }

        // loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        // return listView
        if (snapshot.data!.docs.isNotEmpty) {
          return Padding(
            padding:
                const EdgeInsets.only(top: 0, bottom: 80, left: 5, right: 5),
            child: ListView(
              controller: _scrollController,
              children: snapshot.data!.docs
                  .map<Widget>(
                    (messageDoc) => _buildMessageListItem(messageDoc, context),
                  )
                  .toList(),
            ),
          );
        } else {
          return Center(
            child: Text("Chat not found"),
          );
        }
      },
    );
  }

  Widget _buildMessageListItem(
    DocumentSnapshot messageDoc,
    BuildContext context,
  ) {
    final theme = Theme.of(context).colorScheme;

    // assign the message data
    Map<String, dynamic> data = messageDoc.data() as Map<String, dynamic>;

    // check if the message from current user
    bool isCurrentUser =
        messageDoc['senderID'] == _authService.getCurrentUser()!.uid;

    // specify style message for sender or receiver
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    Color color =
        isCurrentUser ? theme.primaryContainer : theme.secondaryContainer;
    var margin = isCurrentUser
        ? EdgeInsets.only(top: 10, left: 10, right: 0)
        : EdgeInsets.only(top: 10, left: 0, right: 10);

    // return message item
    return Align(
      alignment: alignment,
      child: Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        margin: margin,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Text(
          data["message"],
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ),
    );
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
              color: theme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(26),
                ),
              ),
              elevation: 5,
              shadowColor: theme.scrim,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: CommonTextField(
                  hintText: "Type message here",
                  controller: _messageController,
                  onSubmitted: (text) {
                    _messageController.text;
                    sendMessage();
                  },
                  focusNode: _focusNode,
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
              elevation: WidgetStatePropertyAll(5),
            ),
          ),
        ],
      ),
    );
  }
}
