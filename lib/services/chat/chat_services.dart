import 'package:chatapp/modes/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatServices {
  void createChat() {
    FirebaseFirestore.instance.collection('chat');
  }

  Stream<QuerySnapshot<Object?>> getChat() {
    final Stream<QuerySnapshot> chat = FirebaseFirestore.instance
        .collection('chat')
        .orderBy('timestamp')
        .snapshots();
    return chat;
  }

  void sendMessage(massage) {
    final CollectionReference chat =
        FirebaseFirestore.instance.collection('chat');
    chat.add(Message.create(massage).messagetomap());
  }
}
