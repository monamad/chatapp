import 'package:chatapp/modes/message.dart';
import 'package:flutter/material.dart';

class Chatbox extends StatelessWidget {
  String message = '';
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) sendmessage;
  final Function() onTap;
  final Function(PointerDownEvent) onTapOutside;

  Chatbox(
      {super.key,
      required this.controller,
      required this.focusNode,
      required this.onTap,
      required this.onTapOutside,
      required this.sendmessage});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 1),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xff2B475E),
          ),
          child: TextField(
            onTap: onTap,
            onTapOutside: onTapOutside,
            controller: controller,
            focusNode: focusNode,
            onChanged: (message) {
              this.message = message;
            },
            onSubmitted: (message) {
              sendmessage(message);
              focusNode.requestFocus();
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
              hintStyle: TextStyle(color: Colors.purple[200]),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ));
  }
}
