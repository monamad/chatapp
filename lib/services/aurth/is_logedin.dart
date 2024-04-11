import 'package:chatapp/pages/friends_page.dart';
import 'package:chatapp/services/aurth/login_or_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authgate extends StatelessWidget {
  const Authgate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return FriendsPage();
          } else {
            return const LoginOrRegister();
          }
        });
  }
}
