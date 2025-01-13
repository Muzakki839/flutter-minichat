import 'package:flutter/material.dart';
import 'package:minichat/main.dart';
import 'package:minichat/services/auth/auth_service.dart';
import 'package:minichat/widgets/buttons/common_button.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  // auth service
  final AuthService _authService = AuthService();

  // logout method
  void logout(context) {
    // get auth service
    final authService = AuthService();

    // sign out
    Navigator.pop(context);
    authService.signOut();
    main();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      // page title
      appBar: AppBar(
        title: Transform.scale(
          scale: 1.2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              Icon(Icons.add_circle_outlined, color: theme.primary),
              Text(
                "My Profile",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: theme.primary),
              ),
            ],
          ),
        ),
        actions: [SizedBox(width: 60)],
        // centerTitle: true,
      ),

      // root content
      body: Column(
        children: [
          // main
          Expanded(child: _buildPageContent(theme)),

          // footer
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: CommonButton(
              theme: theme,
              onPressed: () => logout(context),
              text: "Logout",
              backgroundColor: theme.error,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageContent(ColorScheme theme) {
    return ListView(
      children: [
        Container(
          padding: EdgeInsets.all(130),
          child: Transform.scale(
            scale: 5,
            child: CircleAvatar(
              // backgroundColor: Color((Random().nextDouble() * 0xFFFFFF).toInt()).withAlpha(255),
              backgroundColor: theme.tertiary,
              child: Icon(Icons.person, color: theme.onPrimary),
            ),
          ),
        ),

        // form
        _buildForm(theme),
      ],
    );
  }

  Widget _buildForm(ColorScheme theme) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Text(
            "Email",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          ),
          Text(
            _authService.getCurrentUser()!.email.toString(),
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
