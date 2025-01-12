import 'package:flutter/material.dart';
import 'package:minichat/pages/main_page.dart';
import 'package:minichat/widgets/item/user_tile.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      // contacts page title
      appBar: AppBar(
        title: Transform.scale(
          scale: 1.2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              Icon(Icons.contacts_rounded, color: theme.primary),
              Text(
                "Contacts",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: theme.primary),
              ),
            ],
          ),
        ),
      ),

      // show contact list
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // build contact list
          Expanded(child: _buildContactList()),

          // add contact button
          Padding(
            padding: const EdgeInsets.only(bottom: 120, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    // TODO: create add_contact_page.dart
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainPage()),
                    );
                  },
                  backgroundColor: theme.onPrimary,
                  foregroundColor: theme.primary,
                  child: Icon(Icons.person_add_rounded),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildContactList() {
    // TODO: load contact list using streambuilder from hive box
    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 20, left: 5, right: 5),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return _buildContactItem();
        },
        itemCount: 30,
      ),
    );
  }

  Widget _buildContactItem() {
    // TODO: load individual contact data
    return UserTile(
      text: "data",
      onTap: () {},
    );
  }
}
