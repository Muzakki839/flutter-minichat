import 'package:flutter/material.dart';
import 'package:minichat/services/auth/auth_gate.dart';
import 'package:minichat/services/auth/auth_service.dart';
import 'package:minichat/pages/auth/register_page.dart';
import 'package:minichat/widgets/utilities/app_title.dart';
import 'package:minichat/widgets/buttons/common_button.dart';
import 'package:minichat/widgets/popups/common_alert_dialog.dart';
import 'package:minichat/widgets/fields/icon_text_field.dart';
import 'package:minichat/widgets/fields/password_field.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // field controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // login method
  void login(context) async {
    // get auth service
    final authService = AuthService();

    // try login
    try {
      await authService.signInWithEmailPassword(
        _emailController.text,
        _passwordController.text,
      );
      // navigate to main page
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const AuthGate(),
        ),
      );
    }

    // catch errors
    catch (e) {
      showDialog(
        context: context,
        builder: (context) => CommonAlertDialog(
          title: const Text(
            "Error",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
          ),
          content: Text(e.toString()),
          buttonColor: Colors.red.shade200,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      body: ListView(
        children: [
          //logo
          const SizedBox(height: 170),
          Center(
            child: const AppTitle(
              scale: 3,
            ),
          ),
          const SizedBox(height: 64),

          // form title
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              "Login",
              style: TextStyle(
                color: theme.primary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // form fields
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              spacing: 20,
              children: [
                IconTextField(
                  label: "Email",
                  prefixIcon: const Icon(Icons.email),
                  controller: _emailController,
                ),
                PasswordField(
                  label: "Password",
                  controller: _passwordController,
                ),
                SizedBox(),
                CommonButton(
                  theme: theme,
                  text: "Login",
                  onPressed: () => login(context),
                  backgroundColor: theme.primary,
                )
              ],
            ),
          ),

          // register link
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account?",
                style: TextStyle(
                  color: theme.primary,
                  fontSize: 16,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => RegisterPage(),
                    ),
                  );
                },
                child: Text(
                  "Register",
                  style: TextStyle(
                    color: theme.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
