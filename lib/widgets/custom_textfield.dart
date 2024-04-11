import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomFormTextField extends StatelessWidget {
  final String hint;
  final bool isPassword;
  Function(String) ontap;
  String? confirmedpass;
  bool? notconfirmedpass;
  final TextEditingController myController;
  CustomFormTextField(
      {super.key,
      required this.hint,
      required this.myController,
      required this.ontap,
      required this.isPassword,
      this.confirmedpass});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: TextFormField(
        scrollPadding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 12 * 4),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'this field is required';
          }
          if (isPassword == true && confirmedpass != null) {
            if (value != confirmedpass) {
              return "password are not same";
            }
          }
          return null;
        },
        controller: myController,
        onChanged: ontap,
        obscureText: isPassword,
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.purple[200]),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 1),
              borderRadius: BorderRadius.circular(12),
            )),
      ),
    );
  }
}
