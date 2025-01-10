import 'package:flutter/material.dart';
import 'package:minichat/pages/auth/login_page.dart';
import 'package:minichat/pages/main_page.dart';
import 'package:minichat/widgets/app_title.dart';
import 'package:minichat/widgets/buttons/common_button.dart';
import 'package:minichat/widgets/fields/icon_text_field.dart';
import 'package:minichat/widgets/fields/password_field.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  // field controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // register method
  void register(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const MainPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      body: ListView(
        children: [
          //logo
          const SizedBox(height: 130),
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
              "Register",
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
                  theme: theme,
                  label: "Email",
                  prefixIcon: const Icon(Icons.email),
                  controller: _emailController,
                ),
                PasswordField(
                  theme: theme,
                  label: "Password",
                  controller: _passwordController,
                ),
                PasswordField(
                  theme: theme,
                  label: "Confirm Password",
                  controller: _confirmPasswordController,
                ),
                SizedBox(),
                CommonButton(
                  theme: theme,
                  text: "Register",
                  onPressed: () => register(context),
                  backgroundColor: theme.primary,
                )
              ],
            ),
          ),

          // login link
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account?",
                style: TextStyle(
                  color: theme.primary,
                  fontSize: 16,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
                child: Text(
                  "Login",
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
