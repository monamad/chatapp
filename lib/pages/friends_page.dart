import 'package:chatapp/modes/user.dart';
import 'package:chatapp/services/chat/chat_services.dart';
import 'package:chatapp/widgets/friend_box.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FriendsPage extends StatefulWidget {
  List<Users>? friendsname;
  FriendsPage({super.key});

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  @override
  void initState() {
    getfriendslist();
    super.initState();
  }

  Future<void> getfriendslist() async {
    widget.friendsname = await ChatServices().getFriends();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return (widget.friendsname != null)
        ? Scaffold(
            backgroundColor: const Color(0xff2B475E),
            appBar: AppBar(
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                )
              ],
              automaticallyImplyLeading: false,
              backgroundColor: const Color(0xff2B475E),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    ('lib/assets/images/scholar.png'),
                    scale: 2,
                  ),
                  const Text(
                    'Chat',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              centerTitle: true,
            ),
            body: ListView.builder(
              itemCount: widget.friendsname!.length,
              itemBuilder: (BuildContext context, int index) {
                return FriendBox(
                  reciver: widget.friendsname![index],
                );
              },
            ))
        : Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    ('lib/assets/images/scholar.png'),
                    scale: .5,
                  ),
                  const CircularProgressIndicator()
                ],
              ),
            ),
          );
  }
}
