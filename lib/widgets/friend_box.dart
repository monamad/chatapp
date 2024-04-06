import 'package:chatapp/pages/chat_page.dart';
import 'package:chatapp/services/chat/chat_services.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FriendBox extends StatelessWidget {
  String name;
  String email;
  FriendBox({super.key, required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 4, right: 4),
      child: ListTile(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ChatPage(
              reciver: email,
            );
          }));
        },
        title: Text(name),
        trailing: const Icon(
          Icons.arrow_forward,
          color: Colors.black,
        ),
      ),
    );
  }
}
