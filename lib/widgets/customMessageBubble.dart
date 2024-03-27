import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:chatapp/modes/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomMessageBubble extends StatelessWidget {
  Message message;

  CustomMessageBubble(this.message);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: (message.senderId == FirebaseAuth.instance.currentUser!.uid)
          ? BubbleNormal(
              seen: true,
              text: message.message,
              isSender:
                  (FirebaseAuth.instance.currentUser!.uid == message.senderId),
              color: const Color(0xFF1B97F3),
              tail: true,
              textStyle: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ))
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    message.senderName,
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
                BubbleNormal(
                    seen: true,
                    text: message.message,
                    isSender: (FirebaseAuth.instance.currentUser!.uid ==
                        message.senderId),
                    color: const Color(0xFF1B97F3),
                    tail: true,
                    textStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ))
              ],
            ),
    );
  }
}
