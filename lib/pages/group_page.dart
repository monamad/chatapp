import 'dart:async';
import 'package:chatapp/modes/message.dart';
import 'package:chatapp/modes/user.dart';
import 'package:chatapp/services/chat/chat_services.dart';
import 'package:chatapp/widgets/group_chat_message_bubble.dart';
import 'package:chatapp/widgets/replay_box.dart';
import 'package:chatapp/widgets/chatbox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';

// ignore: must_be_immutable
class GroupPage extends StatefulWidget {
  final Users reciver;

  const GroupPage({super.key, required this.reciver});

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  Message? replaymessage;
  late bool isReplayed = false;
  final FocusNode _focusNode = FocusNode();

  late final ScrollController _scrollController = ScrollController();

  final TextEditingController textfieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2B475E),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
              FirebaseAuth.instance.signOut();
            },
          )
        ],
        backgroundColor: const Color(0xff2B475E),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ('lib/assets/images/scholar.png'),
              scale: 2,
            ),
            const Text(
              " 'بطاطا كونية'",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: ChatServices().getChat(widget.reciver),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (replaymessage != null) {
                if (MediaQuery.of(context).viewInsets.bottom == 0) {
                  _focusNode.requestFocus();
                }
              } else if (_scrollController.position.pixels ==
                  _scrollController.position.minScrollExtent) {
                _scrollController
                    .jumpTo(_scrollController.position.maxScrollExtent - 3);
              } else if (_scrollController.position.pixels >=
                  _scrollController.position.maxScrollExtent - 100) {
                _scrollController.animateTo(
                  _scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                );
              }
              if (isReplayed == true) {
                replaymessage = null;
                isReplayed = false;
                _scrollController
                    .jumpTo(_scrollController.position.maxScrollExtent - 3);
              }
            });

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(
                        top: 50,
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    controller: _scrollController,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return createmessage(snapshot.data!.docs[index],
                          snapshot.data!.docs[index].id);
                    },
                  ),
                ),
                (replaymessage == null)
                    ? Chatbox(
                        controller: textfieldController,
                        onTap: () async {
                          if (_scrollController.position.pixels >=
                              _scrollController.position.maxScrollExtent -
                                  100) {
                            await solvekeyboardoverlap(context);
                          }
                        },
                        focusNode: _focusNode,
                        sendmessage: sendmessage,
                      )
                    : Column(
                        children: [
                          ReplayBox(
                              reciver: (widget.reciver.name),
                              replaymessage: replaymessage!,
                              exit: () {
                                setState(() {
                                  replaymessage = null;
                                  isReplayed = false;
                                });
                                _focusNode.unfocus();
                              }),
                          Chatbox(
                            controller: textfieldController,
                            onTap: () {},
                            focusNode: _focusNode,
                            sendmessage: sendmessage,
                          ),
                        ],
                      )
              ],
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: SizedBox(child: CircularProgressIndicator()));
          } else {
            return Text('Erorr${snapshot.hasError}');
          }
        },
      ),
    );
  }

  void sendmessage(String? message) {
    if (textfieldController.text == '') {
      ChatServices().sendMessage('رساله فاضيه', widget.reciver, replaymessage);
    } else {
      ChatServices()
          .sendMessage(textfieldController.text, widget.reciver, replaymessage);
    }
    setState(() {
      isReplayed = true;
    });
    textfieldController.clear();
  }

  Future<void> solvekeyboardoverlap(context) async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (MediaQuery.of(context).viewInsets.bottom == 0) {
      await Future.delayed(const Duration(milliseconds: 200));
      _scrollController.jumpTo(
        _scrollController.position.maxScrollExtent,
      );
      return;
    } else {
      return solvekeyboardoverlap(context);
    }
  }

  Widget createmessage(data, id) {
    // print(id);
    Message message = Message.get(data.data());
    return SwipeTo(
      onRightSwipe: (details) {
        setState(() {
          replaymessage = message;
        });

        //
      },
      child: Container(
          color: const Color(0xff2B475E), child: GroupMessageBubble(message)),
    );
  }
}
