// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'package:chatapp/services/aurth/authentication.dart';
import 'package:chatapp/utils/ustils.dart';
import 'package:chatapp/widgets/botton.dart';
import 'package:chatapp/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.ontap});
  static String id = 'LoginPage';
  final void Function()? ontap;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  bool isLoding = false;
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xff2B475E),
      body: Padding(
        padding: const EdgeInsets.only(right: 8, left: 8, top: 10),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: Image.asset(('lib/assets/images/scholar.png')),
              ),
              Center(
                child: Text(
                  "chatapp",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.purple[600],
                      fontFamily: "pacifico"),
                ),
              ),
              Text(
                "Login",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.purple[300],
                ),
              ),
              CustomFormTextField(
                myController: emailController,
                hint: 'Email',
                ontap: (email) {},
                isPassword: false,
              ),
              CustomFormTextField(
                myController: passwordController,
                isPassword: true,
                hint: 'password',
                ontap: (pass) {},
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: CustomButton(
                  isloding: isLoding,
                  text: 'login',
                  ontap: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        isLoding = true;
                      });

                      try {
                        await Authentication().login(
                            emailController.text, passwordController.text);
                      } on FirebaseAuthException catch (e) {
                        MyUtils.showmassage(context, e.code);
                      }
                      setState(() {
                        isLoding = false;
                      });
                    }
                  },
                ),
              ),
              Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                          text: "don't have an account  ",
                          style: TextStyle(color: Colors.white)),
                      TextSpan(
                          text: 'Sign Up ',
                          style: const TextStyle(color: Colors.purple),
                          recognizer: TapGestureRecognizer()
                            ..onTap = widget.ontap),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
