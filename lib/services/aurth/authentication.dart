import 'package:chatapp/modes/user.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  Future<void> signup(email, password, name) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      userCredential.user!.updateDisplayName(name);
      FirebaseFirestore.instance
          .collection('user')
          .add(Users(email: email, name: name).usertomap());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> login(email, password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
