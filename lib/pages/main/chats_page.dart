import 'package:flutter/material.dart';
import 'package:minichat/pages/content/chat_page.dart';
import 'package:minichat/services/auth/auth_service.dart';
import 'package:minichat/services/chat/chat_service.dart';
import 'package:minichat/widgets/item/user_tile.dart';

class ChatsPage extends StatelessWidget {
  ChatsPage({super.key});

  // chat & auth service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return _buildUserList();
  }

  // build a listView of users
  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
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
        return Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: snapshot.data!
                .map<Widget>(
                  (userData) => _buildUserListItem(userData, context),
                )
                .toList(),
          ),
        );
      },
    );
  }

  // build each listTile of user (except current user)
  Widget _buildUserListItem(
    Map<String, dynamic> userData,
    BuildContext context,
  ) {
    // display each user (except current user)
    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: UserTile(
          text: userData["email"],
          onTap: () {
            // navigate to chat page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  receiverName: userData["email"],
                  receiverID: userData["uid"],
                ),
              ),
            );
          },
        ),
      );
    } else {
      return Container();
    }
  }
}
