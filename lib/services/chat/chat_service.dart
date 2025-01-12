import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:minichat/models/message.dart';

class ChatService {
  // instance of firestore & auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
  Future<void> sendMessage(String receiverID, message) async {
    // get current user data
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    // create a new message
    Message newMessage = Message(
      senderID: currentUserID,
      senderEmail: currentUserEmail,
      receiverID: receiverID,
      message: message,
      timestamp: timestamp,
    );

    // create new chatRoomID for 2 users
    List<String> ids = [currentUserID, receiverID];
    ids.sort(); // to ensure chatRoomID same for the 2 users
    String chatRoomID = ids.join('_'); // e.g. "839_245"

    // add new message to database
    await _firestore
        .collection("ChatRooms")
        .doc(chatRoomID)
        .collection("message")
        .add(newMessage.toMap());
  }

  // get message
  Stream<QuerySnapshot> getMessage(String currentUserID, receiverID) {
    // construct chatRoomID
    List<String> ids = [currentUserID, receiverID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return _firestore
        .collection("ChatRooms")
        .doc(chatRoomID)
        .collection("message")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
