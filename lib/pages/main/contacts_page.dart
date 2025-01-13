import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:minichat/main.dart';
import 'package:minichat/pages/content/add_contact_page.dart';
import 'package:minichat/widgets/items/user_tile.dart';
import 'package:minichat/widgets/popups/common_alert_dialog.dart';

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
    setState(() {
      contactsDb.contacts.sort(
        (a, b) => a['name'].toLowerCase().compareTo(b['name'].toLowerCase()),
      );
    });
  }

  // delete contact
  void deleteContact(int index) {
    setState(() {
      contactsDb.contacts.removeAt(index);
      contactsDb.updateDatabase();
    });
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
            _buildContactItem(contactsDb.contacts[index], context, index),
      ),
    );
  }

  Widget _buildContactItem(
    Map<String, dynamic> contact,
    BuildContext context,
    int index,
  ) {
    final theme = Theme.of(context).colorScheme;

    return Slidable(
      endActionPane: ActionPane(
        motion: StretchMotion(),
        extentRatio: 0.15,
        closeThreshold: 0.1,
        openThreshold: 0.9,
        children: [
          // slidable item
          IconButton(
            onPressed: () {
              showAdaptiveDialog(
                context: context,
                builder: (BuildContext context) {
                  return CommonAlertDialog(
                    title: Text("Delete Contact"),
                    content:
                        Text("Are you sure you want to delete this contact?"),
                    buttonColor: theme.errorContainer,
                  );
                },
              );
            },
            icon: Icon(Icons.delete_forever_rounded),
            iconSize: 30,
            color: theme.error,
          ),
        ],
      ),

      // user tile
      child: UserTile(
        text: contact['name'],
        subText: contact['email'],
        onTap: () {},
      ),
    );
  }
}
