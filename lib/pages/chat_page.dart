import 'dart:async';

import 'package:chatapp/modes/message.dart';
import 'package:chatapp/services/chat/chat_services.dart';
import 'package:chatapp/widgets/customMessageBubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChatPage extends StatelessWidget {
  String message = '';
  final FocusNode _focusNode = FocusNode();
  final _scrollController = ScrollController();
  final TextEditingController textfieldController = TextEditingController();

  ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
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
      body: StreamBuilder(
        stream: ChatServices().getChat(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (_scrollController.position.pixels >=
                  _scrollController.position.maxScrollExtent - 100) {
                _scrollController.animateTo(
                  _scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              }
            });

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(
                        top: 50,
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    controller: _scrollController,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CreateMessage(data: snapshot.data!.docs[index]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 1),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xff2B475E),
                    ),
                    child: TextField(
                      onTap: () async {
                        if (_scrollController.position.pixels >=
                            _scrollController.position.maxScrollExtent - 100) {
                          await _waitUntilDone(context);
                        }
                      },
                      autofocus: true,
                      onTapOutside: (event) {
                        _focusNode.unfocus();
                      },
                      controller: textfieldController,
                      focusNode: _focusNode,
                      onChanged: (message) {
                        this.message = message;
                      },
                      onSubmitted: (message) async {
                        sendmessage(message);
                        _focusNode.requestFocus();
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        suffix: IconButton(
                          icon: const Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            sendmessage(message);
                          },
                        ),
                        hintText: "message",
                        hintStyle: TextStyle(
                          color: Colors.purple[200],
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
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
      ChatServices().sendMessage(('رساله فاضيه'));
    } else if (message == 'كسم السيسي') {
      ChatServices().sendMessage(('انتو مش عرفين ان انتو نور عنينا ولا ايه'));
    } else {
      ChatServices().sendMessage((message));
    }
    textfieldController.clear();
  }

  Future<void> _waitUntilDone(context) async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (MediaQuery.of(context).viewInsets.bottom == 0) {
      await Future.delayed(const Duration(milliseconds: 200));
      _scrollController.jumpTo(
        _scrollController.position.maxScrollExtent,
      );
      return;
    } else {
      return _waitUntilDone(context);
    }
  }
}

// ignore: must_be_immutable
class CreateMessage extends StatelessWidget {
  dynamic data;

  CreateMessage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    Message message = Message.get(data.data());
    return CustomMessageBubble(message);
  }
}
