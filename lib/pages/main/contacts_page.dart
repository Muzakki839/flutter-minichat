import 'package:flutter/material.dart';
import 'package:minichat/main.dart';
import 'package:minichat/pages/content/add_contact_page.dart';
import 'package:minichat/widgets/item/user_tile.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  // get initiated contactsDb
  final contactsDb = MyApp.contactsData;

  // sort alphabetically
  void sortContacts() {
    contactsDb.contacts.sort(
      (a, b) => a['name'].toLowerCase().compareTo(b['name'].toLowerCase()),
    );
  }

  @override
  void initState() {
    sortContacts();
    super.initState();
  }

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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddContactPage()),
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
    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 20, left: 5, right: 5),
      child: ListView.builder(
        itemCount: contactsDb.contacts.length,
        itemBuilder: (context, index) =>
            _buildContactItem(contactsDb.contacts[index]['name']),
      ),
    );
  }

  Widget _buildContactItem(String name) {
    // TODO: load individual contact data
    return UserTile(
      text: name,
      onTap: () {},
    );
  }
}
