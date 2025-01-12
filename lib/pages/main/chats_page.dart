import 'package:flutter/material.dart';
import 'package:minichat/pages/content/chat_page.dart';
import 'package:minichat/services/auth/auth_service.dart';
import 'package:minichat/services/chat/chat_service.dart';
import 'package:minichat/widgets/item/user_tile.dart';
import 'package:minichat/widgets/utilities/app_title.dart';

class ChatsPage extends StatelessWidget {
  ChatsPage({super.key});

  // chat & auth service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  // logout method
  void logout(context) {
    // get auth service
    final authService = AuthService();

    // sign out
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      // chats page title
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(20),
          child: AppTitle(scale: 1.3),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case "logout":
                  logout(context);
                  break;
                default:
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'logout',
                child: Text('Logout'),
              ),
              PopupMenuItem(
                value: 'about',
                child: Text('About'),
              ),
            ],
            icon: const Icon(Icons.more_vert),
            offset: Offset(0, 40),
            color: theme.surfaceContainerLowest,
          ),
        ],
      ),

      // show chatRoom list
      body: _buildUserList(),
    );
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
          return Center(child: CircularProgressIndicator());
        }

        // return listView
        return Padding(
          padding: const EdgeInsets.only(top: 0, bottom: 20, left: 5, right: 5),
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
      return UserTile(
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
      );
    } else {
      return Container();
    }
  }
}
