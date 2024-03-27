import 'package:chatapp/services/chat/chat_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authentication extends ChangeNotifier {
  UserCredential? user = null;
  Future<String> loginuser(email, password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      user = userCredential;
      return userCredential.user!.uid;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  Future<UserCredential> signup(email, password, name) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    userCredential.user!.updateDisplayName(name);
    ChatServices().createChat();
    return userCredential;
  }
}
