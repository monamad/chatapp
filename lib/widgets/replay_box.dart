// ignore: file_names
import 'package:flutter/material.dart';

class ReplayBox extends StatelessWidget {
  final String reciver;
  final String replaymessage;
  final void Function() exit;
  const ReplayBox(
      {super.key,
      required this.reciver,
      required this.replaymessage,
      required this.exit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
                title: Text(replaymessage),
                trailing: IconButton(
                  onPressed: exit,
                  icon: const Icon(
                    Icons.cancel,
                    color: Colors.black,
                  ),
                )),
          ]),
    );
  }
}
