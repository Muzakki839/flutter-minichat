import 'package:hive_flutter/adapters.dart';

class ContactsData {
  List<Map<String, dynamic>> contacts = [];

  // get the opened hive box
  final _dataBox = Hive.box("dataBox");

  // create dummy data
  void createInitialData() {
    contacts = [
      {
        "name": "User",
        "email": "user@example.com",
      },
      {
        "name": "Budi",
        "email": "budi@example.com",
      },
    ];
  }

  // update the db
  void updateDatabase() {
    _dataBox.put("CONTACTS", contacts);
  }

  // load data from db
  void getData() {
    contacts = _dataBox.get("CONTACTS");
  }
}
