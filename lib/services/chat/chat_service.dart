import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  // instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get user stream
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    // map each user list to users dictionary
    return _firestore.collection("Users").snapshots().map((snapshot) {
      // find each individual user and return it as a user data list
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  // send message

  // get message
}
