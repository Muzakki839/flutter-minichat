import 'package:flutter/material.dart';
import 'package:minichat/main.dart';
import 'package:minichat/pages/main_page.dart';
import 'package:minichat/widgets/buttons/common_button.dart';
import 'package:minichat/widgets/fields/common_text_field.dart';
import 'package:minichat/widgets/popups/common_alert_dialog.dart';

class AddContactPage extends StatelessWidget {
  AddContactPage({super.key});

  // text controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // get initiated contactsDb
  final contactsDb = MyApp.contactsData;

  // add contact method
  void addContact(BuildContext context) {
    final emailPattern = r'^[^@]+@[^@]+\.[^@]+';
    final regExp = RegExp(emailPattern);

    // validate
    if (_emailController.text.isNotEmpty && _nameController.text.isNotEmpty) {
      if (regExp.hasMatch(_emailController.text)) {
        _saveContact(context);
      } else {
        _showErrorDialog(context, "Invalid email format");
      }
    } else {
      _showErrorDialog(context, "Name & Email couldn't be empty");
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      // add contact page title
      appBar: AppBar(
        title: Transform.scale(
          scale: 1.2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              Icon(Icons.add_circle_outlined, color: theme.primary),
              Text(
                "Add a Contact",
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
            padding: const EdgeInsets.all(20),
            child: CommonButton(
              theme: theme,
              onPressed: () => addContact(context),
              text: "Add",
              backgroundColor: theme.primary,
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
          Text("Name",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
          CommonTextField(
            hintText: "' e.g. Budi '",
            inputBorder: UnderlineInputBorder(),
            controller: _nameController,
          ),
          SizedBox(height: 40),
          Text("Email",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
          CommonTextField(
            hintText: "' e.g. Budi123@email.com '",
            inputBorder: UnderlineInputBorder(),
            controller: _emailController,
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  // save to db
  void _saveContact(BuildContext context) {
    contactsDb.contacts.add({
      'name': _nameController.text,
      'email': _emailController.text,
    });
    contactsDb.updateDatabase();
    Navigator.pop(context);
    // make sure reload list
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainPage(initialTabIndex: 1),
      ),
    );
  }

  // preset error alert
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => CommonAlertDialog(
        title: const Text("Error",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
        content: Text(message),
        buttonColor: Colors.red.shade200,
      ),
    );
  }
}
