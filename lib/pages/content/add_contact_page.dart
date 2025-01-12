import 'package:flutter/material.dart';
import 'package:minichat/widgets/buttons/common_button.dart';
import 'package:minichat/widgets/fields/common_text_field.dart';

class AddContactPage extends StatelessWidget {
  const AddContactPage({super.key});

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
              onPressed: () {},
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
          Text("Nama",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
          CommonTextField(
            hintText: "' e.g. Budi '",
            inputBorder: UnderlineInputBorder(),
            controller: TextEditingController(),
          ),
          SizedBox(height: 40),
          Text("Email",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
          CommonTextField(
            hintText: "' e.g. Budi123@email.com '",
            inputBorder: UnderlineInputBorder(),
            controller: TextEditingController(),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
