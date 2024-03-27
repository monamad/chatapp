import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Message {
  String message;
  dynamic timestamp;
  String senderId;
  String senderName;
  Message({
    required this.senderName,
    required this.senderId,
    required this.message,
    required this.timestamp,
  });
  factory Message.create(String message) {
    return Message(
        message: message,
        senderId: FirebaseAuth.instance.currentUser!.uid,
        senderName: FirebaseAuth.instance.currentUser!.displayName!,
        timestamp: FieldValue.serverTimestamp());
  }
  factory Message.get(Map<String, dynamic> data) {
    return Message(
        message: data['message'],
        senderId: data['senderId'],
        senderName: data['senderName'],
        timestamp: data['timestamp']);
  }

  Map<String, dynamic> messagetomap() {
    return {
      'message': message,
      'timestamp': timestamp,
      'senderId': senderId,
      'senderName': senderName,
    };
  }
}
