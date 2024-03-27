import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  final String text;
  VoidCallback ontap;
  bool isloding;

  CustomButton(
      {super.key,
      required this.text,
      required this.ontap,
      required this.isloding});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 2,
      child: (isloding)
          ? Container(
              decoration: BoxDecoration(
                  color: Colors.pink[400],
                  borderRadius: BorderRadius.circular(20)),
              child: const Center(
                  child: Padding(
                padding: EdgeInsets.all(6.0),
                child: CircularProgressIndicator(),
              )),
            )
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  backgroundColor: Colors.pink[400]),
              onPressed: ontap,
              child: Text(text),
            ),
    );
  }
}
