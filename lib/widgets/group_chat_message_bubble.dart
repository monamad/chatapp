import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:chatapp/modes/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GroupMessageBubble extends StatelessWidget {
  Message message;

  GroupMessageBubble(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return (message.replayedfor == null)
        ? (FirebaseAuth.instance.currentUser!.uid != message.senderId)
            ? Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Column(
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
                        //seen: true,
                        text: message.message,
                        isSender: (FirebaseAuth.instance.currentUser!.uid ==
                            message.senderId),
                        color: const Color.fromARGB(255, 103, 27, 243),
                        tail: true,
                        textStyle: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        )),
                  ],
                ),
              )
            : BubbleNormal(
                //seen: true,
                text: message.message,
                isSender: (FirebaseAuth.instance.currentUser!.uid ==
                    message.senderId),
                color: const Color.fromARGB(255, 103, 27, 243),
                tail: true,
                textStyle: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ))
        : (FirebaseAuth.instance.currentUser!.uid == message.senderId)
            ? Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      width: double.infinity,
                      height: 79,
                      child: Opacity(
                        opacity: 0.3,
                        child: BubbleNormal(
                            //seen: true,
                            text: message.replayedfor!,
                            isSender: (FirebaseAuth.instance.currentUser!.uid ==
                                message.senderId),
                            color: const Color(0xFF1B97F3),
                            tail: false,
                            textStyle: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            )),
                      ),
                    ),
                    Positioned.fill(
                        child: Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Container(
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 103, 27, 243),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 22, right: 9, top: 8, bottom: 0),
                            child: Text(
                              message.message,
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ))
                  ],
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
                  Stack(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        width: double.infinity,
                        //height: 110,
                        child: Opacity(
                          opacity: 0.4,
                          child: BubbleNormal(
                              //seen: true,
                              text: message.replayedfor!,
                              isSender:
                                  (FirebaseAuth.instance.currentUser!.uid ==
                                      message.senderId),
                              color: const Color(0xFF1B97F3),
                              tail: false,
                              textStyle: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      Positioned.fill(
                          child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Container(
                            height: 40,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 103, 27, 243),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                  bottomRight: Radius.circular(15)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 9, right: 22, top: 6, bottom: 0),
                              child: Text(
                                message.message,
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ))
                    ],
                  ),
                ],
              );
  }
}
