import 'package:chatapp/modes/user.dart';
import 'package:chatapp/pages/chat_page.dart';
import 'package:chatapp/pages/group_page.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FriendBox extends StatelessWidget {
  Users reciver;
  FriendBox({super.key, required this.reciver});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 4, right: 4),
      child: ListTile(
        onTap: () {
          if (reciver.name == 'بطاطا كونية') {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return GroupPage(reciver: reciver);
            }));
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ChatPage(
                reciver: reciver,
              );
            }));
          }
        },
        title: Text(reciver.name),
        trailing: const Icon(
          Icons.arrow_forward,
          color: Colors.black,
        ),
      ),
    );
  }
}
